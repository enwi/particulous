import 'dart:io';

import 'package:path/path.dart';

class ApplicationDirectories {
  final Directory documentsDir;
  final Directory imageDir;
  ApplicationDirectories(this.documentsDir)
      : imageDir = Directory(join(documentsDir.path, 'particulous', 'image')) {
    imageDir.create(recursive: true);
  }
}
