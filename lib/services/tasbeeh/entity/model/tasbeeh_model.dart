class TasbeehLocalModel {
  final TasbeehModel tasbeehModel;
  final int repetitionNumber;

  TasbeehLocalModel(
      {required this.tasbeehModel, required this.repetitionNumber});

  factory TasbeehLocalModel.fromJson(Map<dynamic, dynamic> json) {
    return TasbeehLocalModel(
        tasbeehModel: TasbeehModel(
            tasbeehList: (json['data'] as List<dynamic>)
                .map((e) => TasbeehData.fromJson(e))
                .toList()),
        repetitionNumber: json['repetition_number']);
  }

  Map<String, dynamic> toJson() {
    return {
      "data": tasbeehModel.toJson(),
      'repetition_number': repetitionNumber
    };
  }
}

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
  List<Map<String, dynamic>> toJson() {
    return tasbeehList.map((e) => e.toJson()).toList();
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

  factory TasbeehData.fromJson(Map<dynamic, dynamic> json) {
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

  bool isEqual(TasbeehData tasbeehList) {
//     kdp(
//         name: "is equal",
//         msg: '''

// title ||${tasbeehList.title.compareTo(title)}
// subtitle ||${tasbeehList.subtitle.compareTo(subtitle)}
// description ||${tasbeehList.description.compareTo(description)}
// speak ||${tasbeehList.speak.compareTo(speak)}
// number ||${tasbeehList.number.compareTo(number)}

// ''',
    // c: 'gr');
    if (tasbeehList.title.compareTo(title) != 0 ||
        tasbeehList.description.compareTo(description) != 0 ||
        tasbeehList.number.compareTo(number) != 0 ||
        tasbeehList.speak.compareTo(speak) != 0 ||
        tasbeehList.subtitle.compareTo(subtitle) != 0) {
      return false;
    }

    return true;
  }
}
