import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

enum StorageError { secureStorageError }

enum SecureKeys { lang }

secureStorageCheck(BuildContext context) =>
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // if (secureStorage.errorFlag.value) {
      //   showDialogWithSupport(
      //     centerTitle: true,
      //     context: context,
      //     title: t.system.secureStorageError.title,
      //     contentText: t.system.secureStorageError.error,
      //   );
      // }
    });

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();

  late final FlutterSecureStorage _storage;

  SecureStorage._internal() {
    _storage = FlutterSecureStorage(
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }
  factory SecureStorage() => _instance;

  final bool errorFlag = false;

  Future<Map<String, String>> readAll() async {
    var map = <String, String>{};

    try {
      map = await _storage.readAll();
    } catch (e, stackTrace) {
      errorAction(e, stackTrace);
    }
    return map;
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (e, stackTrace) {
      errorAction(e, stackTrace);
    }
  }

  /// use instead value, when result must not be empty
  Future<String> read(String key, {String insteadValue = ''}) async {
    String value = '';
    if (!errorFlag) {
      try {
        value = (await _storage.read(key: key)) ?? insteadValue;
        throw Exception('bad SecureStore test');
      } catch (e, stackTrace) {
        errorAction(e, stackTrace);
      }
    }
    return value;
  }

  Future<void> delete({required String key}) async {
    try {
      await _storage.delete(key: key);
    } catch (e, stackTrace) {
      errorAction(e, stackTrace);
    }
  }

  Future<void> write({required String key, required String value}) async {
    if (!errorFlag) {
      try {
        await _storage.write(key: key, value: value);
        throw Exception('bad SecureStore test');
      } catch (e, stackTrace) {
        errorAction(e, stackTrace);
      }
    }
  }

  Future<bool> containsKey({required String key}) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (e, stackTrace) {
      errorAction(e, stackTrace);

      return false;
    }
  }

  static IOSOptions _getIOSOptions() =>
      const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  AndroidOptions _getAndroidOptions() =>
      const AndroidOptions(encryptedSharedPreferences: true);

  void errorAction(Object e, StackTrace stackTrace) {
    // talker.error(e);
    // AppMetrica.reportErrorWithGroup(
    //   'SecureStorage',
    //   errorDescription: AppMetricaErrorDescription(
    //     stackTrace,
    //     message: 'Error - $e',
    //   ),
    // );
    // setErrorFlag(true);
  }

  // void setErrorFlag(bool value) => runInAction(() => errorFlag.value = value);
}
