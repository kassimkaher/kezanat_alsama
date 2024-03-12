import 'package:ramadan/bussines_logic/Setting/model/setting_model.dart';

class CitesModel {
  List<ProvinceData>? provinces;

  CitesModel({this.provinces});

  CitesModel.fromJson(Map<String, dynamic> json) {
    if (json['provinces'] != null) {
      provinces = <ProvinceData>[];
      json['provinces'].forEach((v) {
        provinces!.add(new ProvinceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (provinces != null) {
      data['provinces'] = provinces!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProvinceData {
  String? name;
  String? nameAr;
  Coordinates? coordinates;

  ProvinceData({this.name, this.nameAr, this.coordinates});

  ProvinceData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    nameAr = json['name_ar'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['name_ar'] = this.nameAr;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates!.toJson();
    }
    return data;
  }

  CityDetails toCityDetailsModel() {
    return CityDetails(
        name, nameAr, coordinates!.latitude, coordinates!.longitude);
  }
}

class Coordinates {
  double? latitude;
  double? longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
