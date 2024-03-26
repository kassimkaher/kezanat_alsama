// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NotificationModelImpl _$$NotificationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$NotificationModelImpl(
      type: $enumDecodeNullable(_$NotificationTypeEnumMap, json['type']),
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$NotificationModelImplToJson(
        _$NotificationModelImpl instance) =>
    <String, dynamic>{
      'type': _$NotificationTypeEnumMap[instance.type],
      'data': instance.data,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.emsak: 'emsak',
  NotificationType.fajer: 'fajer',
  NotificationType.duhur: 'duhur',
  NotificationType.mugrib: 'mugrib',
  NotificationType.work: 'work',
  NotificationType.other: 'other',
};
