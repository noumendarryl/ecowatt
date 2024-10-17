import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeAgo;

class Formatters {
  static String formatDate(DateTime date, {String? format = 'yyyy-MM-dd'}) {
    return DateFormat(format).format(date);
  }

  static String getRelativeDateTime(DateTime date) {
    return timeAgo.format(date);
  }

  static bool isEmailValid(String email) {
    return RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  static String? checkPassword(String password, {String? confirmPassword}) {
    if (password.length < 8) {
      return "Password must be at least 8 characters long";
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return "Password must contain at least one uppercase letter";
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return "Password must contain at least one lowercase letter";
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return "Password must contain at least one number";
    }
    if (!password
        .contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "Password must contain at least one special character";
    }
    if (confirmPassword != null) {
      if (!isPasswordConfirmed(password, confirmPassword)) {
        return "Password and confirm password must be the same";
      }
    }
    return null;
  }

  static bool isPasswordConfirmed(String? password, String? confirmPassword) {
    return password == confirmPassword ?  true : false;
  }

  // static String checkPhoneNumber(String? phoneNumber) {
  //   if (phoneNumber == null || phoneNumber.isEmpty) return '';
  //   String formattedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');
  //   if (formattedNumber.length == 10) {
  //     return '($formattedNumber.substring(0, 3)) $formattedNumber.substring(3, 6)-$formattedNumber.substring(6)';
  //   } else if (formattedNumber.length == 11 &&
  //       formattedNumber.startsWith('1')) {
  //     return '+$formattedNumber';
  //   } else {
  //     return phoneNumber;
  //   }
  // }
}
