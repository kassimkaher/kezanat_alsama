import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramadan/src/main_app/home/daily_work/model/daily_work_model.dart';

class WorkEntity {
  DailyWorkModel? dailyWorkModel;
  List<QueryDocumentSnapshot<Map<String, dynamic>>>? refrenses;
  WorkEntity(this.dailyWorkModel, this.refrenses);
}
