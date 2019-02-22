int timeNow() {
  return  DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day).difference(DateTime.utc(2019, 2, 19)).inDays;
}