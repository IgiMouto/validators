class Validators {
  static final RegExp personNameRegExp =
      RegExp(r"^([ \u00c0-\u01ffa-zA-Z'\-])+$");

  static final RegExp emailRegExp = RegExp(
      r"""(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])""");
  static final RegExp phPhoneNumber = RegExp(r'^(09|\+639)\d{9}$');

  static String? validatePersonName(String? value) {
    if (value == null || (value.isEmpty)) {
      return 'This field is required';
    } else if (!personNameRegExp.hasMatch(value)) {
      return 'Invalid name';
    } else {
      return null;
    }
  }

  static String? validateEmail(String? value) {
    if (value == null || (value.isEmpty)) {
      return 'This field is required';
    } else if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    } else {
      return null;
    }
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || (value.isEmpty)) {
      return 'This field is required';
    } else if (!phPhoneNumber.hasMatch(value)) {
      return 'Please enter a valid phone number';
    } else {
      return null;
    }
  }

  static String? validateDropDown(String? value) {
    if (value == null || (value.isEmpty)) {
      return 'This field is required';
    } else {
      return null;
    }
  }

  static String? validateAge(int? value) {
    if (value == null) {
      return 'This field is required';
    } else if (value < 18) {
      return "Age must be greater than or equal to 18 years old";
    } else {
      return null;
    }
  }
}
