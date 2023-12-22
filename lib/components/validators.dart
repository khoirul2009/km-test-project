String? notEmptyValidator(var value) {
  if (value == null || value.isEmpty) {
    return 'This field cannot be empty!';
  } else {
    return null;
  }
}
