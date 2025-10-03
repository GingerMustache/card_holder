part of 'brightness_control_service.dart';

class BrightnessException implements Exception {
  final String message;
  BrightnessException(this.message);

  @override
  String toString() => 'BrightnessException: $message';
}
