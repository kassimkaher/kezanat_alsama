class MufatehItemModel {
  List<Datam>? datam;

  MufatehItemModel({this.datam});

  MufatehItemModel.fromJson(Map<String, dynamic> json) {
    if (json['datam'] != null) {
      datam = [];
      json['datam'].forEach((v) {
        datam?.add(new Datam.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.datam != null) {
      data['datam'] = datam?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datam {
  String? id;
  String? title;
  String? subtitle;
  String? content;
  int? catId;

  Datam({this.id, this.title, this.subtitle, this.content, this.catId});

  Datam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subtitle = json['subtitle'];
    content = json['content'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['subtitle'] = this.subtitle;
    data['content'] = this.content;
    data['cat_id'] = this.catId;
    return data;
  }
}
