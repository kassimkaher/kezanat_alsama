import 'package:hive/hive.dart';
part 'setting_model.g.dart';

@HiveType(typeId: 0)
class SettingModel {
  @HiveField(0)
  int isDarkMode = 0;
  @HiveField(1)
  int? city;
  @HiveField(2)
  bool enableNotification = true;
  @HiveField(3)
  int isSetNotification = -1;
  @HiveField(4)
  CityDetails? selectCity;
  SettingModel({
    this.isDarkMode = 0,
    this.city,
    this.enableNotification = true,
    this.isSetNotification = -1,
    this.selectCity,
  });
  SettingModel copyWith({
    int? isDarkMode,
    int? city,
    bool? enableNotification,
    int? isSetNotification,
    CityDetails? selectCity,
  }) {
    return SettingModel(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      city: city ?? this.city,
      enableNotification: enableNotification ?? this.enableNotification,
      isSetNotification: isSetNotification ?? this.isSetNotification,
      selectCity: selectCity ?? this.selectCity,
    );
  }
}

@HiveType(typeId: 1)
class CityDetails {
  @HiveField(0)
  String? name;
  @HiveField(1)
  String? nameAr;
  @HiveField(2)
  double? latitude;
  @HiveField(3)
  double? longitude;

  CityDetails(this.name, this.nameAr, this.latitude, this.longitude);
}

@HiveType(typeId: 2)
class SalatContinus {
  @HiveField(0)
  int day = 0;
  @HiveField(1)
  int salaNumber = 0;
  SalatContinus();
}
