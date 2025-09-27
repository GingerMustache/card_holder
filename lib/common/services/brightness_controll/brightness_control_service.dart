// Abstract brightness service
import 'package:screen_brightness/screen_brightness.dart';

part 'brightness_exception.dart';

abstract class BrightnessService {
  Future<void> setBrightness(double brightness);
  Future<void> setMaxBrightness();
  Future<double> getBrightness();
  Future<void> saveBrightness(double brightness);
  Future<double> getSavedBrightness();
  Future<void> setDefaultSystemBrightness();
}

class BrightnessServiceImpl implements BrightnessService {
  final _brightness = ScreenBrightness.instance;
  static double _currentBrightness = 0;

  @override
  Future<void> setMaxBrightness() async {
    try {
      await getBrightness();
      await _brightness.setApplicationScreenBrightness(0.7);
      // await _brightness.setSystemScreenBrightness(0.7);
    } catch (e) {
      throw BrightnessException(
        'Failed to set screen max brightness: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> setBrightness(double brightness) async {
    try {
      await _brightness.setSystemScreenBrightness(brightness);
    } catch (e) {
      throw BrightnessException(
        'Failed to set screen brightness: ${e.toString()}',
      );
    }
  }

  @override
  Future<double> getBrightness() async {
    try {
      _currentBrightness = await _brightness.system;
      return _currentBrightness;
    } catch (e) {
      throw BrightnessException(
        'Failed to get screen brightness: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> setDefaultSystemBrightness() async {
    try {
      await _brightness.setApplicationScreenBrightness(_currentBrightness);
    } catch (e) {
      throw BrightnessException(
        'Failed to reset application brightness: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> saveBrightness(double brightness) async {
    throw UnimplementedError;
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   await prefs.setDouble(_brightnessKey, brightness);
    // } catch (e) {
    //   throw BrightnessException(
    //     'Failed to save brightness to local storage: ${e.toString()}',
    //   );
    // }
  }

  @override
  Future<double> getSavedBrightness() async {
    throw UnimplementedError;
    // try {
    //   final prefs = await SharedPreferences.getInstance();
    //   return prefs.getDouble(_brightnessKey) ?? 0.5; // Default brightness
    // } catch (e) {
    //   throw BrightnessException(
    //     'Failed to get saved brightness from local storage: ${e.toString()}',
    //   );
    // }
  }
}
