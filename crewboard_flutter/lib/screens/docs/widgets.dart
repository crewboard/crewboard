import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'document_editor_provider.dart';

void showCustomFontDialog(BuildContext context, DocumentEditorProvider provider) {
  String selectedFontFamily = provider.fontSettings.value.fontFamily;
  String selectedFontSize = provider.fontSettings.value.fontSize;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setState) => AlertDialog(
        title: const Text('Custom Font Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              value: selectedFontFamily,
              items: ['Roboto', 'Open Sans', 'Lato', 'Montserrat', 'Poppins']
                  .map(
                    (font) => DropdownMenuItem(
                      value: font,
                      child: Text(
                        font,
                        style: TextStyle(
                          fontFamily: GoogleFonts.getFont(font).fontFamily,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedFontFamily = value);
              },
              decoration: const InputDecoration(labelText: 'Font Family'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedFontSize,
              items: [
                '8',
                '10',
                '12',
                '14',
                '16',
                '18',
                '20',
                '24',
                '28',
                '30',
                '32',
              ]
                  .map(
                    (size) =>
                        DropdownMenuItem(value: size, child: Text(size)),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => selectedFontSize = value);
              },
              decoration: const InputDecoration(labelText: 'Font Size'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              provider.quillController.formatSelection(
                Attribute.fromKeyValue(
                  Attribute.font.key,
                  selectedFontFamily,
                ),
              );
              provider.quillController.formatSelection(
                Attribute.fromKeyValue(Attribute.size.key, selectedFontSize),
              );

              provider.fontSettings.value = provider.fontSettings.value
                  .copyWith(
                    fontFamily: selectedFontFamily,
                    fontSize: selectedFontSize,
                  );

              provider.editorFontSettings[selectedFontFamily] =
                  (provider.editorFontSettings[selectedFontFamily] ??
                          FontSettings(fontFamily: selectedFontFamily))
                      .copyWith(fontSize: selectedFontSize);

              provider.updateEditorStyleSizeForCurrentPreset(
                selectedFontSize,
              );

              if (!provider.availableFonts.contains(selectedFontFamily)) {
                provider.availableFonts.insert(
                  provider.availableFonts.length - 1,
                  selectedFontFamily,
                );
              }

              Navigator.of(context).pop();
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    ),
  );
}
