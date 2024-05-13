// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeEventModel _$HomeEventModelFromJson(Map<String, dynamic> json) =>
    HomeEventModel(
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
          ?.map((e) => e as String)
          .toList(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      price: json['price'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$HomeEventModelToJson(HomeEventModel instance) =>
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

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      coordinates: json['coordinates'] == null
          ? null
          : Coordinates.fromJson(json['coordinates'] as Map<String, dynamic>),
      id: json['_id'] as String?,
      address: json['address'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'coordinates': instance.coordinates,
      '_id': instance.id,
      'address': instance.address,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      '__v': instance.v,
    };

Coordinates _$CoordinatesFromJson(Map<String, dynamic> json) => Coordinates(
      type: json['type'] as String?,
      coordinates: (json['coordinates'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$CoordinatesToJson(Coordinates instance) =>
    <String, dynamic>{
      'type': instance.type,
      'coordinates': instance.coordinates,
    };
