import 'dart:convert';
import 'dart:io' as io;
import 'package:crewboard_flutter/widgets/document/quill_delta.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:crewboard_client/crewboard_client.dart';
import 'package:crewboard_flutter/main.dart'; // for client
import '../../widgets/document/flutter_quill.dart';
import '../../widgets/document/src/controller/quill_controller.dart';
import 'package:collection/collection.dart';
import 'flows/flows_controller.dart'; // For FlowModel

class FontSettings {
  final String preset;
  final String fontFamily;
  final String fontSize;
  final double? styleSize;
  final FontWeight? weight;
  final double? spacing;
  final double? lineHeight;
  final String name;
  final dynamic headerAttribute;
  final String? color;
  final UuidValue? systemColorId;

  const FontSettings({
    this.preset = 'Body',
    this.fontFamily = 'Roboto',
    this.fontSize = '14',
    this.styleSize,
    this.weight,
    this.spacing,
    this.lineHeight,
    this.name = 'Body',
    this.headerAttribute,
    this.color,
    this.systemColorId,
  });

  FontSettings copyWith({
    String? preset,
    String? fontFamily,
    String? fontSize,
    double? styleSize,
    FontWeight? weight,
    double? spacing,
    double? lineHeight,
    String? name,
    dynamic headerAttribute,
    String? color,
    UuidValue? systemColorId,
  }) {
    return FontSettings(
      preset: preset ?? this.preset,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      styleSize: styleSize ?? this.styleSize,
      weight: weight ?? this.weight,
      spacing: spacing ?? this.spacing,
      lineHeight: lineHeight ?? this.lineHeight,
      name: name ?? this.name,
      headerAttribute: headerAttribute ?? this.headerAttribute,
      color: color ?? this.color,
      systemColorId: systemColorId ?? this.systemColorId,
    );
  }
}

class HeadingItem {
  final String text;
  final int level;
  final int position;
  final FontWeight fontWeight;
  final double fontSize;
  final bool isExpanded;
  final List<HeadingItem> children;

  HeadingItem({
    required this.text,
    required this.level,
    required this.position,
    required this.fontWeight,
    required this.fontSize,
    this.isExpanded = true,
    List<HeadingItem>? children,
  }) : children = children ?? [];

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'level': level,
      'position': position,
      'fontWeight': fontWeight.index,
      'fontSize': fontSize,
      'isExpanded': isExpanded,
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
      isExpanded: json['isExpanded'] ?? true,
      children:
          (json['children'] as List<dynamic>?)
              ?.map((child) => HeadingItem.fromJson(child))
              .toList() ??
          [],
    );
  }

  HeadingItem copyWith({bool? isExpanded}) {
    return HeadingItem(
      text: text,
      level: level,
      position: position,
      fontWeight: fontWeight,
      fontSize: fontSize,
      isExpanded: isExpanded ?? this.isExpanded,
      children: children,
    );
  }
}

class DocumentEditorState {
  final Map<String, dynamic> documentContent;
  final List<Doc> savedDocs;
  final UuidValue? selectedDocId;
  final String selectedDocName;
  final FontSettings fontSettings;
  final List<String> availableFonts;
  final List<HeadingItem> outline;
  final bool isBold;
  final bool isItalic;
  final bool isUnderline;
  final bool isBulletList;
  final bool isNumberedList;
  final Map<String, FontSettings> editorFontSettings;
  final List<SystemColor> systemColors;
  final List<String> dynamicPresets;
  final bool isLoadingDocs;
  final bool showFlowOverlay;
  final List<FlowModel> overlayFlows;
  final Offset overlayPosition;
  final String flowQuery;
  final SystemVariables? systemVariables;
  final bool isLoadingSettings;

  DocumentEditorState({
    this.documentContent = const {'ops': []},
    this.savedDocs = const [],
    this.selectedDocId,
    this.selectedDocName = "",
    this.fontSettings = const FontSettings(),
    this.availableFonts = const [
      'Roboto',
      'Open Sans',
      'Lato',
      'Montserrat',
      'Poppins',
    ],
    this.outline = const [],
    this.isBold = false,
    this.isItalic = false,
    this.isUnderline = false,
    this.isBulletList = false,
    this.isNumberedList = false,
    this.editorFontSettings = const {},
    this.systemColors = const [],
    this.dynamicPresets = const [],
    this.isLoadingDocs = false,
    this.showFlowOverlay = false,
    this.overlayFlows = const [],
    this.overlayPosition = Offset.zero,
    this.flowQuery = '',
    this.systemVariables,
    this.isLoadingSettings = false,
  });

  DocumentEditorState copyWith({
    Map<String, dynamic>? documentContent,
    List<Doc>? savedDocs,
    UuidValue? selectedDocId,
    String? selectedDocName,
    FontSettings? fontSettings,
    List<String>? availableFonts,
    List<HeadingItem>? outline,
    bool? isBold,
    bool? isItalic,
    bool? isUnderline,
    bool? isBulletList,
    bool? isNumberedList,
    Map<String, FontSettings>? editorFontSettings,
    List<SystemColor>? systemColors,
    List<String>? dynamicPresets,
    bool? isLoadingDocs,
    bool? showFlowOverlay,
    List<FlowModel>? overlayFlows,
    Offset? overlayPosition,
    String? flowQuery,
    SystemVariables? systemVariables,
    bool? isLoadingSettings,
  }) {
    return DocumentEditorState(
      documentContent: documentContent ?? this.documentContent,
      savedDocs: savedDocs ?? this.savedDocs,
      selectedDocId: selectedDocId ?? this.selectedDocId,
      selectedDocName: selectedDocName ?? this.selectedDocName,
      fontSettings: fontSettings ?? this.fontSettings,
      availableFonts: availableFonts ?? this.availableFonts,
      outline: outline ?? this.outline,
      isBold: isBold ?? this.isBold,
      isItalic: isItalic ?? this.isItalic,
      isUnderline: isUnderline ?? this.isUnderline,
      isBulletList: isBulletList ?? this.isBulletList,
      isNumberedList: isNumberedList ?? this.isNumberedList,
      editorFontSettings: editorFontSettings ?? this.editorFontSettings,
      systemColors: systemColors ?? this.systemColors,
      dynamicPresets: dynamicPresets ?? this.dynamicPresets,
      isLoadingDocs: isLoadingDocs ?? this.isLoadingDocs,
      showFlowOverlay: showFlowOverlay ?? this.showFlowOverlay,
      overlayFlows: overlayFlows ?? this.overlayFlows,
      overlayPosition: overlayPosition ?? this.overlayPosition,
      flowQuery: flowQuery ?? this.flowQuery,
      systemVariables: systemVariables ?? this.systemVariables,
      isLoadingSettings: isLoadingSettings ?? this.isLoadingSettings,
    );
  }
}

final documentEditorProvider =
    NotifierProvider<DocumentEditorNotifier, DocumentEditorState>(
      DocumentEditorNotifier.new,
    );

class DocumentEditorNotifier extends Notifier<DocumentEditorState> {
  late final QuillController quillController;
  final FocusNode editorFocusNode = FocusNode();
  final ScrollController editorScrollController = ScrollController();
  final TextEditingController fontSizeController = TextEditingController();

  @override
  DocumentEditorState build() {
    state = DocumentEditorState();
    initializeEditor();
    loadSettings();
    ref.onDispose(() {
      quillController.dispose();
      editorScrollController.dispose();
      editorFocusNode.dispose();
      fontSizeController.dispose();
    });
    return state;
  }

  Future<void> loadSettings() async {
    try {
      state = state.copyWith(isLoadingSettings: true);
      final result = await client.admin.getSystemVariables();
      if (result != null) {
        if (result.tabPreset1 != null)
          result.tabPreset1 = result.tabPreset1!.toLowerCase();
        if (result.tabPreset2 != null)
          result.tabPreset2 = result.tabPreset2!.toLowerCase();
        if (result.titleFont != null)
          result.titleFont = result.titleFont!.toLowerCase();
        if (result.headingFont != null)
          result.headingFont = result.headingFont!.toLowerCase();
        if (result.subHeadingFont != null)
          result.subHeadingFont = result.subHeadingFont!.toLowerCase();

        state = state.copyWith(systemVariables: result);
        quillController.readOnly = !(result.allowEdit ?? true);
        if (result.googleFonts != null && result.googleFonts!.isNotEmpty) {
          state = state.copyWith(availableFonts: result.googleFonts!);
        }
      }

      final colors = await client.admin.getColors();
      state = state.copyWith(systemColors: colors);

      final fonts = await client.admin.getFontSettings();
      final Map<String, FontSettings> newSettings = {};
      final List<String> newPresets = [];

      for (var f in fonts) {
        final name = f.name.toLowerCase();
        Attribute? headerAttr;
        int level = f.headerLevel ?? 0;

        if (state.systemVariables?.titleFont == name) {
          headerAttr = Attribute.h1;
          level = 1;
        } else if (state.systemVariables?.headingFont == name) {
          headerAttr = Attribute.h2;
          level = 2;
        } else if (state.systemVariables?.subHeadingFont == name) {
          headerAttr = Attribute.h3;
          level = 3;
        } else if (level == 1)
          headerAttr = Attribute.h1;
        else if (level == 2)
          headerAttr = Attribute.h2;
        else if (level == 3)
          headerAttr = Attribute.h3;

        newSettings[name] = FontSettings(
          name: name,
          preset: name,
          fontFamily: f.fontFamily ?? 'Roboto',
          fontSize: (f.fontSize ?? 14).toString(),
          styleSize: f.fontSize ?? 14,
          weight: _parseWeight(f.fontWeight),
          lineHeight: f.lineHeight ?? 1.5,
          spacing: level > 0 ? (20.0 - level * 4) : 4.0,
          headerAttribute: headerAttr,
        );
        newPresets.add(name);
      }

      if (!newSettings.containsKey('body')) {
        newSettings['body'] = const FontSettings(name: 'body', preset: 'body');
        newPresets.insert(0, 'body');
      }

      state = state.copyWith(
        editorFontSettings: newSettings,
        dynamicPresets: newPresets,
      );
    } catch (e) {
      debugPrint('Error loading settings: $e');
    } finally {
      state = state.copyWith(isLoadingSettings: false);
    }
  }

  FontWeight? _parseWeight(String? weight) {
    if (weight == null) return null;
    switch (weight.toLowerCase()) {
      case 'bold':
        return FontWeight.bold;
      case 'normal':
        return FontWeight.normal;
      case 'w100':
        return FontWeight.w100;
      case 'w200':
        return FontWeight.w200;
      case 'w300':
        return FontWeight.w300;
      case 'w400':
        return FontWeight.w400;
      case 'w500':
        return FontWeight.w500;
      case 'w600':
        return FontWeight.w600;
      case 'w700':
        return FontWeight.w700;
      case 'w800':
        return FontWeight.w800;
      case 'w900':
        return FontWeight.w900;
      default:
        return null;
    }
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

    quillController.addListener(_onEditorChanged);
    editorFocusNode.onKeyEvent = _handleKey;
    fontSizeController.text = state.fontSettings.fontSize;
  }

  void _onEditorChanged() {
    final deltaJson = quillController.document.toDelta().toJson();
    state = state.copyWith(documentContent: {'ops': deltaJson});
    updateOutline(quillController.document.toDelta().toList());
    updateFontSettings(quillController.getSelectionStyle().attributes);
    updateFormattingState(quillController.getSelectionStyle().attributes);
    _checkForFlowTrigger();
    _saveDocument();
  }

  KeyEventResult _handleKey(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (state.showFlowOverlay) {
        if (event.logicalKey == LogicalKeyboardKey.escape) {
          dismissFlowOverlay();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.enter &&
            state.overlayFlows.isNotEmpty) {
          selectFlow(state.overlayFlows.first);
          return KeyEventResult.handled;
        }
      }
    }
    return KeyEventResult.ignored;
  }

  void updateOutline(List<dynamic> operations) {
    if (quillController.document.isEmpty()) {
      state = state.copyWith(outline: []);
      return;
    }

    final List<HeadingItem> outline = [];
    final List<HeadingItem> stack = [];

    for (final node in quillController.document.root.children) {
      if (node is! Line) continue;

      final attrs = node.style.attributes;
      if (attrs.containsKey(Attribute.header.key)) {
        final level = attrs[Attribute.header.key]!.value as int;
        final text = node.toPlainText().replaceAll('\n', '').trim();
        if (text.isEmpty) continue;

        final heading = HeadingItem(
          text: text,
          level: level,
          position: node.offset,
          fontWeight: level == 1
              ? FontWeight.bold
              : (level == 2 ? FontWeight.w600 : FontWeight.w500),
          fontSize: level == 1 ? 15 : (level == 2 ? 14 : 13),
          isExpanded: true,
          children: [],
        );

        if (level == 1) {
          outline.add(heading);
          stack.clear();
          stack.add(heading);
        } else {
          // Level 2 or 3
          while (stack.isNotEmpty && stack.last.level >= level) {
            stack.removeLast();
          }

          if (stack.isEmpty) {
            outline.add(heading);
            stack.add(heading);
          } else {
            stack.last.children.add(heading);
            stack.add(heading);
          }
        }
      }
    }

    state = state.copyWith(outline: outline);
  }

  void updateFontSettings(Map<String, dynamic> attributes) {
    dynamic attrValue(dynamic attr) {
      if (attr == null) return null;
      if (attr is Attribute) return attr.value;
      return attr;
    }

    String fontFamily = state.fontSettings.fontFamily;
    String fontSize = state.fontSettings.fontSize;

    final fontRaw = attributes[Attribute.font.key];
    final fontVal = attrValue(fontRaw);
    if (fontVal != null) fontFamily = fontVal.toString();

    final sizeRaw = attributes[Attribute.size.key];
    final sizeVal = attrValue(sizeRaw);
    if (sizeVal != null) fontSize = sizeVal.toString();

    final headerRaw = attributes[Attribute.header.key];
    final headerVal = attrValue(headerRaw);
    int level = 0;
    if (headerVal != null)
      level = (headerVal is int)
          ? headerVal
          : int.tryParse(headerVal.toString()) ?? 0;

    String? foundPreset;
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
        if (fsLevel == level) {
          foundPreset = pName;
          break;
        }
      }
    }

    final resolvedPreset =
        foundPreset ??
        (state.dynamicPresets.isNotEmpty ? state.dynamicPresets.first : 'body');

    final colorRaw = attributes[Attribute.color.key];
    final colorVal = attrValue(colorRaw);
    final String? colorHex = colorVal?.toString();
    UuidValue? colorId;

    if (colorHex != null && state.systemColors.isNotEmpty) {
      final match = state.systemColors.firstWhereOrNull(
        (c) => c.color.toLowerCase() == colorHex.toLowerCase(),
      );
      colorId = match?.id;
    }

    state = state.copyWith(
      fontSettings: state.fontSettings.copyWith(
        preset: resolvedPreset,
        fontFamily: fontFamily,
        fontSize: fontSize,
        color: colorHex,
        systemColorId: colorId,
      ),
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

    final listRaw = attributes[Attribute.list.key];
    final listVal = attrValue(listRaw);

    state = state.copyWith(
      isBold: boldVal != null,
      isItalic: italicVal != null,
      isUnderline: underlineVal,
      isBulletList: listVal?.toString() == 'bullet',
      isNumberedList: listVal?.toString() == 'ordered',
    );
  }

  void loadDoc(Doc doc) {
    state = state.copyWith(selectedDocId: doc.id, selectedDocName: doc.name);
    _loadDocumentContentSync(doc);
  }

  void _loadDocumentContentSync(Doc doc) {
    if (doc.doc != null) {
      try {
        final decoded = jsonDecode(doc.doc!);
        state = state.copyWith(
          documentContent: decoded is Map<String, dynamic>
              ? decoded
              : {'ops': decoded},
        );
      } catch (e) {
        state = state.copyWith(documentContent: {'ops': []});
      }
    } else {
      state = state.copyWith(documentContent: {'ops': []});
    }
    loadDocumentFromProvider();
  }

  void loadDocumentFromProvider() {
    final ops = state.documentContent['ops'] as List<dynamic>? ?? [];
    if (ops.isNotEmpty) {
      quillController.document = Document.fromDelta(Delta.fromJson(ops));
    } else {
      quillController.document = Document.fromDelta(Delta()..insert('\n'));
    }
    updateOutline(quillController.document.toDelta().toList());
  }

  Future<void> loadSavedDocs(UuidValue appId) async {
    try {
      state = state.copyWith(isLoadingDocs: true);
      final response = await client.docs.getDocs(appId);
      state = state.copyWith(savedDocs: response, isLoadingDocs: false);
    } catch (e) {
      debugPrint('Error loading docs: $e');
      state = state.copyWith(isLoadingDocs: false);
    }
  }

  Future<void> addDoc(UuidValue appId, String name) async {
    try {
      await client.docs.addDoc(appId, name);
      await loadSavedDocs(appId);
    } catch (e) {
      debugPrint('Error adding doc: $e');
    }
  }

  Future<void> _saveDocument() async {
    if (state.selectedDocId == null) return;
    try {
      final docString = jsonEncode(state.documentContent);
      final outlineData = jsonEncode(
        state.outline.map((item) => item.toJson()).toList(),
      );
      await client.docs.saveDoc(state.selectedDocId!, docString, outlineData);
    } catch (e) {
      debugPrint('Error saving document: $e');
    }
  }

  void _checkForFlowTrigger() {
    final selection = quillController.selection;
    if (selection.isCollapsed && selection.baseOffset > 0) {
      final textBeforeCursor = quillController.document.toPlainText().substring(
        0,
        selection.baseOffset,
      );
      final words = textBeforeCursor.split(RegExp(r'[\s\n]'));
      final lastWord = words.isNotEmpty ? words.last : '';

      if (lastWord.startsWith('#')) {
        final query = lastWord.substring(1);
        if (state.flowQuery != query) {
          state = state.copyWith(flowQuery: query);
          _updateFlowOverlay();
        }
      } else if (state.showFlowOverlay) {
        dismissFlowOverlay();
      }
    }
  }

  void _updateFlowOverlay() {
    final flowsState = ref.read(flowsProvider);
    if (flowsState.selectedAppId != null) {
      final filtered = flowsState.savedFlows
          .where(
            (f) => f.name.toLowerCase().contains(state.flowQuery.toLowerCase()),
          )
          .toList();
      state = state.copyWith(
        overlayFlows: filtered,
        showFlowOverlay: filtered.isNotEmpty,
      );
    }
  }

  void dismissFlowOverlay() => state = state.copyWith(
    showFlowOverlay: false,
    overlayFlows: [],
    flowQuery: '',
  );

  void selectFlow(FlowModel flow) {
    // ... simplified selectFlow implementation ...
    dismissFlowOverlay();
  }
}
