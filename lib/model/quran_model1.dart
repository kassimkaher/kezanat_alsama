// class QuranModel {
//   List<Suar>? suar;

//   QuranModel({this.suar});

//   QuranModel.fromJson(Map<String, dynamic> json) {
//     if (json['suar'] != null) {
//       suar = [];
//       json['suar'].forEach((v) {
//         suar?.add(new Suar.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (suar != null) {
//       data['suar'] = suar?.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Suar {
//   String? name;
//   String? number;
//   List<String>? ayat;

//   Suar({this.name, this.number, this.ayat});

//   Suar.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     number = json['number'];
//     ayat = json['ayat'].cast<String>();
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['number'] = this.number;
//     data['ayat'] = this.ayat;
//     return data;
//   }
// }

// class ContinuQuranModel {
//   int? suara;
//   int? aya;
//   String? nameSura;
//   String? number;

//   ContinuQuranModel({this.suara, this.aya, this.nameSura, this.number});

//   ContinuQuranModel.fromJson(Map<dynamic, dynamic> json) {
//     suara = json['suara'];
//     aya = json['aya'];
//     nameSura = json['name_sura'];
//     number = json['number'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['suara'] = this.suara;
//     data['aya'] = this.aya;
//     data['name_sura'] = this.nameSura;
//     data['number'] = this.number;
//     return data;
//   }
// }
