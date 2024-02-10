import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';

class PostEntity {
  DailyPostsModel? dailyPostsModel;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses;
  PostEntity(this.dailyPostsModel, this.refrenses);
}
