String greeting() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;
  if (currentHour >= 5 && currentHour < 12) {
    return "Good Morning";
  } else if (currentHour >= 12 && currentHour < 16) {
    return "Good Afternoon";
  } else if (currentHour >= 16 && currentHour < 18) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}
