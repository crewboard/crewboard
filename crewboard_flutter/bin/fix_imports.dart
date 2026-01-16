import 'dart:io';

void main() {
  final directory = Directory('lib/widgets/image_editor');
  final packageName = 'crewboard_flutter';
  final basePath = 'widgets/image_editor';
  final replacementPrefix = 'package:$packageName/$basePath';

  if (!directory.existsSync()) {
    print('Directory not found: ${directory.path}');
    return;
  }

  int count = 0;
  
  directory.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart')) {
      String content = entity.readAsStringSync();
      String originalContent = content;

      // Replace imports/exports/parts starting with '/
      // We look for the pattern: quotes + slash + path
      // Note: The original source likely uses single quotes, but could use double.
      // We'll handle single quotes as seen in grep results.
      
      content = content.replaceAll("import '/", "import '$replacementPrefix/");
      content = content.replaceAll("export '/", "export '$replacementPrefix/");
      content = content.replaceAll("part '/", "part '$replacementPrefix/");
      
      // Also handle double quotes just in case
      content = content.replaceAll('import "/', 'import "$replacementPrefix/');
      content = content.replaceAll('export "/', 'export "$replacementPrefix/');
      content = content.replaceAll('part "/', 'part "$replacementPrefix/');

      if (content != originalContent) {
        entity.writeAsStringSync(content);
        count++;
        // print('Fixed: ${entity.path}');
      }
    }
  });

  print('Fixed imports in $count files.');
}
