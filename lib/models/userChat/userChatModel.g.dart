// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userChatModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserChatModel _$UserChatModelFromJson(Map<String, dynamic> json) =>
    UserChatModel(
      users: json['users'] == null
          ? null
          : UserModel.fromJson(json['users'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      totalUnreadMessage: json['totalUnreadMessage'] as int?,
      lastSeen: json['lastSeen'] == null
          ? null
          : DateTime.parse(json['lastSeen'] as String),
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$UserChatModelToJson(UserChatModel instance) =>
    <String, dynamic>{
      'users': instance.users,
      'lastMessage': instance.lastMessage,
      'totalUnreadMessage': instance.totalUnreadMessage,
      'lastSeen': instance.lastSeen?.toIso8601String(),
      '_id': instance.id,
    };
