class WeekDay {
  static Map<int, String> _weekDay = {
    0: "Segunda",
    1: "Terça",
    2: "Quarta",
    3: "Quinta",
    4: "Sexta",
  };

  static Map<int, String> get weekDay => _weekDay;

  static String? getWeekDayName(int index) => _weekDay[index];
}
