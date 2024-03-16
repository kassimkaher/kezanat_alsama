class MufatehAljynanModel {
  List<DuaEntity>? dua;

  MufatehAljynanModel({this.dua});

  MufatehAljynanModel.fromJson(Map<String, dynamic> json) {
    if (json['dua'] != null) {
      dua = <DuaEntity>[];
      json['dua'].forEach((v) {
        dua!.add(new DuaEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dua != null) {
      data['dua'] = this.dua!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DuaEntity {
  String? title;
  String? path;
  String? text;
  String? desc;
  String? type;

  DuaEntity({this.title, this.path, this.text, this.desc, this.type});

  DuaEntity.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    path = json['path'];
    text = json['text'];
    desc = json['desc'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['path'] = this.path;
    data['text'] = this.text;
    data['desc'] = this.desc;
    data['type'] = this.type;
    return data;
  }
}
