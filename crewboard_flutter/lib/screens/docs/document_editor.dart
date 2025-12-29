import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'document_editor_provider.dart';
import '../../config/palette.dart';
import '../../widgets/glass_morph.dart';

class DocumentEditor extends StatelessWidget {
  const DocumentEditor({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<DocumentEditorProvider>()) {
      Get.put(DocumentEditorProvider());
    }
    final DocumentEditorProvider provider = Get.find<DocumentEditorProvider>();

    return Obx(() {
      if (provider.selectedDocId.value == null) {
        return GlassMorph(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Container(
            height: 400,
            child: Center(
              child: Text(
                "Select a document to start editing",
                style: TextStyle(color: Pallet.font3, fontSize: 14),
              ),
            ),
          ),
        );
      }

      return GlassMorph(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            // Toolbar
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Pallet.inside1,
                border: Border(bottom: BorderSide(color: Pallet.divider)),
              ),
              child: Row(
                children: [
                  // Document name
                  Expanded(
                    child: Text(
                      provider.selectedDocName.value,
                      style: TextStyle(
                        color: Pallet.font1,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Heading buttons
                  _ToolbarButton(
                    label: "H1",
                    onPressed: () => provider.applyHeading(1),
                  ),
                  const SizedBox(width: 8),
                  _ToolbarButton(
                    label: "H2",
                    onPressed: () => provider.applyHeading(2),
                  ),
                  const SizedBox(width: 8),
                  _ToolbarButton(
                    label: "H3",
                    onPressed: () => provider.applyHeading(3),
                  ),
                  const SizedBox(width: 16),

                  // Formatting buttons
                  IconButton(
                    icon: const Icon(Icons.format_bold),
                    color: Pallet.font2,
                    onPressed: provider.toggleBold,
                  ),
                  IconButton(
                    icon: const Icon(Icons.format_italic),
                    color: Pallet.font2,
                    onPressed: provider.toggleItalic,
                  ),
                  IconButton(
                    icon: const Icon(Icons.format_underline),
                    color: Pallet.font2,
                    onPressed: provider.toggleUnderline,
                  ),
                ],
              ),
            ),

            // Editor
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                child: quill.QuillEditor.basic(
                  controller: provider.quillController,
                  focusNode: provider.editorFocusNode,
                  scrollController: provider.editorScrollController,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _ToolbarButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ToolbarButton({
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: Pallet.font2,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
