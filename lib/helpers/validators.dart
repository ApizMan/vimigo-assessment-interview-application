class InputValidator {
  static String? required(dynamic value) {
    if (value == null ||
        value == false ||
        ((value is Iterable || value is String || value is Map) &&
            value.length == 0)) {
      return "Please fill in this field";
    } else if (value.length >= 255) {
      return "Too Long (Max${255}Characters)";
    }
    return null;
  }

  static String? phoneNo(String phoneNo) {
    if (phoneNo.length < 9) {
      return "Invalid Phone Number";
    } else if (phoneNo.length > 11) {
      return "Invalid Phone Number";
    }
    return null;
  }

  static String? amount(String amount) {
    if (amount.isEmpty) {
      return "Please Enter the amount";
    }
    return null;
  }

  static String? time(String time) {
    if (time.length != 2) {
      return "Must 2 numeric characters";
    }
    return null;
  }
}
