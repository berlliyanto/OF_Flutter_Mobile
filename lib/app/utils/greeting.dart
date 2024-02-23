String greeting() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;
  if (currentHour >= 3 && currentHour < 12) {
    return "Good Morning";
  } else if (currentHour >= 12 && currentHour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
