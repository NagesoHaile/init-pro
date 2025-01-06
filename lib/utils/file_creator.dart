import 'dart:io';

void createFile(String dirPath, String fileName, String content) {
  final file = File('$dirPath/$fileName');
  file.writeAsString(content);
  print('File created: $dirPath/$fileName');
}
