import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ramadan/utils/utils.dart';

part 'model.freezed.dart';
part 'model.g.dart';

@freezed
class NotificationModel with _$NotificationModel {
  const factory NotificationModel({
    NotificationType? type,
    Map<dynamic, dynamic>? data,
  }) = _NotificationModel;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);
}
