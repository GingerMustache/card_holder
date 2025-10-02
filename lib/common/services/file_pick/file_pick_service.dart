import 'package:card_holder/common/services/file_pick/exceptions/file_pick_service_exceptions.dart';
import 'package:file_picker/file_picker.dart';

abstract final class FilePickService {
  Future<FilePickerResult?> pickSingleFile({List<String>? allowedExtensions});
  Future<FilePickerResult?> pickMultipleFiles({
    List<String>? allowedExtensions,
  });
  Future<FilePickerResult?> pickJsonFile();
}

final class NetFilePickServiceImpl implements FilePickService {
  static final NetFilePickServiceImpl _instance =
      NetFilePickServiceImpl._internal();

  NetFilePickServiceImpl._internal();

  factory NetFilePickServiceImpl() => _instance;

  @override
  Future<FilePickerResult?> pickSingleFile({
    List<String>? allowedExtensions,
  }) async {
    try {
      return await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );
    } catch (e) {
      throw FilePickException();
    }
  }

  @override
  Future<FilePickerResult?> pickMultipleFiles({
    List<String>? allowedExtensions,
  }) async {
    try {
      return await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: allowedExtensions != null ? FileType.custom : FileType.any,
        allowedExtensions: allowedExtensions,
      );
    } catch (e) {
      throw FilePickException();
    }
  }

  @override
  Future<FilePickerResult?> pickJsonFile() async {
    try {
      return await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
    } catch (e) {
      throw FilePickException();
    }
  }
}
