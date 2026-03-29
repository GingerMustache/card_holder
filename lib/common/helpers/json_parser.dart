abstract class JsonParser {
  static dynamic toJsonOrNull<T>(
    dynamic value,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (value == null) return null;
    return fromJson(value);
  }

  static String toStringValue(dynamic value) {
    return value?.toString() ?? '';
  }

  static String? toStringOrNull(dynamic value) {
    return value?.toString();
  }

  static int toInt(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();

    return double.tryParse(value.toString())?.toInt() ?? 0;
  }

  static int toIntOrValue(dynamic value, int insteadValue) {
    if (value is int) return value;
    if (value is double) return value.toInt();

    return double.tryParse(value.toString())?.toInt() ?? insteadValue;
  }

  static int? toIntOrNull(dynamic value) {
    if (value is int) return value;
    if (value is double) return value.toInt();

    return double.tryParse(value.toString())?.toInt();
  }

  static double toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();

    return double.tryParse(value.toString()) ?? 0;
  }

  static double? toDoubleOrNull(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();

    return double.tryParse(value.toString());
  }

  static bool toBool(dynamic value) {
    if (value is bool) return value;
    if (value is int) return value == 1;
    if (value is String) {
      return value.toLowerCase() == 'true' || value.toLowerCase() == '1';
    }

    return false;
  }

  static List<T> list<T>(
    List<dynamic>? data,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    if (data == null) return [];

    return data.map((item) {
      return fromJson(item as Map<String, dynamic>);
    }).toList();
  }
}
