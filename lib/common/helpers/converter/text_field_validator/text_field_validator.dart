class TextValidatorService {
  String? emptyCheck(String? value) =>
      value == null || value.trim().isEmpty ? 'Field cannot be empty' : null;
}
