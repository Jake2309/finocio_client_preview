import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DicrectoryHelp {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get localFile async {
    final path = await _localPath;
    return File('$path/watch_list.json');
  }
}
