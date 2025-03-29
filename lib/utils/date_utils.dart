import 'package:intl/intl.dart';

class DateUtils {
  static int? calculateAge(String birthDateString) {
    if (birthDateString.isEmpty) return null;

    final DateTime birthDate = DateFormat('dd-MM-yyyy').parse(birthDateString);
    final DateTime today = DateTime.now();

    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }
}
