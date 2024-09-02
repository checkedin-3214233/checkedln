// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      userName: json['userName'] as String?,
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      notificationToken: json['notificationToken'] as String?,
      dateOfBirth: json['dateOfBirth'] == null
          ? null
          : DateTime.parse(json['dateOfBirth'] as String),
      gender: json['gender'] as String?,
      userImages: (json['userImages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      bio: json['bio'] as String?,
      buddies: json['buddies'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as num?,
      requestedUser: json['requestedUser'] == null
          ? null
          : RequestedUser.fromJson(
              json['requestedUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'userName': instance.userName,
      'phone': instance.phone,
      'profileImageUrl': instance.profileImageUrl,
      'notificationToken': instance.notificationToken,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'gender': instance.gender,
      'userImages': instance.userImages,
      'bio': instance.bio,
      'buddies': instance.buddies,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
      'requestedUser': instance.requestedUser,
    };

RequestedUser _$RequestedUserFromJson(Map<String, dynamic> json) =>
    RequestedUser(
      id: json['_id'] as String?,
      userId: json['userId'] as String?,
      requestedUser: json['requestedUser'] as List<dynamic>?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as num?,
    );

Map<String, dynamic> _$RequestedUserToJson(RequestedUser instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'userId': instance.userId,
      'requestedUser': instance.requestedUser,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
