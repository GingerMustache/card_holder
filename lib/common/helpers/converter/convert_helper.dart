import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:card_holder/common/exceptions/image_helper_exceptions.dart';
import 'package:content_resolver/content_resolver.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';

class ConvertHelper {
  Future<Either<Exception, String>> getImagePathFromRenderObject(
    GlobalKey renderKey,
  ) async {
    try {
      final boundary =
          renderKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Save to temp file
      final tempDir = await getTemporaryDirectory();
      final String filePath = '${tempDir.path}/barcode.png';
      await File(filePath).writeAsBytes(pngBytes);
      return Right(filePath);
    } catch (e) {
      return Left(RenderObjectNotConverted());
    }
  }

  Future<Either<Exception, String>> getJsonFilePath({
    required String fileName,
    required Map<String, Object> jsonList,
  }) async {
    try {
      final currentPath = await getApplicationDocumentsDirectory();
      final file = File('${currentPath.path}/$fileName');
      await file.writeAsString(jsonEncode(jsonList));

      return Right(file.path);
    } catch (e) {
      return Left(JsonFileNotConverted());
    }
  }

  Future<Either<Exception, Map<String, dynamic>>> jsonFromFile({
    required String filePath,
  }) async {
    if (filePath.startsWith('content') || filePath.startsWith('file')) {
      return _linkContentFromFile(filePath: filePath);
    } else {
      return _fromFile(filePath: filePath);
    }
  }

  Future<Either<Exception, Map<String, dynamic>>> _fromFile({
    required String filePath,
  }) async {
    try {
      File file = File(filePath);
      final contents = await file.readAsString();
      final Map<String, dynamic> jsonList = jsonDecode(contents);

      return Right(jsonList);
    } catch (e) {
      return Left(JsonFromFileFailed());
    }
  }

  Future<Either<Exception, Map<String, dynamic>>> _linkContentFromFile({
    required String filePath,
  }) async {
    try {
      // 1. Use ContentResolver to read the URI directly
      final content = await ContentResolver.resolveContent(filePath);

      // 2. Access the bytes
      final bytes = content.data;
      final String contents = utf8.decode(bytes);

      final Map<String, dynamic> jsonMap = jsonDecode(contents);

      return Right(jsonMap);
    } catch (e) {
      return Left(JsonFromFileFailed());
    }
  }
}
