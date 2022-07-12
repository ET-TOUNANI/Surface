import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File("$path/immos.xlsx");
}

Future<File> save(Excel excel) async {
  final file = await _localFile;
  return file.writeAsBytes(List.from(await excel.encode()));
}