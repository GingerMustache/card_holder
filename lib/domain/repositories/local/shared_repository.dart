import 'package:card_holder/common/mixins/error_handler_mixin.dart';
import 'package:card_holder/common/services/share/shared_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class ShareRepository {
  Future<Either<Exception, void>> shareText({
    required String text,
    String? subject,
  });

  Future<Either<Exception, void>> shareFiles({
    required List<String> paths,
    String? text,
    String? subject,
    BuildContext? context,
  });
}

class ShareRepositoryImpl with ErrorHandlerMixin implements ShareRepository {
  final ShareService shareService;

  ShareRepositoryImpl({required this.shareService});

  @override
  Future<Either<Exception, void>> shareText({
    required String text,
    String? subject,
  }) => safeCall(() => shareService.shareText(text: text, subject: subject));

  @override
  Future<Either<Exception, void>> shareFiles({
    required List<String> paths,
    String? text,
    String? subject,
    BuildContext? context,
  }) => safeCall(
    () => shareService.shareFiles(
      paths: paths,
      text: text,
      subject: subject,
      context: context,
    ),
  );
}
