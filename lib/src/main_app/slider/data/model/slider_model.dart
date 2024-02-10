class DailyPostsModel {
  List<DailyPostData>? data;
  DateTime? dateTime;
  DailyPostsModel({this.data, this.dateTime});
  DailyPostsModel.fromJson(dynamic json) {
    try {
      dateTime = DateTime.tryParse(json['dateTime'].toString());
    } catch (_) {}
    data = [];
    try {
      json['data'].forEach((e) => data!.add(DailyPostData.fromJson(e)));
    } catch (_) {}
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = new Map<String, dynamic>();
    List<Map<dynamic, dynamic>> datajson = [];
    data?.forEach((e) => datajson.add(e.toJson()));
    json['dateTime'] = this.dateTime;
    json['data'] = datajson;

    return json;
  }
}

class DailyPostData {
  String? id;
  String? author;
  String? title;
  String? description;
  String? image;
  int? date;

  DailyPostData(
      {this.author,
      this.title,
      this.description,
      this.image,
      this.date,
      this.id});

  DailyPostData.fromJson(dynamic json) {
    id = json['id'];
    author = json['author'];
    title = json['title'];
    description = json['description'];
    image = json['image'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author'] = this.author;
    data['title'] = this.title;
    data['description'] = this.description;
    data['image'] = this.image;
    data['date'] = this.date;
    data['id'] = this.id;
    return data;
  }
}
