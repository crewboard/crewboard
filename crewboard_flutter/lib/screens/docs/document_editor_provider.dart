import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_quill/quill_delta.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart'; // for client
import 'flows/flows_controller.dart'; // For FlowModel

/// Unified settings class used both for the current selection (`_fontSettings`)
/// and as an editor-style descriptor inside `_editorFontSettings`.
class FontSettings {
  // high level selection values (strings are kept to match Quill attribute values)
  final String preset; // one of 'Body', 'Heading', 'Title', 'Subtitle'
  final String fontFamily; // e.g. 'Roboto'
  final String fontSize; // stored as string (matches Quill attribute format)

  // editor-style specific values (used when FontSettings is used as a style descriptor)
  final double? styleSize; // e.g. 30.0 for h1
  final FontWeight? weight; // e.g. FontWeight.bold
  final double? spacing; // horizontal spacing value (as double)

  // new fields
  final String name; // human readable name matching the preset keys
  final dynamic
  headerAttribute; // e.g. Attribute.h1 / Attribute.h2 / null for body

  FontSettings({
    this.preset = 'Body',
    this.fontFamily = 'Roboto',
    this.fontSize = '14',
    this.styleSize,
    this.weight,
    this.spacing,
    this.name = 'Body',
    this.headerAttribute,
  });

  FontSettings copyWith({
    String? preset,
    String? fontFamily,
    String? fontSize,
    double? styleSize,
    FontWeight? weight,
    double? spacing,
    String? name,
    dynamic headerAttribute,
  }) {
    return FontSettings(
      preset: preset ?? this.preset,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      styleSize: styleSize ?? this.styleSize,
      weight: weight ?? this.weight,
      spacing: spacing ?? this.spacing,
      name: name ?? this.name,
      headerAttribute: headerAttribute ?? this.headerAttribute,
    );
  }
}

class HeadingItem {
  final String text;
  final int level; // 1 for h1, 2 for h2, 3 for h3
  final int position; // Position in the document
  final FontWeight fontWeight;
  final double fontSize;
  final RxBool isExpanded;
  final List<HeadingItem> children;

  HeadingItem({
    required this.text,
    required this.level,
    required this.position,
    required this.fontWeight,
    required this.fontSize,
    RxBool? isExpanded,
    List<HeadingItem>? children,
  }) : isExpanded = isExpanded ?? (level == 2 ? true.obs : false.obs),
       children = children ?? [];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'level': level,
      'position': position,
      'fontWeight': fontWeight.index,
      'fontSize': fontSize,
      'children': children.map((child) => child.toJson()).toList(),
    };
  }

  factory HeadingItem.fromJson(Map<String, dynamic> json) {
    return HeadingItem(
      text: json['text'],
      level: json['level'],
      position: json['position'],
      fontWeight: FontWeight.values[json['fontWeight']],
      fontSize: json['fontSize'],
      isExpanded: true.obs,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((child) => HeadingItem.fromJson(child))
              .toList() ??
          [],
    );
  }
}

class DocumentEditorProvider extends GetxController {
  // Document state - stores Delta operations as JSON Map
  final Rx<Map<String, dynamic>> documentContent = Rx<Map<String, dynamic>>({
    'ops': [],
  });

  // Editor controllers
  late final QuillController quillController;
  final FocusNode editorFocusNode = FocusNode();
  final ScrollController editorScrollController = ScrollController();
  final TextEditingController fontSizeController = TextEditingController();

  // Observable saved docs list (from API)
  final RxList<Doc> savedDocs = <Doc>[].obs;

  // Observable selected doc from sidebar
  final Rx<UuidValue?> selectedDocId = Rx<UuidValue?>(null);
  final RxString selectedDocName = "".obs;

  // Font settings: the currently selected font/preset/size in the toolbar
  final Rx<FontSettings> fontSettings = FontSettings().obs;

  // Available fonts
  final RxList<String> availableFonts = <String>[
    'Roboto',
    'Open Sans',
    'Lato',
    'Montserrat',
    'Poppins',
  ].obs;

  // Document outline
  final RxList<HeadingItem> outline = <HeadingItem>[].obs;

  // Formatting state
  final RxBool isBold = false.obs;
  final RxBool isItalic = false.obs;
  final RxBool isUnderline = false.obs;
  final RxBool isBulletList = false.obs;
  final RxBool isNumberedList = false.obs;

  // Centralized editor-style definitions keyed by preset name.
  final Map<String, FontSettings> editorFontSettings = {
    'Heading': FontSettings(
      name: 'Heading',
      preset: 'Heading',
      styleSize: 30.0,
      weight: FontWeight.bold,
      spacing: 16.0,
      headerAttribute: Attribute.h1,
    ),
    'Title': FontSettings(
      name: 'Title',
      preset: 'Title',
      styleSize: 24.0,
      weight: FontWeight.w600,
      spacing: 8.0,
      headerAttribute: Attribute.h2,
    ),
    'Subtitle': FontSettings(
      name: 'Subtitle',
      preset: 'Subtitle',
      styleSize: 20.0,
      weight: FontWeight.w500,
      spacing: 4.0,
      headerAttribute: Attribute.h3,
    ),
    'Body': FontSettings(
      name: 'Body',
      preset: 'Body',
      styleSize: 14.0,
      weight: FontWeight.normal,
      spacing: 4.0,
      headerAttribute: null,
    ),
  };

  static const List<String> presets = ['Body', 'Heading', 'Title', 'Subtitle'];

  // Observable loading state for docs
  final RxBool isLoadingDocs = false.obs;

  // Flow overlay state
  final RxBool showFlowOverlay = false.obs;
  final RxList<FlowModel> overlayFlows = <FlowModel>[].obs;
  final Rx<Offset> overlayPosition = Offset.zero.obs;
  final RxString flowQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeEditor();
  }

  @override
  void onClose() {
    quillController.dispose();
    editorScrollController.dispose();
    editorFocusNode.dispose();
    fontSizeController.dispose();
    super.onClose();
  }

  void initializeEditor() {
    quillController = QuillController.basic(
      config: QuillControllerConfig(
        clipboardConfig: QuillClipboardConfig(
          enableExternalRichPaste: true,
          onImagePaste: (imageBytes) async {
            if (!kIsWeb) {
              final newFileName =
                  'image-file-${DateTime.now().toIso8601String()}.png';
              final newPath = path.join(
                io.Directory.systemTemp.path,
                newFileName,
              );
              final file = await io.File(
                newPath,
              ).writeAsBytes(imageBytes, flush: true);
              return file.path;
            }
            return null;
          },
        ),
      ),
    );

    // Consolidated listener
    quillController.addListener(_onEditorChanged);

    // Keyboard handler
    editorFocusNode.onKey = _handleKey;

    // Init font size controller and ensure current family has an entry in _editorFontSettings
    fontSizeController.text = fontSettings.value.fontSize;
    editorFontSettings[fontSettings.value.fontFamily] =
        (editorFontSettings[fontSettings.value.fontFamily] ??
                FontSettings(fontFamily: fontSettings.value.fontFamily))
            .copyWith(fontSize: fontSettings.value.fontSize);

    // keep input in sync when selection-driven font settings change
    ever(fontSettings, (FontSettings fs) {
      if (fontSizeController.text != fs.fontSize) {
        fontSizeController.text = fs.fontSize;
      }
    });

    // Watch overlay flag to clear/hide
    ever(showFlowOverlay, (val) {
      if (!val) {
        overlayFlows.clear();
        flowQuery.value = '';
      }
    });
  }

  void _onEditorChanged() {
    final deltaJson = quillController.document.toDelta().toJson();
    documentContent.value = {'ops': deltaJson};
    updateOutline(quillController.document.toDelta().toList());
    updateFontSettings(quillController.getSelectionStyle().attributes);
    updateFormattingState(quillController.getSelectionStyle().attributes);

    // Check for # trigger
    _checkForFlowTrigger();

    // Auto-save the document when content changes
    _saveDocument();
  }

  KeyEventResult _handleKey(FocusNode node, RawKeyEvent event) {
    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.keyP &&
        HardwareKeyboard.instance.isControlPressed) {
      insertBulletPoint();
      return KeyEventResult.handled;
    }

    if (event is RawKeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.tab) {
      _cycleFontPreset();
      return KeyEventResult.handled;
    }

    if (showFlowOverlay.value) {
      if (event is RawKeyDownEvent) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          dismissFlowOverlay();
          return KeyEventResult.handled;
        }
        // Could implement arrow keys navigation here
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          if (overlayFlows.isNotEmpty) {
            selectFlow(overlayFlows.first);
            return KeyEventResult.handled;
          }
        }
      }
    }

    return KeyEventResult.ignored;
  }

  void updateEditorStyleSizeForCurrentPreset(String sizeStr) {
    final parsed =
        double.tryParse(sizeStr) ??
        double.tryParse(fontSettings.value.fontSize) ??
        14.0;
    final preset = fontSettings.value.preset;
    final existing = editorFontSettings[preset];
    if (existing != null) {
      editorFontSettings[preset] = existing.copyWith(styleSize: parsed);
    }
  }

  void updateOutline(List<dynamic> operations) {
    final List<HeadingItem> headings = [];
    num position = 0;

    dynamic attrValue(dynamic attr) {
      if (attr == null) return null;
      if (attr is Attribute) return attr.value;
      return attr;
    }

    for (int i = 0; i < operations.length; i++) {
      final op = operations[i];

      if (op.data is String) {
        final textRaw = op.data as String;
        final attributes = op.attributes ?? {};

        final headerRaw = attributes[Attribute.header.key];
        final headerVal = attrValue(headerRaw);

        if (headerVal != null) {
          int? level;
          FontWeight? fontWeight;
          double? fontSize;
          final normalized = headerVal is int
              ? headerVal
              : int.tryParse(headerVal.toString());
          if (normalized != null) {
            level = normalized;
            if (normalized == Attribute.h1.value) {
              fontWeight = FontWeight.w600;
              fontSize = 18;
            } else if (normalized == Attribute.h2.value) {
              fontWeight = FontWeight.w600;
              fontSize = 16;
            } else if (normalized == Attribute.h3.value) {
              fontWeight = FontWeight.w400;
              fontSize = 14;
            }
          }

          level = level ?? 1;
          fontWeight = fontWeight ?? FontWeight.w400;
          fontSize = fontSize ?? 0;

          String headingText = textRaw.replaceAll('\n', '').trim();
          if (headingText.isEmpty) {
            for (int j = i - 1; j >= 0; j--) {
              final prev = operations[j];
              if (prev.data is String) {
                final prevText = prev.data as String;
                final segments = prevText.split('\n');
                final candidate = segments.isNotEmpty
                    ? segments.last
                    : prevText;
                final candidateTrim = candidate.trim();
                if (candidateTrim.isNotEmpty) {
                  headingText = candidateTrim;
                  break;
                }
              } else {
                break;
              }
            }
          }

          if (headingText.isNotEmpty) {
            headings.add(
              HeadingItem(
                text: headingText,
                level: level,
                fontWeight: fontWeight,
                position: position.toInt(),
                fontSize: fontSize,
                isExpanded: (level == 2).obs,
              ),
            );
          }
        }
      }

      position += (operations[i].length ?? 0).toInt();
    }

    final List<HeadingItem> nestedHeadings = [];
    for (int i = 0; i < headings.length; i++) {
      final heading = headings[i];
      if (heading.level == 1) {
        final children = <HeadingItem>[];
        for (int j = i + 1; j < headings.length; j++) {
          if (headings[j].level == 1) break;
          if (headings[j].level == 2) {
            final h2 = headings[j];
            final h2Children = <HeadingItem>[];
            for (int k = j + 1; k < headings.length; k++) {
              if (headings[k].level <= 2) break;
              if (headings[k].level == 3) {
                h2Children.add(headings[k]);
              }
            }
            children.add(
              HeadingItem(
                text: h2.text,
                level: h2.level,
                position: h2.position,
                fontWeight: h2.fontWeight,
                fontSize: h2.fontSize,
                isExpanded: h2.isExpanded,
                children: h2Children,
              ),
            );
          }
        }
        nestedHeadings.add(
          HeadingItem(
            text: heading.text,
            level: heading.level,
            position: heading.position,
            fontWeight: heading.fontWeight,
            fontSize: heading.fontSize,
            isExpanded: heading.isExpanded,
            children: children,
          ),
        );
      }
    }

    outline.value = nestedHeadings;
  }

  void updateFontSettings(Map<String, dynamic> attributes) {
    dynamic attrValue(dynamic attr) {
      if (attr == null) return null;
      if (attr is Attribute) return attr.value;
      return attr;
    }

    String fontFamily = fontSettings.value.fontFamily;
    String fontSize = fontSettings.value.fontSize;
    String preset = fontSettings.value.preset;

    final fontRaw = attributes[Attribute.font.key];
    final fontVal = attrValue(fontRaw);
    if (fontVal != null) fontFamily = fontVal.toString();

    final sizeRaw = attributes[Attribute.size.key];
    final sizeVal = attrValue(sizeRaw);
    final mappedSize = editorFontSettings[fontFamily]?.fontSize;
    if (mappedSize != null) {
      fontSize = mappedSize;
    } else if (sizeVal != null) {
      fontSize = sizeVal.toString();
    }

    final headerRaw = attributes[Attribute.header.key];
    final headerVal = attrValue(headerRaw);
    if (headerVal != null) {
      final level = (headerVal is int)
          ? headerVal
          : int.tryParse(headerVal.toString()) ?? 0;
      if (level == 1) preset = 'Heading';
      if (level == 2) preset = 'Title';
      if (level == 3) preset = 'Subtitle';
    } else {
      preset = 'Body';
    }

    fontSettings.value = fontSettings.value.copyWith(
      preset: preset,
      fontFamily: fontFamily,
      fontSize: fontSize,
    );
  }

  void updateFormattingState(Map<String, dynamic> attributes) {
    dynamic attrValue(dynamic attr) {
      if (attr == null) return null;
      if (attr is Attribute) return attr.value;
      return attr;
    }

    final boldVal = attrValue(attributes[Attribute.bold.key]);
    final italicVal = attrValue(attributes[Attribute.italic.key]);
    final underlineVal = attributes.containsKey(Attribute.underline.key);

    isBold.value = boldVal != null;
    isItalic.value = italicVal != null;
    isUnderline.value = underlineVal;

    final listRaw = attributes[Attribute.list.key];
    final listVal = attrValue(listRaw);
    if (listVal != null) {
      final listType = listVal.toString();
      isBulletList.value = listType == 'bullet';
      isNumberedList.value = listType == 'ordered';
    } else {
      isBulletList.value = false;
      isNumberedList.value = false;
    }
  }

  void toggleH2Expansion(int position) {
    void toggleInList(List<HeadingItem> list) {
      for (final heading in list) {
        if (heading.position == position) {
          heading.isExpanded.value = !heading.isExpanded.value;
          return;
        }
        toggleInList(heading.children);
      }
    }

    toggleInList(outline);
  }

  String currentFontFamily() {
    try {
      return GoogleFonts.getFont(fontSettings.value.fontFamily).fontFamily ??
          fontSettings.value.fontFamily;
    } catch (_) {
      return fontSettings.value.fontFamily;
    }
  }

  // Method to select a doc
  void loadDoc(Doc doc) {
    selectedDocId.value = doc.id;
    selectedDocName.value = doc.name;
    _loadDocumentContentSync(doc);
  }

  void _loadDocumentContentSync(Doc doc) {
    try {
      if (doc.doc != null) {
        try {
          final decoded = jsonDecode(doc.doc!);
          if (decoded is Map<String, dynamic>) {
            documentContent.value = decoded;
          } else if (decoded is List) {
            documentContent.value = {'ops': decoded};
          }
        } catch (e) {
          print("Could not parse doc content as JSON: $e");
          documentContent.value = {'ops': []};
        }
      } else {
        documentContent.value = {'ops': []};
      }
      loadDocumentFromProvider();
    } catch (e) {
      print('Error in _loadDocumentContentSync: $e');
      documentContent.value = {'ops': []};
    }
  }

  void clearSelectedDoc() {
    selectedDocId.value = null;
    selectedDocName.value = "";
    documentContent.value = {'ops': []};
    quillController.document = Document()..insert(0, '\n');
    outline.clear();
  }

  Future<void> loadSavedDocs(UuidValue appId) async {
    try {
      isLoadingDocs.value = true;
      final response = await client.docs.getDocs(appId);
      savedDocs.value = response;
    } catch (e) {
      print('Error loading docs: $e');
    } finally {
      isLoadingDocs.value = false;
    }
  }

  Future<void> addDoc(UuidValue appId, String name) async {
    try {
      if (name.trim().isEmpty) return;
      final success = await client.docs.addDoc(appId, name.trim());
      if (success) {
        await loadSavedDocs(appId);
      }
    } catch (e) {
      print('Error adding doc: $e');
    }
  }

  void _cycleFontPreset() {
    final currentIndex = DocumentEditorProvider.presets.indexOf(
      fontSettings.value.preset,
    );
    final nextIndex =
        (currentIndex + 1) % DocumentEditorProvider.presets.length;
    _applyFontPreset(DocumentEditorProvider.presets[nextIndex]);
  }

  void _applyFontPreset(String preset) {
    final fs = editorFontSettings[preset] ?? editorFontSettings['Body']!;

    String fontSize;
    if (fs.styleSize != null) {
      fontSize = fs.styleSize!.toString().replaceAll(RegExp(r'\.0$'), '');
    } else {
      fontSize = editorFontSettings[preset]?.fontSize ?? '14';
    }

    if (fs.headerAttribute != null) {
      quillController.formatSelection(fs.headerAttribute!);
    } else {
      quillController.formatSelection(Attribute.clone(Attribute.header, null));
    }

    editorFontSettings[fontSettings.value.fontFamily] =
        (editorFontSettings[fontSettings.value.fontFamily] ??
                FontSettings(fontFamily: fontSettings.value.fontFamily))
            .copyWith(fontSize: fontSize);
    fontSettings.value = fontSettings.value.copyWith(
      preset: preset,
      fontSize: fontSize,
    );

    updateEditorStyleSizeForCurrentPreset(fontSize);

    quillController.formatSelection(
      Attribute.fromKeyValue(Attribute.size.key, fontSize),
    );
    quillController.formatSelection(
      Attribute.fromKeyValue(Attribute.font.key, fontSettings.value.fontFamily),
    );

    fontSizeController.text = fontSize;
  }

  void applyFontPreset(String preset) {
    _applyFontPreset(preset);
  }

  void cycleFontPreset() {
    _cycleFontPreset();
  }

  void insertBulletPoint() {
    final currentStyle = quillController.getSelectionStyle().attributes;
    final listAttr = currentStyle[Attribute.list.key];
    final isBullet = listAttr != null && listAttr.value == 'bullet';

    if (isBullet) {
      quillController.formatSelection(Attribute.clone(Attribute.list, null));
    } else {
      quillController.formatSelection(Attribute.ul);
    }
  }

  void toggleBold() {
    isBold.value = !isBold.value;
    final isBoldActive = quillController
        .getSelectionStyle()
        .attributes
        .containsKey(Attribute.bold.key);
    if (isBoldActive) {
      quillController.formatSelection(Attribute.clone(Attribute.bold, null));
    } else {
      quillController.formatSelection(Attribute.bold);
    }
  }

  void toggleItalic() {
    isItalic.value = !isItalic.value;
    final isItalicActive = quillController
        .getSelectionStyle()
        .attributes
        .containsKey(Attribute.italic.key);
    if (isItalicActive) {
      quillController.formatSelection(Attribute.clone(Attribute.italic, null));
    } else {
      quillController.formatSelection(Attribute.italic);
    }
  }

  void toggleUnderline() {
    isUnderline.value = !isUnderline.value;
    final isUnderLineActive = quillController
        .getSelectionStyle()
        .attributes
        .containsKey(Attribute.underline.key);
    if (isUnderLineActive) {
      quillController.formatSelection(
        Attribute.clone(Attribute.underline, null),
      );
    } else {
      quillController.formatSelection(Attribute.underline);
    }
  }

  Future<void> _saveDocument() async {
    if (selectedDocId.value == null) return;

    try {
      final docContent = documentContent.value;
      final outlineData = jsonEncode(
        outline.map((item) => item.toJson()).toList(),
      );
      final docString = jsonEncode(docContent);

      await client.docs.saveDoc(
        selectedDocId.value!,
        docString,
        outlineData,
      );
    } catch (e) {
      print('Error saving document: $e');
    }
  }

  void saveDocument() {
    _saveDocument();
  }

  void loadDocumentFromProvider() async {
    try {
      final documentContent = this.documentContent.value;
      final ops = documentContent['ops'] as List<dynamic>? ?? [];

      if (ops.isNotEmpty) {
        final delta = Delta.fromJson(ops);
        quillController.document = Document.fromDelta(delta);
      } else {
        final emptyDelta = Delta()..insert('\n');
        quillController.document = Document.fromDelta(emptyDelta);
      }

      updateOutline(quillController.document.toDelta().toList());
      update();
    } catch (e) {
      print('Error loading document from provider: $e');
      final emptyDelta = Delta()..insert('\n');
      quillController.document = Document.fromDelta(emptyDelta);
      outline.clear();
    }
  }

  // --- Flow Overlay Logic ---

  void _checkForFlowTrigger() {
    final selection = quillController.selection;
    if (selection.isCollapsed && selection.baseOffset > 0) {
      final textBeforeCursor = quillController.document.toPlainText().substring(
        0,
        selection.baseOffset,
      );

      // Split by spaces and newlines to get the last word
      final words = textBeforeCursor.split(RegExp(r'[\s\n]'));
      final lastWord = words.isNotEmpty ? words.last : '';

      if (lastWord.startsWith('#')) {
        final newQuery = lastWord.substring(1); // Remove the '#'
        if (flowQuery.value != newQuery) {
          flowQuery.value = newQuery;
          if (showFlowOverlay.value) {
            _updateFlowOverlay();
          } else {
            _showFlowOverlay();
          }
        }
      } else {
        if (showFlowOverlay.value) {
          _hideFlowOverlay();
        }
      }
    } else {
      if (showFlowOverlay.value) _hideFlowOverlay();
    }
  }

  void _showFlowOverlay() async {
    if (Get.isRegistered<FlowsController>()) {
      final flowsController = Get.find<FlowsController>();
      if (flowsController.selectedAppId.value != null) {
        // Ensure flows are loaded
        if (flowsController.savedFlows.isEmpty) {
          await flowsController.loadSavedFlows();
        }

        overlayFlows.value = flowsController.savedFlows.where((flow) {
          return flow.name.toLowerCase().contains(
            flowQuery.value.toLowerCase(),
          );
        }).toList();

        if (overlayFlows.isNotEmpty) {
          showFlowOverlay.value = true;
        }
      }
    }
  }

  void _updateFlowOverlay() {
    if (Get.isRegistered<FlowsController>()) {
      final flowsController = Get.find<FlowsController>();
      if (flowsController.selectedAppId.value != null &&
          showFlowOverlay.value) {
        overlayFlows.value = flowsController.savedFlows.where((flow) {
          return flow.name.toLowerCase().contains(
            flowQuery.value.toLowerCase(),
          );
        }).toList();
      } else {
        _showFlowOverlay();
      }
    }
  }

  void _hideFlowOverlay() {
    showFlowOverlay.value = false;
    overlayFlows.clear();
    flowQuery.value = '';
  }

  void dismissFlowOverlay() {
    _hideFlowOverlay();
  }

  void selectFlow(FlowModel flow) {
    final selection = quillController.selection;
    final allText = quillController.document.toPlainText();

    // Safety check
    if (selection.baseOffset > allText.length) return;

    // Find the start of the word containing '#'
    int wordStart = -1;
    // Iterate backwards from cursor
    for (int i = selection.baseOffset - 1; i >= 0; i--) {
      final char = allText[i];
      if (char == ' ' || char == '\n') {
        wordStart = i + 1;
        break;
      }
      if (i == 0) wordStart = 0;
    }

    if (wordStart != -1) {
      // Replace the #query with #flowName
      final replacement = '#${flow.name} ';
      quillController.replaceText(
        wordStart,
        selection.baseOffset - wordStart,
        replacement,
        null,
      );

      // Move cursor
      final newPosition = wordStart + replacement.length;
      quillController.updateSelection(
        TextSelection.collapsed(offset: newPosition),
        ChangeSource.local,
      );
    }

    _hideFlowOverlay();
  }
}
