// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      notificationData: json['notificationData'] as String?,
      fromUser: json['fromUser'] == null
          ? null
          : UserModel.fromJson(json['fromUser'] as Map<String, dynamic>),
      type: json['type'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'notificationData': instance.notificationData,
      'fromUser': instance.fromUser,
      'type': instance.type,
      '_id': instance.id,
    };
