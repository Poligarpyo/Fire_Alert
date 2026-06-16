class EditProfileFormValidator {
  static String? validateName(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return "Full name is required";
    }
    if (name.length < 3) {
      return "Name must be at least 3 characters";
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) {
      return "Phone number is required";
    }
    if (phone.length != 10 || !phone.startsWith('9')) {
      return "Enter a valid 10-digit PH mobile number starting with 9";
    }
    return null;
  }

  static String? validateAddress(String? value) {
    final address = value?.trim() ?? '';
    if (address.isEmpty) {
      return "Address is required";
    }
    if (address.length < 10) {
      return "Please enter a complete address";
    }
    return null;
  }
}
