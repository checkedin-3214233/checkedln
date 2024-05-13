// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoEventModel _$InfoEventModelFromJson(Map<String, dynamic> json) =>
    InfoEventModel(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      bannerImages: json['bannerImages'] as String?,
      checkInName: json['checkInName'] as String?,
      startDateTime: json['startDateTime'] == null
          ? null
          : DateTime.parse(json['startDateTime'] as String),
      endDateTime: json['endDateTime'] == null
          ? null
          : DateTime.parse(json['endDateTime'] as String),
      description: json['description'] as String?,
      createdBy: json['createdBy'] as String?,
      attendies: (json['attendies'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'] == null
          ? null
          : LocationModel.fromJson(json['location'] as Map<String, dynamic>),
      price: json['price'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$InfoEventModelToJson(InfoEventModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'bannerImages': instance.bannerImages,
      'checkInName': instance.checkInName,
      'startDateTime': instance.startDateTime?.toIso8601String(),
      'endDateTime': instance.endDateTime?.toIso8601String(),
      'description': instance.description,
      'createdBy': instance.createdBy,
      'attendies': instance.attendies,
      'images': instance.images,
      'location': instance.location,
      'price': instance.price,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };
