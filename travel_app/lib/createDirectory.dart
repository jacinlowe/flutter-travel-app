import 'dart:io';

void main() async {
  var directory = await Directory('test/dir').create(recursive: true);
  print(directory.path);
}
