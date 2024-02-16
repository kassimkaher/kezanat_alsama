class TasbeehModel {
  final List<TasbeehData> tasbeehList;

  TasbeehModel({
    required this.tasbeehList,
  });

  factory TasbeehModel.fromJson(Map<String, dynamic> json) {
    return TasbeehModel(
        tasbeehList: (json as List<Map<String, dynamic>>)
            .map((e) => TasbeehData.fromJson(e))
            .toList());
  }
  Map<String, dynamic> toJson() {
    return {"data": tasbeehList.map((e) => e.toJson())};
  }
}

class TasbeehData {
  final String title;
  final String description;
  final int number;
  final String subtitle;
  final String speak;

  TasbeehData({
    required this.title,
    required this.description,
    required this.number,
    required this.subtitle,
    required this.speak,
  });

  factory TasbeehData.fromJson(Map<String, dynamic> json) {
    return TasbeehData(
      title: json['title'],
      description: json['description'],
      number: json['number'],
      subtitle: json['subtitle'],
      speak: json['speak'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'number': number,
      'subtitle': subtitle,
      'speak': speak,
    };
  }
}
