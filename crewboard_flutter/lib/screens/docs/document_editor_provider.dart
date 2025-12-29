import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:crewboard_flutter/main.dart';
import 'package:crewboard_client/crewboard_client.dart';

class DocumentEditorProvider extends GetxController {
  // Quill editor controller
  late final quill.QuillController quillController;
  final FocusNode editorFocusNode = FocusNode();
  final ScrollController editorScrollController = ScrollController();

  // Observable saved docs list
  final RxList<Doc> savedDocs = <Doc>[].obs;

  // Observable selected doc
  final Rx<UuidValue?> selectedDocId = Rx<UuidValue?>(null);
  final RxString selectedDocName = "".obs;

  // Observable loading state
  final RxBool isLoadingDocs = false.obs;

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
    super.onClose();
  }

  void initializeEditor() {
    quillController = quill.QuillController.basic();

    // Listen to document changes for auto-save
    quillController.addListener(_onEditorChanged);
  }

  void _onEditorChanged() {
    // Auto-save after changes (debounced)
    if (selectedDocId.value != null) {
      _saveDocument();
    }
  }

  // Load docs for an app
  Future<void> loadSavedDocs(UuidValue appId) async {
    try {
      isLoadingDocs.value = true;
      final result = await client.docs.getDocs(appId);
      savedDocs.value = result;
    } catch (e) {
      print('Error loading docs: $e');
    } finally {
      isLoadingDocs.value = false;
    }
  }

  // Select and load a doc
  void loadDoc(Doc doc) {
    selectedDocId.value = doc.id;
    selectedDocName.value = doc.name;

    try {
      if (doc.doc != null && doc.doc!.isNotEmpty) {
        // Parse the Delta JSON
        final deltaJson = jsonDecode(doc.doc!);
        final ops = deltaJson['ops'] as List<dynamic>? ?? [];

        if (ops.isNotEmpty) {
          final delta = quill.Document.fromJson(ops).toDelta();
          quillController.document = quill.Document.fromDelta(delta);
        } else {
          // Empty document
          quillController.document = quill.Document()..insert(0, '\n');
        }
      } else {
        // New empty document
        quillController.document = quill.Document()..insert(0, '\n');
      }
    } catch (e) {
      print('Error loading document content: $e');
      quillController.document = quill.Document()..insert(0, '\n');
    }
  }

  // Save document (debounced)
  Future<void> _saveDocument() async {
    if (selectedDocId.value == null) return;

    try {
      final deltaJson = quillController.document.toDelta().toJson();
      final docContent = jsonEncode({'ops': deltaJson});

      await client.docs.saveDoc(
        selectedDocId.value!,
        docContent,
        null, // outline - simplified for now
      );
      print('Document saved');
    } catch (e) {
      print('Error saving document: $e');
    }
  }

  // Add new doc
  Future<void> addDoc(UuidValue appId, String name) async {
    try {
      final success = await client.docs.addDoc(appId, name);
      if (success) {
        await loadSavedDocs(appId);
      }
    } catch (e) {
      print('Error adding doc: $e');
    }
  }

  // Clear selection
  void clearSelectedDoc() {
    selectedDocId.value = null;
    selectedDocName.value = "";
    quillController.document = quill.Document()..insert(0, '\n');
  }

  // Formatting helpers
  void toggleBold() {
    final isBold = quillController.getSelectionStyle().attributes.containsKey(
      quill.Attribute.bold.key,
    );
    if (isBold) {
      quillController.formatSelection(
        quill.Attribute.clone(quill.Attribute.bold, null),
      );
    } else {
      quillController.formatSelection(quill.Attribute.bold);
    }
  }

  void toggleItalic() {
    final isItalic = quillController.getSelectionStyle().attributes.containsKey(
      quill.Attribute.italic.key,
    );
    if (isItalic) {
      quillController.formatSelection(
        quill.Attribute.clone(quill.Attribute.italic, null),
      );
    } else {
      quillController.formatSelection(quill.Attribute.italic);
    }
  }

  void toggleUnderline() {
    final isUnderline = quillController
        .getSelectionStyle()
        .attributes
        .containsKey(quill.Attribute.underline.key);
    if (isUnderline) {
      quillController.formatSelection(
        quill.Attribute.clone(quill.Attribute.underline, null),
      );
    } else {
      quillController.formatSelection(quill.Attribute.underline);
    }
  }

  void applyHeading(int level) {
    if (level == 1) {
      quillController.formatSelection(quill.Attribute.h1);
    } else if (level == 2) {
      quillController.formatSelection(quill.Attribute.h2);
    } else if (level == 3) {
      quillController.formatSelection(quill.Attribute.h3);
    } else {
      // Clear heading (make it body text)
      quillController.formatSelection(
        quill.Attribute.clone(quill.Attribute.header, null),
      );
    }
  }
}
