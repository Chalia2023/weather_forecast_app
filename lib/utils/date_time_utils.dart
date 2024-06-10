import 'package:intl/intl.dart';

String formatTime(String timeString) {
  DateTime dateTime = DateTime.parse(timeString);
  return DateFormat('M/d HH:mm').format(dateTime);
}

String getTimeLabel(String timeString) {
  final today = DateTime.now();
  final tomorrow = today.add(const Duration(days: 1));
  final timeDateTime = DateTime.parse(timeString);
  String timeLabel = '';
  if (timeDateTime.year == today.year &&
      timeDateTime.month == today.month &&
      timeDateTime.day == today.day) {
    timeLabel = '今天 ';
  } else if (timeDateTime.year == tomorrow.year &&
      timeDateTime.month == tomorrow.month &&
      timeDateTime.day == tomorrow.day) {
    timeLabel = '明天 ';
  }
  return timeLabel;
}
