class MufatehCatModel {
  List<Datac>? category;

  MufatehCatModel({this.category});

  MufatehCatModel.fromJson(Map<String, dynamic> json) {
    if (json['datac'] != null) {
      category = [];
      json['datac'].forEach((v) {
        category?.add(Datac.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (category != null) {
      data['datac'] = category?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datac {
  int? id;
  String? title;
  String? url;
  String? content;

  Datac({this.id, this.title, this.url, this.content});

  Datac.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    url = json['url'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['url'] = this.url;
    data['content'] = "";
    return data;
  }
}
