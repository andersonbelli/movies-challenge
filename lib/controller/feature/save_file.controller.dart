import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:image/image.dart';
import 'package:path_provider/path_provider.dart';

class SaveFile {
  static Future<String> saveNetworkImage(String url) async {
    try {
      var savedFile = await SaveFile().saveImage(url);
      return savedFile.path;
    } on Error catch (e) {
      print(e.toString());

      return null;
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> getImageFromNetwork(String url) async {
    File file = await DefaultCacheManager().getSingleFile(url);

    return file;
  }

  Future<File> saveImage(String url) async {
    final file = await getImageFromNetwork(url);
    //retrieve local path for device
    var path = await _localPath;
    Image image = decodeImage(file.readAsBytesSync());

    return new File('$path/${DateTime.now().toUtc().toIso8601String()}.jpg');
  }
}