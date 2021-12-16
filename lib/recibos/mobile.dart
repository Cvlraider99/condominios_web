import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

Future <void> guardarYCorrerArchivo (List<int> bytes, String nombreArchivo) async{
  //final path = (await getApplicationDocumentsDirectory()).path;
  final file = File('$nombreArchivo');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$nombreArchivo');
}