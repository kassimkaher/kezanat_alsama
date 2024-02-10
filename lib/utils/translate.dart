import 'enums.dart';

class Translation {
  static Lang lang = Lang.arbic;
  static Map<String, dynamic> englishString = {"dua": "Dua", "quran": "Quran"};
  static Map<String, dynamic> arabicTranslate = {
    "dua": "الادعية",
    "quran": "القرآن",
    "zyara": "زيارة",
    "salat": "صلاة",
    "daily": "عمل يومي", //not need to select any date time info
    "weekly": "عمل اسبوعي", //need select weekday as sunday , monday ..etc.
    "dayInmonth": "عمل يوم واحد في الشهر", //need select month and day
    "dailyInMonth": "عمل يوميا في شهر", //need select month only
    "weeklyInMonth": "عمل اسبوعي في شهر", //need select weekday and month
    "oneWeekDayInMonth": "عمل يوم اسبرعي واحد في شهر ",

    "monday": "الاثنين",
    "tusday": "الثلاثاء",
    "wedensday": "الأربعاء",
    "thursday": "الخميس",
    "friday": "الجمعة",
    "saturday": "السبت",
    "sunday": "الأحد",
  };
}
