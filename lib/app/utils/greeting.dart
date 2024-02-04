String greeting() {
  DateTime now = DateTime.now();
  int currentHour = now.hour;
  if (currentHour >= 5 && currentHour < 12) {
    return "Selamat Pagi";
  } else if (currentHour >= 12 && currentHour < 16) {
    return "Selamat Siang";
  } else if (currentHour >= 16 && currentHour < 18) {
    return "Selamat Sore";
  } else {
    return "Selamat Malam";
  }
}
