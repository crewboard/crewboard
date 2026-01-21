import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'flows/flows.dart';
import 'flows/flows_controller.dart';
import 'package:frontend/globals.dart';
import 'flows/types.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:file_saver/file_saver.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:image/image.dart' as img;
import 'package:frontend/widgets/widgets.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/services/arri_client.rpc.dart';
import '../sidebar.dart';

import '../../widgets/tabs.dart';
import 'document_editor.dart';
import 'document_editor_provider.dart';

class FlowEditor extends StatefulWidget {
  const FlowEditor({super.key});

  @override
  State<FlowEditor> createState() => _FlowEditorState();
}

class _FlowEditorState extends State<FlowEditor> {
  final FlowsController controller = Get.put(FlowsController());
  final DocumentEditorProvider docProvider = Get.put(DocumentEditorProvider());
  final GlobalKey _canvasKey = GlobalKey();
  bool _exporting = false;

  @override
  void initState() {
    super.initState();
    // Initialize window dimensions
  }

  Future<void> _exportAsPng() async {
    if (controller.selectedFlowId.value.isEmpty) {
      _showSnack('Please select a flow to export');
      return;
    }
    setState(() {
      _exporting = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    String oldWindow = controller.window.value;
    bool oldShowHandles = controller.showAddHandles.value;
    try {
      controller.window.value = "";
      controller.showAddHandles.value = false;
      controller.refresh();

      await WidgetsBinding.instance.endOfFrame;
      final boundary =
          _canvasKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) {
        _showSnack('Unable to capture canvas');
        return;
      }
      const double pixelRatio = 3.0;
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        _showSnack('Failed to create image bytes');
        return;
      }
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final cropped = _cropToFlowsBounds(pngBytes, pixelRatio: pixelRatio);
      if (cropped != null) {
        pngBytes = cropped;
      }
      // Pad to square with white background for PNG export
      final squared = _padPngToSquareWhite(pngBytes);
      if (squared != null) {
        pngBytes = squared;
      }
      final String fileName = _sanitizedFlowName();
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: pngBytes,
        mimeType: MimeType.png,
        ext: 'png',
      );
      _showSnack('PNG exported');
    } catch (e) {
      _showSnack('Export failed: $e');
    } finally {
      controller.window.value = oldWindow;
      controller.showAddHandles.value = oldShowHandles;
      controller.refresh();
      if (mounted) {
        setState(() {
          _exporting = false;
        });
      }
    }
  }

  Future<void> _exportAsPdf() async {
    if (controller.selectedFlowId.value.isEmpty) {
      _showSnack('Please select a flow to export');
      return;
    }
    setState(() {
      _exporting = true;
    });
    await Future.delayed(const Duration(milliseconds: 500));
    String oldWindow = controller.window.value;
    bool oldShowHandles = controller.showAddHandles.value;
    try {
      controller.window.value = "";
      controller.showAddHandles.value = false;
      controller.refresh();

      await WidgetsBinding.instance.endOfFrame;
      final boundary =
          _canvasKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) {
        _showSnack('Unable to capture canvas');
        return;
      }
      const double pixelRatio = 3.0;
      final ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) {
        _showSnack('Failed to create image bytes');
        return;
      }
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final cropped = _cropToFlowsBounds(pngBytes, pixelRatio: pixelRatio);
      if (cropped != null) {
        pngBytes = cropped;
      }

      final doc = pw.Document();
      final imageProvider = pw.MemoryImage(pngBytes);
      doc.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4.landscape,
          build: (pw.Context context) {
            return pw.Center(
              child: pw.FittedBox(
                child: pw.Image(imageProvider),
                fit: pw.BoxFit.contain,
              ),
            );
          },
        ),
      );

      final pdfBytes = await doc.save();
      final String fileName = _sanitizedFlowName();
      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: pdfBytes,
        mimeType: MimeType.pdf,
        ext: 'pdf',
      );
      _showSnack('PDF exported');
    } catch (e) {
      _showSnack('Export failed: $e');
    } finally {
      controller.window.value = oldWindow;
      controller.showAddHandles.value = oldShowHandles;
      controller.refresh();
      if (mounted) {
        setState(() {
          _exporting = false;
        });
      }
    }
  }

  String _sanitizedFlowName() {
    try {
      String? rawName;
      final selectedId = controller.selectedFlowId.value;
      if (selectedId.isNotEmpty) {
        // final match = controller.savedFlows
        //     .whereType<FlowClass>()
        //     .firstWhereOrNull((f) => f.id == selectedId);
        // if (match != null) rawName = match.flowName;
      }
      rawName ??= 'flow_canvas';
      // Replace illegal filename characters and trim
      final sanitized = rawName
          .replaceAll(RegExp(r'[<>:"/\\|?*]+'), '-')
          .trim();
      if (sanitized.isEmpty) return 'flow_canvas';
      return sanitized;
    } catch (_) {
      return 'flow_canvas';
    }
  }

  Uint8List? _cropToFlowsBounds(
    Uint8List pngBytes, {
    required double pixelRatio,
  }) {
    try {
      if (controller.flows.isEmpty) return pngBytes;

      double minX = controller.flows
          .map((FlowClass f) => f.x)
          .fold(double.infinity, (prev, element) => math.min(prev, element));
      double minY = controller.flows
          .map((FlowClass f) => f.y)
          .fold(double.infinity, (prev, element) => math.min(prev, element));
      double maxX = controller.flows
          .map((FlowClass f) => f.x + f.width)
          .fold(
            double.negativeInfinity,
            (prev, element) => math.max(prev, element),
          );
      double maxY = controller.flows
          .map((FlowClass f) => f.y + f.height)
          .fold(
            double.negativeInfinity,
            (prev, element) => math.max(prev, element),
          );

      const double pad = 16.0;
      final double stageW = controller.stageWidth.value;
      final double stageH = controller.windowHeight.value;

      double leftF = (minX - pad).clamp(0.0, stageW);
      double topF = (minY - pad).clamp(0.0, stageH);
      double rightF = (maxX + pad).clamp(0.0, stageW);
      double bottomF = (maxY + pad).clamp(0.0, stageH);

      int left = (leftF * pixelRatio).floor();
      int top = (topF * pixelRatio).floor();
      int right = (rightF * pixelRatio).ceil();
      int bottom = (bottomF * pixelRatio).ceil();

      final img.Image? decoded = img.decodePng(pngBytes);
      if (decoded == null) return pngBytes;
      final int width = decoded.width;
      final int height = decoded.height;

      if (right <= 0 || bottom <= 0 || left >= width || top >= height) {
        return pngBytes;
      }
      left = left.clamp(0, width - 1);
      top = top.clamp(0, height - 1);
      right = right.clamp(left + 1, width);
      bottom = bottom.clamp(top + 1, height);
      final int cropWidth = right - left;
      final int cropHeight = bottom - top;
      if (cropWidth <= 1 || cropHeight <= 1) return pngBytes;

      final img.Image cropped = img.copyCrop(
        decoded,
        x: left,
        y: top,
        width: cropWidth,
        height: cropHeight,
      );
      return Uint8List.fromList(img.encodePng(cropped));
    } catch (_) {
      return pngBytes;
    }
  }

  Uint8List? _padPngToSquareWhite(Uint8List pngBytes) {
    try {
      final img.Image? decoded = img.decodePng(pngBytes);
      if (decoded == null) return pngBytes;

      final int width = decoded.width;
      final int height = decoded.height;
      if (width == height) return pngBytes;

      final int size = width > height ? width : height;
      final img.Image canvas = img.Image(width: size, height: size);
      // Fill canvas with white
      img.fill(canvas, color: img.ColorRgba8(255, 255, 255, 255));

      final int offsetX = ((size - width) / 2).floor();
      final int offsetY = ((size - height) / 2).floor();

      // Draw original in center
      img.compositeImage(canvas, decoded, dstX: offsetX, dstY: offsetY);

      return Uint8List.fromList(img.encodePng(canvas));
    } catch (_) {
      return pngBytes;
    }
  }

  void _showSnack(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays > 0) {
        return '${difference.inDays}d ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours}h ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes}m ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Sidebar for flow creation
        SideBar(
          children: [
            Obx(() {
              if (controller.sidebarMode.value == SidebarMode.apps) {
                // Apps section
                final apps = controller.apps;
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Projects",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Pallet.font3,
                                ),
                              ),
                            ),
                          ),
                          AddController(
                            showColor: true,
                            onSave: (name, color) async {
                              print('Adding app: $name, $color');
                              try {
                                // Call the addApp API
                                final response = await server.admin.addApp(
                                  AddAppParams(
                                    appId: null, // null for new app
                                    appName: name,
                                    colorId: color,
                                    action: "add",
                                  ),
                                );

                                if (response.status == 200) {
                                  // Refresh the apps list after successful addition
                                  controller.loadApps();
                                  print('App added successfully: $name');
                                } else {
                                  print('Failed to add app: ${response.status}');
                                }
                              } catch (e) {
                                print('Error adding app: $e');
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: ListView(
                          children: [
                            for (var app in apps)
                              AppListItem(
                                app: app,
                                isSelected:
                                    app.id == controller.selectedAppId.value,
                                onTap: () => controller.selectApp(app.id),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                // Flows section
                return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Row(
                        children: [
                          IconButton(
                            onPressed: controller.backToApps,
                            icon: Icon(Icons.arrow_back, color: Pallet.font3),
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Obx(() {
                              final heading = controller.currentSubPage.value == FlowSubPage.docs ? "Docs" : "Flows";
                              return Text(
                                heading,
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Pallet.font3,
                                ),
                              );
                            }),
                          ),
                          Obx(() {
                            final FlowsController flowsController = Get.find<FlowsController>();
                            return Tabs(
                              tabs: [
                                TabItem(
                                  label: "Docs",
                                  value: "docs",
                                  isSelected: flowsController.currentSubPage.value == FlowSubPage.docs,
                                ),
                                TabItem(
                                  label: "Flows",
                                  value: "flows",
                                  isSelected: flowsController.currentSubPage.value == FlowSubPage.flows,
                                ),
                              ],
                              onTabChanged: (value) => flowsController.changeSubPage(value),
                            );
                          }),
                          SizedBox(width: 10),
                          AddController(
                            onSave: (value) {
                              if (flowsController.currentSubPage.value == FlowSubPage.docs) {
                                docProvider.addDoc(controller.selectedAppId.value, value);
                              } else {
                                controller.createFlow(value);
                              }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Expanded(
                        child: Obx(() {
                          if (controller.currentSubPage.value == FlowSubPage.docs) {
                            // Docs view for flows
                            return Obx(() {
                              if (docProvider.isLoadingDocs.value) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }

                              if (docProvider.savedDocs.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No saved docs",
                                    style: TextStyle(
                                      color: Pallet.font3,
                                      fontSize: 12,
                                    ),
                                  ),
                                );
                              }

                              return ListView.builder(
                                itemCount: docProvider.savedDocs.length,
                                itemBuilder: (context, index) {
                                  final doc = docProvider.savedDocs[index];
                                  return Obx(() {
                                    final bool isSelected =
                                        docProvider.selectedDocId.value == doc.id;
                                    return InkWell(
                                      onTap: () {
                                        docProvider.loadDoc(doc);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        margin: const EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Pallet.inside2
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(8),
                                          border: Border.all(
                                            color: isSelected
                                                ? Pallet.inside3
                                                : Colors.transparent,
                                            width: 1,
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Text(
                                                doc.name,
                                                style: TextStyle(
                                                  color: Pallet.font2,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Icon(
                                              Icons.arrow_forward_ios,
                                              color: Pallet.font3,
                                              size: 12,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                                },
                              );
                            });
                          }

                          if (controller.isLoadingFlows.value) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (controller.savedFlows.isEmpty) {
                            return Center(
                              child: Text(
                                "No saved flows",
                                style: TextStyle(
                                  color: Pallet.font3,
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }

                          return ListView.builder(
                            itemCount: controller.savedFlows.length,
                            itemBuilder: (context, index) {
                              final flow = controller.savedFlows[index];
                              return Obx(() {
                                final bool isSelected =
                                    controller.selectedFlowId.value == flow.id;
                                return InkWell(
                                  onTap: () {
                                    controller.selectedFlowId.value = flow.id;
                                    controller.loadFlow(flow.id);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 4,
                                    ),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? Pallet.inside2
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected
                                            ? Pallet.inside3
                                            : Colors.transparent,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          flow.flowName,
                                          style: TextStyle(
                                            color: Pallet.font2,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Pallet.font3,
                                          size: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                );
              }
            }),
          ],
        ),
        // Main flow editor area
        Expanded(
          child: Obx(() {
            if (controller.currentSubPage.value == FlowSubPage.docs) {
              // Always show DocumentEditor, but pass the selectedDocId as a key
              return DocumentEditor(key: ValueKey(docProvider.selectedDocId.value));
            } else {
              // Show flow canvas when flows tab is selected
              return RepaintBoundary(
                key: _canvasKey,
                child: Container(
                  // color: _exporting ? Colors.transparentbackground,
                  child: Stack(
                    children: [
                      // Flow canvas
                      const Flows(),
                    ],
                  ),
                ),
              );
            }
          }),
        ),
      ],
    );
  }
}
