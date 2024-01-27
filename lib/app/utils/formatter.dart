import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) {
    return '-';
  } else {
    return DateFormat('dd MMMM yyyy - HH:mm:ss').format(date);
  }
}

String capitalizeFirstChar(String input) {
  return input.replaceAllMapped(
      RegExp(r'\b\w'), (match) => match.group(0)!.toUpperCase());
}

List<String> shiftToHour(int shift) {
  switch (shift) {
    case 1:
      return ["08:00", "16:00"];
    case 2:
      return ["16:00", "23:59"];
    case 3:
      return ["00:00", "08:00"];
    default:
      return ["00:00", "00:00"];
  }
}

String formatTime(int hour, int minute) {
  return "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}";
}

double differenceTime(String startTime, String endTime) {
  List<int> start = startTime.split(":").map(int.parse).toList();
  List<int> end = endTime.split(":").map(int.parse).toList();

  int totalMinutes = (end[0] + 24) * 60 + end[1] - start[0] * 60 - start[1];
  double totalTimeInDecimal = totalMinutes / 60.0;

  double roundedTime = double.parse(totalTimeInDecimal.toStringAsFixed(1));

  return roundedTime;
}
