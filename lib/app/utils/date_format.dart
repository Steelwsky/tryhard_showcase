import 'package:intl/intl.dart';

String formattedDate(DateTime dt) {
  return DateFormat('MM/dd/yyyy').format(dt);
}

String formattedDateAndTime(DateTime dt) {
  return DateFormat('MM/dd/yyyy HH:ss').format(dt);
}
