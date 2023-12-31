import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

Future<XFile?> compressImage(File file) async {
  final filePath = file.absolute.path;
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    
    quality: 80, // You can adjust the quality as needed
  );

  return result;
}
