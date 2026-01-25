import 'package:crewboard_flutter/widgets/document/src/document/attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/document/src/editor/embed/local_embed_builders.dart';
import '../../widgets/document/src/common/structs/horizontal_spacing.dart';
import '../../widgets/document/src/common/structs/vertical_spacing.dart';
import '../../widgets/document/src/editor/config/editor_config.dart';
import '../../widgets/document/src/editor/editor.dart';
import '../../widgets/document/src/editor/widgets/default_styles.dart';
import 'document_editor_provider.dart';
import '../../config/palette.dart';
import '../../widgets/glass_morph.dart';
import '../../widgets/document_dropdown.dart';
import '../../widgets/font_family_search_dropdown.dart';
import '../../../widgets/widgets.dart';
import '../../widgets/font_size_editor.dart';


class DocumentEditor extends StatefulWidget {
  const DocumentEditor({super.key});

  @override
  State<DocumentEditor> createState() => _DocumentEditorState();
}

class _DocumentEditorState extends State<DocumentEditor> {
  // LayerLink for flow overlay
  final LayerLink _editorLayerLink = LayerLink();
  final GlobalKey _editorKey = GlobalKey();

  OverlayEntry? _flowOverlayEntry;
  Offset? _lastOverlayOffset;
  VoidCallback? _controllerListener;

  final DocumentEditorProvider provider = Get.find<DocumentEditorProvider>();

  @override
  void initState() {
    super.initState();

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
      provider.quillController.removeListener(_controllerListener!);
    }
    super.dispose();
  }

  // ---------- Overlay creation/update logic ----------

  Map<String, dynamic> _getCaretPositionInfo({double verticalPadding = 6.0}) {
    if (!mounted) return {'useFollower': false, 'offset': null, 'global': null};

    try {
      final selection = provider.quillController.selection;
      final baseOffset = selection.baseOffset;
      if (baseOffset == -1) {
        return {'useFollower': false, 'offset': null, 'global': null};
      }

      final targetContext = _editorKey.currentContext;
      if (targetContext != null && mounted) {
        final RenderBox targetBox =
            targetContext.findRenderObject() as RenderBox;

        // TextPainter fallback
        try {
          final fullText = provider.quillController.document.toPlainText();
          final int safeBase = baseOffset.clamp(0, fullText.length);

          final double fontSize =
              double.tryParse(provider.fontSettings.value.fontSize) ?? 14.0;
          final String fontFamily = provider.fontSettings.value.fontFamily;
          final TextStyle style = _safeGoogleFont(
            fontFamily,
          ).copyWith(fontSize: fontSize);

          const double editorPadding = 16.0;
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

          final double lineHeight = tp.preferredLineHeight;
          final Offset caretLocalPoint =
              caretOffsetLocal +
              Offset(editorPadding, lineHeight + verticalPadding);

          final Offset caretGlobal = targetBox.localToGlobal(caretLocalPoint);

          return {
            'useFollower': true,
            'offset': caretLocalPoint,
            'global': caretGlobal,
          };
        } catch (e) {
          print('TextPainter fallback failed: $e');
        }
      }
      return {'useFollower': false, 'offset': null, 'global': null};
    } catch (e) {
      return {'useFollower': false, 'offset': null, 'global': null};
    }
  }

  void _showOrUpdateFlowOverlay() {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final info = _getCaretPositionInfo();
      final useFollower = info['useFollower'] as bool;
      Offset? followerOffset = info['offset'] as Offset?;
      final Offset? global = info['global'] as Offset?;

      // Adjustment
      followerOffset = Offset(
        (followerOffset?.dx ?? 0) - 10,
        (followerOffset?.dy ?? 0) + 18,
      );

      if (!useFollower && global == null) {
        _hideFlowOverlay();
        return;
      }

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

      _flowOverlayEntry?.remove();

      if (useFollower && followerOffset != null) {
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
          Overlay.of(context).insert(_flowOverlayEntry!);
        }
        return;
      }
    });
  }

  void _hideFlowOverlay() {
    _flowOverlayEntry?.remove();
    _flowOverlayEntry = null;
    _lastOverlayOffset = null;
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
            child: Obx(
              () => ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: provider.overlayFlows.length,
                itemBuilder: (context, index) {
                  final flow = provider.overlayFlows[index];
                  return InkWell(
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
                        flow.name,
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

  // ---------- Styles ----------
  
  TextStyle _safeGoogleFont(String fontFamily, {TextStyle? textStyle}) {
    try {
      return GoogleFonts.getFont(fontFamily, textStyle: textStyle);
    } catch (_) {
      return (textStyle ?? const TextStyle()).copyWith(fontFamily: fontFamily);
    }
  }

  DefaultStyles _buildCustomStyles(double? lineHeight) {
    final family = provider.currentFontFamily();
    final h1 = provider.getSettingsForLevel(1);
    final h2 = provider.getSettingsForLevel(2);
    final h3 = provider.getSettingsForLevel(3);
    final p = provider.getSettingsForLevel(0);

    // Use a safe fallback for line height if the provided one is null or anomalous
    final safeLineHeight = (lineHeight == null || lineHeight > 5.0) ? 1.5 : lineHeight;

    return DefaultStyles(
      h1: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h1.styleSize ?? 30.0,
          fontWeight: h1.weight ?? FontWeight.bold,
          color: Pallet.font2,
          fontFamily: family,
          height: h1.lineHeight ?? safeLineHeight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        const HorizontalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        null,
      ),
      h2: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h2.styleSize ?? 24.0,
          fontWeight: h2.weight ?? FontWeight.w600,
          color: Pallet.font2,
          fontFamily: family,
          height: h2.lineHeight ?? safeLineHeight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        const HorizontalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        null,
      ),
      h3: DefaultTextBlockStyle(
        TextStyle(
          fontSize: h3.styleSize ?? 20.0,
          fontWeight: h3.weight ?? FontWeight.w500,
          color: Pallet.font2,
          fontFamily: family,
          height: h3.lineHeight ?? safeLineHeight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        const HorizontalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        null,
      ),
      paragraph: DefaultTextBlockStyle(
        _safeGoogleFont(
          provider.fontSettings.value.fontFamily,
        ).copyWith(
          fontSize: p.styleSize ?? 14.0,
          color: Pallet.font2,
          height: p.lineHeight ?? safeLineHeight,
          leadingDistribution: TextLeadingDistribution.even,
        ),
        const HorizontalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        const VerticalSpacing(0.0, 0.0),
        null,
      ),
    );
  }

  // ---------- Helpers for Outline ----------

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

  void _jumpToHeading(int position) {
    if (provider.editorScrollController.hasClients) {
      // Approximate scroll to position
      // In flutter_quill, we usually don't have direct access to pixel offsets for characters easily.
      // But we can use the scroll controller and an estimated position or use a better library for this.
      // For now, let's keep it simple as in the old code which just did a jump.
      final max = provider.editorScrollController.position.maxScrollExtent;
      final ratio = position / provider.quillController.document.length;
      provider.editorScrollController.animateTo(
        (max * ratio).clamp(0.0, max),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DocumentEditorProvider>()) {
      Get.put(DocumentEditorProvider());
    }

    return Obx(() {
      if (provider.selectedDocId.value == null) {
        return SizedBox(
          height: 400,
          child: Center(
            child: Text(
              "Select a document to start editing",
              style: TextStyle(color: Pallet.font3, fontSize: 14),
            ),
          ),
        );
      }

      return GlassMorph(
        margin: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: Obx(() => Column(
          children: [
            // Toolbar
            if (provider.systemVariables.value?.showEdit ?? true)
              Container(
                height: 60,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Pallet.inside1,
                  border: Border(bottom: BorderSide(color: Pallet.divider)),
                ),
                child: Row(
                  children: [
                    // Font Presets Dropdown
                    DocumentDropdown(
                      value: provider.fontSettings.value.preset,
                      items: provider.dynamicPresets,
                      onChanged: (value) {
                        provider.applyFontPreset(value);
                      },
                    ),
                    const SizedBox(width: 16),

                    // Font Family Dropdown
                    FontFamilySearchDropdown(
                      value: provider.fontSettings.value.fontFamily,
                      items: provider.availableFonts,
                      onChanged: (value) {
                        final newFamily = value;

                        provider.fontSettings.value = provider.fontSettings.value
                            .copyWith(
                          fontFamily: newFamily,
                        );

                        final selection = provider.quillController.selection;
                        if (selection.isCollapsed) {
                          // If nothing is selected, apply to the whole line/paragraph
                          final plainText = provider.quillController.document.toPlainText();
                          final len = plainText.length;
                          int start = selection.baseOffset;
                          int end = selection.baseOffset;

                          // Find start of line
                          while (start > 0 && plainText[start - 1] != '\n') {
                            start--;
                          }

                          // Find end of line
                          while (end < len && plainText[end] != '\n') {
                            end++;
                          }

                          final length = end - start;
                          // Format the line
                          if (length > 0) {
                            provider.quillController.formatText(
                              start,
                              length,
                              Attribute.fromKeyValue(Attribute.font.key, newFamily),
                            );
                          } else {
                            // If empty line, just format selection (cursor)
                             provider.quillController.formatSelection(
                              Attribute.fromKeyValue(Attribute.font.key, newFamily),
                            );
                          }
                        } else {
                          // Normal selection behavior
                          provider.quillController.formatSelection(
                            Attribute.fromKeyValue(Attribute.font.key, newFamily),
                          );
                        }
                      },
                      fontFamily: provider.currentFontFamily(),
                    ),
                    const SizedBox(width: 16),
                    FontSizeEditor(
                      key: ValueKey('font-size-${provider.fontSettings.value.fontSize}'),
                      initialSize: double.tryParse(provider.fontSettings.value.fontSize) ?? 14.0,
                      onSizeChanged: (newSize) {
                        provider.applyFontSize(newSize);
                      },
                      showLabel: false,
                    ),
                    const SizedBox(width: 16),

                    // Line Height Editor
                    Row(
                      children: [
                        Text(
                          "Line Height:",
                          style: TextStyle(
                            fontSize: 12,
                            color: Pallet.font3,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FontSizeEditor(
                          key: ValueKey('line-height-${provider.fontSettings.value.preset}-${() {
                            final preset = provider.fontSettings.value.preset.toLowerCase();
                            final fs = provider.editorFontSettings[preset];
                            return fs?.lineHeight ?? 1.5;
                          }()}'),
                          initialSize: () {
                            final preset = provider.fontSettings.value.preset.toLowerCase();
                            final fs = provider.editorFontSettings[preset];
                            return fs?.lineHeight ?? 1.5;
                          }(),
                          onSizeChanged: (newLineHeight) {
                            final preset = provider.fontSettings.value.preset.toLowerCase();
                            final existing = provider.editorFontSettings[preset];
                            if (existing != null) {
                              provider.editorFontSettings[preset] = existing.copyWith(lineHeight: newLineHeight);
                            }
                          },
                          showLabel: false,
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),

                    AppColorPicker(
                      initialColor: provider.fontSettings.value.color,
                      onColorChanged: (hex) {
                        provider.applyColorHex(hex);
                      },
                      title: 'Text Color',
                    ),
                    const SizedBox(width: 16),


                    // Formatting buttons
                    IconButton(
                      icon: Icon(
                        Icons.format_bold,
                        color: provider.isBold.value
                            ? Colors.white
                            : Pallet.font2,
                      ),
                      onPressed: provider.toggleBold,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_italic,
                        color: provider.isItalic.value
                            ? Colors.white
                            : Pallet.font2,
                      ),
                      onPressed: provider.toggleItalic,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_underline,
                        color: provider.isUnderline.value
                            ? Colors.white
                            : Pallet.font2,
                      ),
                      onPressed: provider.toggleUnderline,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.format_list_bulleted,
                        color: provider.isBulletList.value
                            ? Colors.white
                            : Pallet.font2,
                      ),
                      onPressed: provider.insertBulletPoint,
                    ),
                  ],
                ),
              ),

            // Editor content with Outline
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Outline Sidebar
                  Container(
                    width: 250,
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: Pallet.divider, width: 1),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 5,
                    ),
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
                                    onTap: () {
                                      if (isH2) {
                                        provider.toggleH2Expansion(
                                          heading.position,
                                        );
                                      } else {
                                        _jumpToHeading(heading.position);
                                      }
                                    },
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

                  // Main Editor Area
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
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
                                  placeholder:
                                      'Start writing your notes...',
                                  padding: const EdgeInsets.all(16),
                                  customStyles: _buildCustomStyles(provider.systemVariables.value?.lineHeight),
                                  customStyleBuilder: _customStyleBuilder,
                                  embedBuilders: [
                                    const LocalImageEmbedBuilder(),
                                    const LocalVideoEmbedBuilder(),
                                    const FlowEmbedBuilder(),
                                  ],
                                    onKeyPressed: (event, node) {
                                      if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.tab) {
                                        provider.cycleFontPreset();
                                        return KeyEventResult.handled;
                                      }
                                      return null;
                                    },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      );
    });
  }

  TextStyle _customStyleBuilder(Attribute attribute) {
    if (attribute.key == Attribute.font.key) {
      if (attribute.value == null) return const TextStyle();
      try {
        return GoogleFonts.getFont(attribute.value.toString());
      } catch (_) {
        return TextStyle(fontFamily: attribute.value.toString());
      }
    } else if (attribute.key == Attribute.color.key) {
       if (attribute.value == null) return const TextStyle();
       return TextStyle(color: Color(int.parse(attribute.value.toString().replaceFirst('#', '0xff'))));
    }
    return const TextStyle();
  }
}
