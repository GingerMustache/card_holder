import 'package:card_holder/common/mixins/error_handler_mixin.dart';
import 'package:card_holder/common/services/file_pick/file_pick_service.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';

abstract class FilePickRepository {
  Future<Either<Exception, FilePickerResult?>> pickSingleFile({
    List<String>? allowedExtensions,
  });

  Future<Either<Exception, FilePickerResult?>> pickMultipleFiles({
    List<String>? allowedExtensions,
  });

  Future<Either<Exception, FilePickerResult?>> pickJsonFile();
}

class FilePickRepositoryImpl
    with ErrorHandlerMixin
    implements FilePickRepository {
  final FilePickService filePickService;

  FilePickRepositoryImpl({required this.filePickService});

  @override
  Future<Either<Exception, FilePickerResult?>> pickSingleFile({
    List<String>? allowedExtensions,
  }) => safeCall(
    () => filePickService.pickSingleFile(allowedExtensions: allowedExtensions),
  );

  @override
  Future<Either<Exception, FilePickerResult?>> pickMultipleFiles({
    List<String>? allowedExtensions,
  }) => safeCall(
    () =>
        filePickService.pickMultipleFiles(allowedExtensions: allowedExtensions),
  );

  @override
  Future<Either<Exception, FilePickerResult?>> pickJsonFile() =>
      safeCall(() => filePickService.pickJsonFile());
}
