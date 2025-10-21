import 'package:card_holder/common/services/file_pick/exceptions/file_pick_service_exceptions.dart';
import 'package:card_holder/common/services/file_pick/file_pick_service.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NetFilePickServiceImpl Tests', () {
    late NetFilePickServiceImpl filePickService;
    const MethodChannel channel = MethodChannel('miguelruivo.flutter.plugins.filepicker');

    setUp(() {
      TestWidgetsFlutterBinding.ensureInitialized();
      filePickService = NetFilePickServiceImpl();
    });

    tearDown(() {
      // Reset any channel handlers after each test
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(channel, null);
    });

    group('pickSingleFile', () {
      test('should pick single file with allowed extensions successfully', () async {
        // Setup mock response
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          // Verify that the method call has the expected parameters
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/to/test.pdf'],
              'names': ['test.pdf'],
              'sizes': [1024],
              'rawFileNames': ['test.pdf'],
            };
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickSingleFile(allowedExtensions: ['pdf']);

        // Verify the result
        expect(result, isNotNull);
        expect(result!.files.length, equals(1));
        expect(result.files.single.name, equals('test.pdf'));
      });

      test('should pick single file without allowed extensions successfully', () async {
        // Setup mock response
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          // Verify that the method call has the expected parameters
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/to/test.txt'],
              'names': ['test.txt'],
              'sizes': [2048],
              'rawFileNames': ['test.txt'],
            };
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickSingleFile();

        // Verify the result
        expect(result, isNotNull);
        expect(result!.files.length, equals(1));
        expect(result.files.single.name, equals('test.txt'));
      });

      test('should return null when no file is selected', () async {
        // Setup mock to return null (no file selected)
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            return null;
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickSingleFile(allowedExtensions: ['jpg']);

        // Verify the result
        expect(result, isNull);
      });

      test('should throw FilePickException when error occurs', () async {
        // Setup mock to throw an exception
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            throw PlatformException(code: 'ERROR', message: 'Test Error');
          }
          return null;
        });

        // Verify that the exception is properly caught and re-thrown as FilePickException
        expect(
          () => filePickService.pickSingleFile(allowedExtensions: ['jpg']),
          throwsA(isA<FilePickException>()),
        );
      });
    });

    group('pickMultipleFiles', () {
      test('should pick multiple files with allowed extensions successfully', () async {
        // Setup mock response with multiple files
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          // Verify that the method call has the expected parameters
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/to/test1.pdf', '/path/to/test2.pdf'],
              'names': ['test1.pdf', 'test2.pdf'],
              'sizes': [1024, 2048],
              'rawFileNames': ['test1.pdf', 'test2.pdf'],
            };
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickMultipleFiles(allowedExtensions: ['pdf']);

        // Verify the result
        expect(result, isNotNull);
        expect(result!.files.length, equals(2));
        expect(result.files[0].name, equals('test1.pdf'));
        expect(result.files[1].name, equals('test2.pdf'));
      });

      test('should pick multiple files without allowed extensions successfully', () async {
        // Setup mock response with multiple files
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          // Verify that the method call has the expected parameters
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/to/test1.txt', '/path/to/test2.jpg'],
              'names': ['test1.txt', 'test2.jpg'],
              'sizes': [1024, 2048],
              'rawFileNames': ['test1.txt', 'test2.jpg'],
            };
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickMultipleFiles();

        // Verify the result
        expect(result, isNotNull);
        expect(result!.files.length, equals(2));
        expect(result.files[0].name, equals('test1.txt'));
        expect(result.files[1].name, equals('test2.jpg'));
      });

      test('should return empty list when no files are selected', () async {
        // Setup mock to return null (no files selected)
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            return null;
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickMultipleFiles(allowedExtensions: ['jpg']);

        // Verify the result
        expect(result, isNull);
      });

      test('should throw FilePickException when error occurs during multiple file pick', () async {
        // Setup mock to throw an exception
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            throw PlatformException(code: 'ERROR', message: 'Test Error');
          }
          return null;
        });

        // Verify that the exception is properly caught and re-thrown as FilePickException
        expect(
          () => filePickService.pickMultipleFiles(allowedExtensions: ['jpg']),
          throwsA(isA<FilePickException>()),
        );
      });
    });

    group('pickJsonFile', () {
      test('should pick JSON file successfully', () async {
        // Setup mock response for JSON file
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          // Verify that the method call has the expected parameters
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/to/test.json'],
              'names': ['test.json'],
              'sizes': [512],
              'rawFileNames': ['test.json'],
            };
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickJsonFile();

        // Verify the result
        expect(result, isNotNull);
        expect(result!.files.length, equals(1));
        expect(result.files.single.name, equals('test.json'));
      });

      test('should return null when no JSON file is selected', () async {
        // Setup mock to return null (no file selected)
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            return null;
          }
          return null;
        });

        // Execute the method
        final result = await filePickService.pickJsonFile();

        // Verify the result
        expect(result, isNull);
      });

      test('should throw FilePickException when error occurs during JSON file pick', () async {
        // Setup mock to throw an exception
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            throw PlatformException(code: 'ERROR', message: 'Test Error');
          }
          return null;
        });

        // Verify that the exception is properly caught and re-thrown as FilePickException
        expect(
          () => filePickService.pickJsonFile(),
          throwsA(isA<FilePickException>()),
        );
      });
    });

    group('Integration Tests', () {
      test('all methods should work with the same instance', () async {
        // Verify singleton pattern works correctly
        final instance1 = NetFilePickServiceImpl();
        final instance2 = NetFilePickServiceImpl();
        
        expect(identical(instance1, instance2), isTrue);
        
        // Verify each method can be called successfully on the same instance
        TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
            .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == 'pickFiles') {
            return {
              'paths': ['/path/test.txt'],
              'names': ['test.txt'],
              'sizes': [1024],
              'rawFileNames': ['test.txt'],
            };
          }
          return null;
        });

        // Call each method and verify they work
        final result1 = await instance1.pickSingleFile();
        expect(result1, isNotNull);
        
        final result2 = await instance1.pickMultipleFiles();
        expect(result2, isNotNull);
        
        final result3 = await instance1.pickJsonFile();
        expect(result3, isNotNull);
      });
    });
  });
}