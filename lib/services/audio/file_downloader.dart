// file_downloader.dart
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class FileDownloader {
  static Future<String> downloadFile(String url) async {
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    final fileName = Uri.parse(url).pathSegments.last;
    final file = io.File('${directory.path}/$fileName');
    await file.writeAsBytes(response.bodyBytes);
    print('File downloaded to: ${file.path}');
    return file.path;
  }
}
