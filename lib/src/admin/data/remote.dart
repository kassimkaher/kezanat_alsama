import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ramadan/src/core/entity/data_state.dart';
import 'package:ramadan/src/admin/entity/entity.dart';
import 'package:ramadan/src/main_app/slider/data/model/slider_model.dart';
import 'package:ramadan/utils/extention.dart';

class FirestorePost {
  static final dailyPosts = FirebaseFirestore.instance.collection('/posts');

  static Future<DocumentReference<Map<String, dynamic>>> addPost(
      DailyPostData dailyPostsModel) {
    return dailyPosts.add(dailyPostsModel.toJson());
  }

  static Future<DataState<PostEntity>> getPostsApi() async {
    try {
      final data = await dailyPosts.get();
      final List<DailyPostData> list = [];
      for (var element in data.docs) {
        try {
          final data = element.data();
          data['id'] = element.id;
          list.add(DailyPostData.fromJson(data));
        } catch (e) {}
      }

      if (list.isEmpty) {
        return const DataNotSet();
      }

      return DataSuccess(PostEntity(
          DailyPostsModel(data: list, dateTime: DateTime.now()), data.docs));
    } catch (e) {
      kdp(name: "getposts", msg: e.toString(), c: 'r');
      return DataFailed(ApiError(code: 0, msg: e.toString()));
    }
  }
}
