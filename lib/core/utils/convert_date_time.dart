import 'package:intl/intl.dart';

String convertDateTimeToReadable(DateTime timestamp) {
  return DateFormat("d MMM, yyyy").format(timestamp);
}
