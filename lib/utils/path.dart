import 'dart:io';

import 'package:path/path.dart' as path;

extension ConvertPath on String {
  String get basename => path.basename(this);
  String get dirname => path.dirname(this);
  String get extension => path.extension(this);
  Directory get asDirectory => Directory(this);
  File get asFile => File(this);
}

extension EditDirectory on Directory {
  String get basename => path.basename(this.path);
  String get dirname => path.dirname(this.path);
  String get extension => path.extension(this.path);
  Directory join(String other) => Directory(path.join(this.path, other));
}

extension EditFile on File {
  String get basename => path.basename(this.path);
  String get dirname => path.dirname(this.path);
  String get extension => path.extension(this.path);
  File join(String other) => File(path.join(this.path, other));
}
