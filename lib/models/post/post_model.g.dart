// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      location: json['location'] as String?,
      description: json['description'] as String?,
      id: json['_id'] as String?,
      likes:
          (json['likes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
      'images': instance.images,
      'friends': instance.friends,
      'location': instance.location,
      'description': instance.description,
      '_id': instance.id,
      'likes': instance.likes,
    };
