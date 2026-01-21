// <same imports as before>
import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:frontend/widgets/document/quill_delta.dart';
import 'package:frontend/widgets/document_dropdown.dart';
import 'package:frontend/widgets/glass_morph.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;

import '../../globals.dart';
import '../../widgets/document/flutter_quill.dart';
import '../../backend/server.dart';
import '../../services/arri_client.rpc.dart' as rpc;
import 'flows/flows_controller.dart';
import 'document_editor_provider.dart';
import 'widgets.dart';

class DocumentEditor extends StatefulWidget {
  const DocumentEditor({super.key});

  @override
  State<DocumentEditor> createState() => _DocumentEditorState();
}

class _DocumentEditorState extends State<DocumentEditor> {
  final FlowsController controller = Get.find<FlowsController>();
  final DocumentEditorProvider provider = Get.find<DocumentEditorProvider>();

  // LayerLink + key for composited transform (preferred approach)
  final LayerLink _editorLayerLink = LayerLink();
  final GlobalKey _editorKey = GlobalKey();

  OverlayEntry? _flowOverlayEntry;
  Offset? _lastOverlayOffset;
  VoidCallback? _controllerListener;

  @override
  void initState() {
    super.initState();

    // Load document when selected
    ever(provider.selectedDocId, (String docId) async {
      if (docId.isNotEmpty) {
        // Document loading handled in provider
      }
    });

    // Listener to update overlay while caret/selection changes
    _controllerListener = () {
      if (!mounted) return;
      if (provider.showFlowOverlay.value && provider.overlayFlows.isNotEmpty) {
        _showOrUpdateFlowOverlay();
      } else {
        _hideFlowOverlay();
      }
    };
    provider.quillController.addListener(_controllerListener!);

    // Watch provider flag
    ever(provider.showFlowOverlay, (val) {
      if (!mounted) return;
      if (val == true && provider.overlayFlows.isNotEmpty) {
        _showOrUpdateFlowOverlay();
      } else {
        _hideFlowOverlay();
      }
    });
  }

  @override
  void dispose() {
    _hideFlowOverlay();
    if (_controllerListener != null) {
      try {
        provider.quillController.removeListener(_controllerListener!);
      } catch (_) {}
    }
    super.dispose();
  }

  // ---------- font/toolbar/other logic moved to provider ----------

  KeyEventResult _handleKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyP &&
        HardwareKeyboard.instance.isControlPressed) {
      _insertBulletPoint();
      return KeyEventResult.handled;
    }

    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.tab) {
      provider.cycleFontPreset();
      return KeyEventResult.handled;
    }

    if (provider.showFlowOverlay.value) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          provider.dismissFlowOverlay();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          if (provider.overlayFlows.isNotEmpty) {
            provider.selectFlow(provider.overlayFlows.first);
            return KeyEventResult.handled;
          }
        }
      }
    }

    return KeyEventResult.ignored;
  }

  void _insertBulletPoint() {
    provider.insertBulletPoint();
  }

  Future<void> _saveDocument() async {
    provider.saveDocument();
  }

  Future<void> _loadDocumentFromProvider() async {
    provider.loadDocumentFromProvider();
  }

  void _toggleH2Expansion(int position) {
    provider.toggleH2Expansion(position);
  }

  void _jumpToHeading(int position) {
    final max = provider.editorScrollController.hasClients
        ? provider.editorScrollController.position.maxScrollExtent
        : 0.0;
    provider.editorScrollController.animateTo(
      position.toDouble().clamp(0.0, max),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // ---------- RenderEditable finding helpers (safe with mounted checks) ----------

  /// Search for a RenderEditable starting from our editor key's RenderObject.
  RenderEditable? _findRenderEditableUnderEditor() {
    if (!mounted) return null;
    final targetContext = _editorKey.currentContext;
    if (targetContext == null) return null;
    final root = targetContext.findRenderObject();
    if (root == null) return null;

    RenderEditable? found;
    void search(RenderObject node) {
      if (found != null) return;
      if (node is RenderEditable) {
        found = node;
        return;
      }
      node.visitChildren(search);
    }

    search(root);
    return found;
  }

  /// Search the entire render tree for any RenderEditable (fallback).
  RenderEditable? _findAnyRenderEditable() {
    if (!mounted) return null;
    final root = context.findRenderObject();
    if (root == null) return null;

    RenderEditable? found;
    void search(RenderObject node) {
      if (found != null) return;
      if (node is RenderEditable) {
        found = node;
        return;
      }
      node.visitChildren(search);
    }

    search(root);
    return found;
  }

  /// Compute caret info (tries target-local first, then global fallback).
  /// Returns a Map:
  /// {
  ///   'useFollower': bool,
  ///   'offset': Offset?,   // target-local for follower
  ///   'global': Offset?,   // global fallback
  /// }
  Map<String, dynamic> _getCaretPositionInfo({double verticalPadding = 6.0}) {
    if (!mounted) return {'useFollower': false, 'offset': null, 'global': null};

    try {
      final selection = provider.quillController.selection;
      final baseOffset = selection.baseOffset;
      if (baseOffset == -1) {
        return {'useFollower': false, 'offset': null, 'global': null};
      }

      // Try preferred approach: find RenderEditable under the editor key
      final targetContext = _editorKey.currentContext;
      if (targetContext != null && mounted) {
        final RenderBox targetBox =
            targetContext.findRenderObject() as RenderBox;
        final RenderEditable? editable = _findRenderEditableUnderEditor();

        // --------------------
        // TextPainter fallback (best-effort estimation)
        // --------------------
        try {
          // Plain text from the document (may differ from rendered rich text, but OK as fallback)
          final fullText = provider.quillController.document.toPlainText();
          final int safeBase = baseOffset.clamp(0, fullText.length);

          // Determine style from current font settings (fallback to 14)
          final double fontSize =
              double.tryParse(provider.fontSettings.value.fontSize) ?? 14.0;
          final String fontFamily = provider.fontSettings.value.fontFamily;
          final TextStyle style = GoogleFonts.getFont(
            fontFamily,
          ).copyWith(fontSize: fontSize);

          // Use the same padding as your QuillEditor config (you used padding: EdgeInsets.all(16))
          const double editorPadding = 16.0;

          // compute maxWidth available for text inside the editor box
          final double maxWidth = (targetBox.size.width - editorPadding * 2)
              .clamp(0.0, double.infinity);

          final TextSpan span = TextSpan(text: fullText, style: style);
          final TextPainter tp = TextPainter(
            text: span,
            textDirection: TextDirection.ltr,
            textAlign: TextAlign.left,
            maxLines: null,
          );

          tp.layout(minWidth: 0, maxWidth: maxWidth);

          final TextPosition textPosition = TextPosition(offset: safeBase);
          final Offset caretOffsetLocal = tp.getOffsetForCaret(
            textPosition,
            Rect.zero,
          );

          // Heuristic: place overlay below the caret line
          final double lineHeight = tp.preferredLineHeight;
          final Offset caretLocalPoint =
              caretOffsetLocal +
              Offset(editorPadding, lineHeight + verticalPadding);

          // caretLocalPoint is already in target-local coordinates (relative to targetBox)
          final Offset caretGlobal = targetBox.localToGlobal(caretLocalPoint);

          // debugPrint('TextPainter fallback -> caretLocalPoint: $caretLocalPoint, caretGlobal: $caretGlobal, targetSize: ${targetBox.size}');

          return {
            'useFollower': true,
            'offset': caretLocalPoint,
            'global': caretGlobal,
          };
        } catch (e, st) {
          // If TextPainter fails, we continue to global RenderEditable fallback below
          debugPrint('TextPainter fallback failed: $e\n$st');
        }
      }

      // Nothing found
      return {'useFollower': false, 'offset': null, 'global': null};
    } catch (e, st) {
      debugPrint('Error _getCaretPositionInfo: $e\n$st');
      return {'useFollower': false, 'offset': null, 'global': null};
    }
  }

  // ---------- Overlay creation/update with mounted-safe checks ----------

  void _showOrUpdateFlowOverlay() {
    if (!mounted) return;

    // ensure caret/layout is stable
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return; // guard: state may have been disposed while waiting
      final info = _getCaretPositionInfo();
      final useFollower = info['useFollower'] as bool;
      Offset? followerOffset = info['offset'] as Offset?;

      final Offset? global = info['global'] as Offset?;
      followerOffset = Offset((followerOffset?.dx ?? 0) - 10, (followerOffset?.dy ?? 0) + 18);
      // debug:
      debugPrint(
        'overlay info -> useFollower: $useFollower, followerOffset: $followerOffset, global: $global',
      );

      if (!useFollower && global == null) {
        // can't compute position; hide overlay
        _hideFlowOverlay();
        return;
      }

      // Avoid unnecessary rebuilds if position didn't change much
      final newPos = useFollower ? followerOffset : global;
      if (newPos == null) {
        _hideFlowOverlay();
        return;
      }
      if (_lastOverlayOffset != null &&
          (_lastOverlayOffset! - newPos).distance < 1.0) {
        return;
      }
      _lastOverlayOffset = newPos;

      // remove existing overlay
      _flowOverlayEntry?.remove();

      if (useFollower && followerOffset != null) {
        // Preferred: CompositedTransformFollower (relative to _editorLayerLink)
        _flowOverlayEntry = OverlayEntry(
          builder: (context) {
            return CompositedTransformFollower(
              link: _editorLayerLink,
              showWhenUnlinked: false,
              offset: followerOffset!,
              child: _buildOverlayBox(),
            );
          },
        );

        if (mounted) {
          Overlay.of(context)?.insert(_flowOverlayEntry!);
        }
        return;
      }
    });
  }

  Widget _buildOverlayBox() {
    return Material(
      color: Colors.transparent,
      elevation: 0,
      borderRadius: BorderRadius.circular(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GlassMorph(
            width: 200,
            borderRadius: 8,
            // constraints: const BoxConstraints(maxHeight: 200),
            // decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(8),
              // border: Border.all(color: Pallet.divider),
            // ),
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: provider.overlayFlows.length,
                itemBuilder: (context, index) {
                  final flow = provider.overlayFlows[index];
                  return GestureDetector(
                    onTap: () {
                      provider.selectFlow(flow);
                      _hideFlowOverlay();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      child: Text(
                        flow.flowName,
                        style: TextStyle(color: Pallet.font2, fontSize: 14),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _hideFlowOverlay() {
    _flowOverlayEntry?.remove();
    _flowOverlayEntry = null;
    _lastOverlayOffset = null;
  }

  // ---------- outline + styles unchanged ----------
  List<HeadingItem> _getVisibleOutline() {
    final List<HeadingItem> visible = [];

    void addHeading(HeadingItem heading) {
      visible.add(heading);
      if (heading.level == 1 || heading.isExpanded.value) {
        for (final child in heading.children) {
          addHeading(child);
        }
      }
    }

    for (final heading in provider.outline) {
      addHeading(heading);
    }

    return visible;
  }

  String _currentFontFamily() {
    return provider.currentFontFamily();
  }

  DefaultStyles _buildCustomStyles() {
    final family = _currentFontFamily();
    final h1 = provider.editorFontSettings['Heading']!;
    final h2 = provider.editorFontSettings['Title']!;
    final h3 = provider.editorFontSettings['Subtitle']!;
    final p = provider.editorFontSettings['Body']!;

    return DefaultStyles(
      h1: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h1.styleSize ?? 30.0,
          fontWeight: h1.weight ?? FontWeight.bold,
          color: Pallet.font2,
          fontFamily: family,
        ),
        HorizontalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        null,
      ),
      h2: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h2.styleSize ?? 24.0,
          fontWeight: h2.weight ?? FontWeight.w600,
          color: Pallet.font2,
          fontFamily: family,
        ),
        HorizontalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        null,
      ),
      h3: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h3.styleSize ?? 20.0,
          fontWeight: h3.weight ?? FontWeight.w500,
          color: Pallet.font2,
          fontFamily: family,
        ),
        HorizontalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        null,
      ),
      paragraph: DefaultTextBlockStyle(
        GoogleFonts.getFont(
          provider.fontSettings.value.fontFamily,
        ).copyWith(fontSize: p.styleSize ?? 14.0, color: Pallet.font2),
        HorizontalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        VerticalSpacing(0.0, 0.0),
        null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GlassMorph(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Obx(() {
        if (provider.selectedDocId.value.isEmpty) {
          return Container(
            height: 400,
            child: Center(
              child: Text(
                "Select a document to start editing",
                style: TextStyle(color: Pallet.font3, fontSize: 14),
              ),
            ),
          );
        }

        return Column(
          children: [
            // toolbar (kept exactly as you had)
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Pallet.inside1,
                border: Border(bottom: BorderSide(color: Pallet.divider)),
              ),
              child: Row(
                children: [
                  DocumentDropdown(
                    value: provider.fontSettings.value.preset,
                    items: const [
                      'Heading',
                      'Title',
                      'Subtitle',
                      'Body',
                      'Custom...',
                    ],
                    onChanged: (value) {
                      if (value == 'Custom...') {
                        showCustomFontDialog(context, provider);
                      } else {
                        provider.applyFontPreset(value);
                      }
                    },
                  ),
                  const SizedBox(width: 16),

                  DocumentDropdown(
                    value: provider.fontSettings.value.fontFamily,
                    items: provider.availableFonts,
                    onChanged: (value) {
                      final newFamily = value;
                      final sizeForFamily =
                          provider.editorFontSettings[newFamily]?.fontSize ??
                          provider.fontSettings.value.fontSize;
                      provider.editorFontSettings[newFamily] =
                          (provider.editorFontSettings[newFamily] ??
                                  FontSettings(fontFamily: newFamily))
                              .copyWith(fontSize: sizeForFamily);

                      provider.fontSettings.value = provider.fontSettings.value
                          .copyWith(
                            fontFamily: newFamily,
                            fontSize: sizeForFamily,
                          );
                      provider.fontSizeController.text = sizeForFamily;

                      provider.quillController.formatSelection(
                        Attribute.fromKeyValue(Attribute.font.key, newFamily),
                      );
                      provider.quillController.formatSelection(
                        Attribute.fromKeyValue(
                          Attribute.size.key,
                          sizeForFamily,
                        ),
                      );
                    },
                    fontFamily: _currentFontFamily(),
                  ),

                  const SizedBox(width: 16),

                  // ... font size UI, formatting buttons, etc. (unchanged)
                ],
              ),
            ),

            // Editor content
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Pallet.divider, width: 1),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    child: Column(
                      children: [
                        Expanded(
                          child: Obx(
                            () => ListView.builder(
                              itemCount: _getVisibleOutline().length,
                              itemBuilder: (context, index) {
                                final heading = _getVisibleOutline()[index];
                                final isH2 = heading.level == 2;
                                final isExpanded = heading.isExpanded;

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 0,
                                  ),
                                  child: InkWell(
                                    onTap: () => isH2
                                        ? _toggleH2Expansion(heading.position)
                                        : _jumpToHeading(heading.position),
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: (heading.level - 1) * 12.0,
                                        top: 4,
                                        bottom: 4,
                                        right: 8,
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              heading.text,
                                              style: TextStyle(
                                                color: Pallet.font2,
                                                fontSize: heading.fontSize,
                                                fontWeight: heading.fontWeight,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          if (isH2)
                                            Icon(
                                              isExpanded.value
                                                  ? Icons.expand_more
                                                  : Icons.chevron_right,
                                              size: 16,
                                              color: Pallet.font3,
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          // CompositedTransformTarget anchors the editor
                          CompositedTransformTarget(
                            link: _editorLayerLink,
                            child: Container(
                              key: _editorKey,
                              child: QuillEditor(
                                focusNode: provider.editorFocusNode,
                                scrollController:
                                    provider.editorScrollController,
                                controller: provider.quillController,
                                config: QuillEditorConfig(
                                  placeholder: 'Start writing your notes...',
                                  padding: const EdgeInsets.all(16),
                                  customStyles: _buildCustomStyles(),
                                  embedBuilders: [],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
