import 'package:hive/hive.dart';
part 'arabic_date_model.g.dart';

@HiveType(typeId: 3)
class ArabicDateEntry {
  @HiveField(0)
  String year;
  @HiveField(1)
  String month;
  @HiveField(2)
  String day;
  ArabicDateEntry(this.year, this.month, this.day);
}
