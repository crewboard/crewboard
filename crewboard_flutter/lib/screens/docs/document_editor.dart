import 'package:crewboard_flutter/widgets/document/src/document/attribute.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widgets/document/src/editor/embed/local_embed_builders.dart';
import '../../widgets/document/src/common/structs/horizontal_spacing.dart';
import '../../widgets/document/src/common/structs/vertical_spacing.dart';
import '../../widgets/document/src/editor/config/editor_config.dart';
import '../../widgets/document/src/editor/editor.dart';
import '../../widgets/document/src/editor/widgets/default_styles.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'document_editor_provider.dart';
import '../../config/palette.dart';
import '../../widgets/glass_morph.dart';
import '../../widgets/document_dropdown.dart';
import '../../widgets/font_family_search_dropdown.dart';
import '../../../widgets/widgets.dart';
import '../../widgets/font_size_editor.dart';

class DocumentEditor extends ConsumerStatefulWidget {
  const DocumentEditor({super.key});

  @override
  ConsumerState<DocumentEditor> createState() => _DocumentEditorState();
}

class _DocumentEditorState extends ConsumerState<DocumentEditor> {
  // LayerLink for flow overlay
  final LayerLink _editorLayerLink = LayerLink();
  final GlobalKey _editorKey = GlobalKey();

  OverlayEntry? _flowOverlayEntry;
  Offset? _lastOverlayOffset;
  VoidCallback? _controllerListener;

  @override
  void initState() {
    super.initState();
    // We cannot access ref here easily for listeners that depend on the provider's quillController
    // unless we use Future.microtask or similar, butinitState happens before first build.
  }

  @override
  void dispose() {
    _hideFlowOverlay();
    // The listener removal needs to happen, but we need the provider.
    // In Riverpod, we usually dispose controllers in the Notifier.
    super.dispose();
  }

  // ---------- Overlay creation/update logic ----------

  Map<String, dynamic> _getCaretPositionInfo(
    DocumentEditorState state,
    DocumentEditorNotifier notifier, {
    double verticalPadding = 6.0,
  }) {
    if (!mounted) return {'useFollower': false, 'offset': null, 'global': null};

    try {
      final selection = notifier.quillController.selection;
      final baseOffset = selection.baseOffset;
      if (baseOffset == -1) {
        return {'useFollower': false, 'offset': null, 'global': null};
      }

      final targetContext = _editorKey.currentContext;
      if (targetContext != null && mounted) {
        final RenderBox targetBox =
            targetContext.findRenderObject() as RenderBox;

        try {
          final fullText = notifier.quillController.document.toPlainText();
          final int safeBase = baseOffset.clamp(0, fullText.length);

          final double fontSize =
              double.tryParse(state.fontSettings.fontSize) ?? 14.0;
          final String fontFamily = state.fontSettings.fontFamily;
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
          debugPrint('TextPainter fallback failed: $e');
        }
      }
      return {'useFollower': false, 'offset': null, 'global': null};
    } catch (e) {
      return {'useFollower': false, 'offset': null, 'global': null};
    }
  }

  void _showOrUpdateFlowOverlay(
    DocumentEditorState state,
    DocumentEditorNotifier notifier,
  ) {
    if (!mounted) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final info = _getCaretPositionInfo(state, notifier);
      final useFollower = info['useFollower'] as bool;
      Offset? followerOffset = info['offset'] as Offset?;
      final Offset? global = info['global'] as Offset?;

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
          (_lastOverlayOffset! - newPos).distance < 1.0)
        return;
      _lastOverlayOffset = newPos;

      _flowOverlayEntry?.remove();

      if (useFollower && followerOffset != null) {
        _flowOverlayEntry = OverlayEntry(
          builder: (context) {
            return CompositedTransformFollower(
              link: _editorLayerLink,
              showWhenUnlinked: false,
              offset: followerOffset!,
              child: _buildOverlayBox(state, notifier),
            );
          },
        );

        if (mounted) Overlay.of(context).insert(_flowOverlayEntry!);
      }
    });
  }

  void _hideFlowOverlay() {
    _flowOverlayEntry?.remove();
    _flowOverlayEntry = null;
    _lastOverlayOffset = null;
  }

  Widget _buildOverlayBox(
    DocumentEditorState state,
    DocumentEditorNotifier notifier,
  ) {
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
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: state.overlayFlows.length,
              itemBuilder: (context, index) {
                final flow = state.overlayFlows[index];
                return InkWell(
                  onTap: () {
                    notifier.selectFlow(flow);
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
        ],
      ),
    );
  }

  TextStyle _safeGoogleFont(String fontFamily, {TextStyle? textStyle}) {
    try {
      return GoogleFonts.getFont(fontFamily, textStyle: textStyle);
    } catch (_) {
      return (textStyle ?? const TextStyle()).copyWith(fontFamily: fontFamily);
    }
  }

  DefaultStyles _buildCustomStyles(
    DocumentEditorState state,
    double? lineHeight,
  ) {
    final family = state.fontSettings.fontFamily;

    FontSettings getFS(int level) {
      for (var pName in state.dynamicPresets) {
        final fs = state.editorFontSettings[pName.toLowerCase().trim()];
        if (fs != null) {
          int fsLevel = 0;
          if (fs.headerAttribute == Attribute.h1)
            fsLevel = 1;
          else if (fs.headerAttribute == Attribute.h2)
            fsLevel = 2;
          else if (fs.headerAttribute == Attribute.h3)
            fsLevel = 3;
          if (fsLevel == level) return fs;
        }
      }
      return const FontSettings();
    }

    final h1 = getFS(1);
    final h2 = getFS(2);
    final h3 = getFS(3);
    final p = getFS(0);

    final safeLineHeight = (lineHeight == null || lineHeight > 5.0)
        ? 1.5
        : lineHeight;

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
        _safeGoogleFont(state.fontSettings.fontFamily).copyWith(
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

  List<HeadingItem> _getVisibleOutline(DocumentEditorState state) {
    final List<HeadingItem> visible = [];
    void addHeading(HeadingItem heading) {
      visible.add(heading);
      if (heading.level == 1 || heading.isExpanded) {
        for (final child in heading.children) {
          addHeading(child);
        }
      }
    }

    for (final heading in state.outline) {
      addHeading(heading);
    }
    return visible;
  }

  void _jumpToHeading(
    DocumentEditorState state,
    DocumentEditorNotifier notifier,
    int position,
  ) {
    if (notifier.editorScrollController.hasClients) {
      final max = notifier.editorScrollController.position.maxScrollExtent;
      final ratio = position / notifier.quillController.document.length;
      notifier.editorScrollController.animateTo(
        (max * ratio).clamp(0.0, max),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(documentEditorProvider);
    final notifier = ref.read(documentEditorProvider.notifier);

    // Setup overlay listener if not already done
    if (_controllerListener == null) {
      _controllerListener = () {
        if (!mounted) return;
        final currState = ref.read(documentEditorProvider);
        if (currState.showFlowOverlay && currState.overlayFlows.isNotEmpty) {
          _showOrUpdateFlowOverlay(currState, notifier);
        } else {
          _hideFlowOverlay();
        }
      };
      notifier.quillController.addListener(_controllerListener!);
    }

    // React to showFlowOverlay changes
    ref.listen(documentEditorProvider.select((s) => s.showFlowOverlay), (
      prev,
      next,
    ) {
      if (next && state.overlayFlows.isNotEmpty) {
        _showOrUpdateFlowOverlay(state, notifier);
      } else {
        _hideFlowOverlay();
      }
    });

    if (state.selectedDocId == null) {
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
      child: Column(
        children: [
          // Toolbar
          if (state.systemVariables?.allowEdit ?? true)
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
                    value: state.fontSettings.preset,
                    items: state.dynamicPresets,
                    onChanged: (value) =>
                        notifier.selectFlow(value as FlowModel),
                  ),
                  const SizedBox(width: 16),
                  FontFamilySearchDropdown(
                    value: state.fontSettings.fontFamily,
                    items: state.availableFonts,
                    onChanged: (value) {
                      notifier.updateFontSettings({Attribute.font.key: value});
                      notifier.quillController.formatSelection(
                        Attribute.fromKeyValue(Attribute.font.key, value),
                      );
                    },
                    fontFamily: state.fontSettings.fontFamily,
                  ),
                  const SizedBox(width: 16),
                  FontSizeEditor(
                    key: ValueKey('font-size-${state.fontSettings.fontSize}'),
                    initialSize:
                        double.tryParse(state.fontSettings.fontSize) ?? 14.0,
                    onSizeChanged: (newSize) {
                      notifier.quillController.formatSelection(
                        Attribute.fromKeyValue(Attribute.size.key, newSize),
                      );
                    },
                    showLabel: false,
                  ),
                  const SizedBox(width: 16),
                  AppColorPicker(
                    initialColor: state.fontSettings.color,
                    onColorChanged: (hex) {
                      notifier.quillController.formatSelection(
                        Attribute.fromKeyValue(Attribute.color.key, hex),
                      );
                    },
                    title: 'Text Color',
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: Icon(
                      Icons.format_bold,
                      color: state.isBold ? Colors.white : Pallet.font2,
                    ),
                    onPressed: () => notifier.quillController.formatSelection(
                      Attribute.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_italic,
                      color: state.isItalic ? Colors.white : Pallet.font2,
                    ),
                    onPressed: () => notifier.quillController.formatSelection(
                      Attribute.italic,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.format_underline,
                      color: state.isUnderline ? Colors.white : Pallet.font2,
                    ),
                    onPressed: () => notifier.quillController.formatSelection(
                      Attribute.underline,
                    ),
                  ),
                ],
              ),
            ),

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
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                          bottom: 10,
                          top: 5,
                        ),
                        child: Text(
                          "Headings",
                          style: TextStyle(
                            color: Pallet.font3,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Divider(color: Pallet.divider, height: 1),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: _getVisibleOutline(state).length,
                          itemBuilder: (context, index) {
                            final heading = _getVisibleOutline(state)[index];
                            return InkWell(
                              onTap: () => _jumpToHeading(
                                state,
                                notifier,
                                heading.position,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: (heading.level - 1) * 12.0,
                                  top: 4,
                                  bottom: 4,
                                  right: 8,
                                ),
                                child: Text(
                                  heading.text,
                                  style: TextStyle(
                                    color: Pallet.font2,
                                    fontSize: heading.fontSize,
                                    fontWeight: heading.fontWeight,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: CompositedTransformTarget(
                      link: _editorLayerLink,
                      child: Container(
                        key: _editorKey,
                        child: QuillEditor(
                          focusNode: notifier.editorFocusNode,
                          scrollController: notifier.editorScrollController,
                          controller: notifier.quillController,
                          config: QuillEditorConfig(
                            placeholder: 'Start writing your notes...',
                            padding: const EdgeInsets.all(16),
                            customStyles: _buildCustomStyles(
                              state,
                              state.systemVariables?.lineHeight,
                            ),
                            embedBuilders: [
                              const LocalImageEmbedBuilder(),
                              const LocalVideoEmbedBuilder(),
                              const FlowEmbedBuilder(),
                            ],
                            onKeyPressed: (event, node) {
                              if (event is KeyDownEvent &&
                                  event.logicalKey == LogicalKeyboardKey.tab) {
                                return KeyEventResult.handled;
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
