import 'package:card_holder/common/services/share/exceptions/shared_service_exceptions.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

abstract final class ShareService {
  Future<void> shareText({required String text, String? subject});

  Future<void> shareFiles({
    required List<String> paths,
    String? text,
    String? subject,
    BuildContext? context,
  });
}

final class ShareServiceImpl implements ShareService {
  static final ShareServiceImpl _instance = ShareServiceImpl._internal();

  ShareServiceImpl._internal();

  factory ShareServiceImpl() => _instance;

  final bool errorFlag = false;

  @override
  Future<void> shareText({required String text, String? subject}) async {
    try {
      await SharePlus.instance.share(ShareParams(text: text, subject: subject));
    } catch (e) {
      throw TextSharedException();
    }
  }

  @override
  Future<void> shareFiles({
    required List<String> paths,
    String? text,
    String? subject,
    BuildContext? context,
  }) async {
    if (errorFlag) return;

    try {
      final box = context?.findRenderObject() as RenderBox?;
      final files = paths.map((p) => XFile(p)).toList();

      await SharePlus.instance.share(
        ShareParams(
          files: files,
          text: text,
          subject: subject,
          sharePositionOrigin:
              box != null ? box.localToGlobal(Offset.zero) & box.size : null,
        ),
      );
    } catch (e) {
      throw FileSharedException();
    }
  }
}
