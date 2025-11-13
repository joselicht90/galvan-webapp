import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDate({String? locale}) {
    // si no se pasa locale, usa la del sistema
    final formatter = DateFormat.yMd(locale).add_Hm(); // fecha corta + hora
    return formatter.format(this);
  }
}
