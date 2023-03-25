class EmsackModel {
  List<DaysPrayerTimes>? days;

  EmsackModel({this.days});

  EmsackModel.fromJson(Map<String, dynamic> json) {
    if (json['days'] != null) {
      days = <DaysPrayerTimes>[];
      json['days'].forEach((v) {
        days!.add(new DaysPrayerTimes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DaysPrayerTimes {
  int? month;
  int? day;
  int? dayname;
  PrayerTimeData? emsak;
  PrayerTimeData? morningPrayer;
  PrayerTimeData? morningSun;
  PrayerTimeData? sunPrayer;
  PrayerTimeData? nightPrayer;
  PrayerTimeData? nightHalf;

  DaysPrayerTimes(
      {this.month,
      this.day,
      this.dayname,
      this.emsak,
      this.morningPrayer,
      this.morningSun,
      this.sunPrayer,
      this.nightPrayer,
      this.nightHalf});

  DaysPrayerTimes.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    day = json['day'];
    dayname = json['dayname'];
    emsak = json['emsak'] != null
        ? new PrayerTimeData.fromJson(json['emsak'])
        : null;
    morningPrayer = json['morning_prayer'] != null
        ? new PrayerTimeData.fromJson(json['morning_prayer'])
        : null;
    morningSun = json['morning_sun'] != null
        ? new PrayerTimeData.fromJson(json['morning_sun'])
        : null;
    sunPrayer = json['sun_prayer'] != null
        ? new PrayerTimeData.fromJson(json['sun_prayer'])
        : null;
    try {
      nightPrayer = json['night_prayer'] != null
          ? PrayerTimeData.fromJson(json['night_prayer'])
          : null;

      nightPrayer!.hour = (nightPrayer!.hour!) + 12;
    } catch (e) {}

    try {
      nightHalf = json['night_half'] != null
          ? new PrayerTimeData.fromJson(json['night_half'])
          : null;
      nightHalf!.hour = (nightHalf!.hour!) + 12;
    } catch (e) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['month'] = this.month;
    data['day'] = this.day;
    data['dayname'] = this.dayname;
    if (this.emsak != null) {
      data['emsak'] = this.emsak!.toJson();
    }
    if (this.morningPrayer != null) {
      data['morning_prayer'] = this.morningPrayer!.toJson();
    }
    if (this.morningSun != null) {
      data['morning_sun'] = this.morningSun!.toJson();
    }
    if (this.sunPrayer != null) {
      data['sun_prayer'] = this.sunPrayer!.toJson();
    }
    if (this.nightPrayer != null) {
      data['night_prayer'] = this.nightPrayer!.toJson();
    }
    if (this.nightHalf != null) {
      data['night_half'] = this.nightHalf!.toJson();
    }
    return data;
  }
}

class PrayerTimeData {
  int? hour;
  int? minut;

  PrayerTimeData({this.hour, this.minut});

  PrayerTimeData.fromJson(Map<String, dynamic> json) {
    hour = json['hour'];
    minut = json['minut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hour'] = this.hour;
    data['minut'] = this.minut;
    return data;
  }
}

class FullTime {
  int hour;
  int minuts;
  int seconds;
  FullTime(this.hour, this.minuts, this.seconds);
}
