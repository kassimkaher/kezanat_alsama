class CityModel {
  List<CityData>? city;

  CityModel({this.city});

  CityModel.fromJson(Map<String, dynamic> json) {
    if (json['city'] != null) {
      city = <CityData>[];
      json['city'].forEach((v) {
        city!.add(new CityData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CityData {
  String? name;
  String? path;

  CityData({this.name, this.path});

  CityData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['path'] = this.path;
    return data;
  }
}
