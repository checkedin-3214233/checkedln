import 'package:json_annotation/json_annotation.dart';

import '../location/location_model.dart';

part 'event_model.g.dart';

@JsonSerializable()
class EventModel {
  EventModel({
    required this.type,
    required this.status,
    required this.bannerImages,
    required this.checkInName,
    required this.startDateTime,
    required this.endDateTime,
    required this.location,
    required this.description,
    required this.createdBy,
    required this.attendies,
    required this.images,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? type;
  static const String typeKey = "type";

  final String? status;
  static const String statusKey = "status";

  final String? bannerImages;
  static const String bannerImagesKey = "bannerImages";

  final String? checkInName;
  static const String checkInNameKey = "checkInName";

  final DateTime? startDateTime;
  static const String startDateTimeKey = "startDateTime";

  final DateTime? endDateTime;
  static const String endDateTimeKey = "endDateTime";

  final LocationModel? location;
  static const String locationKey = "location";

  final String? description;
  static const String descriptionKey = "description";

  final String? createdBy;
  static const String createdByKey = "createdBy";

  final List<String>? attendies;
  static const String attendiesKey = "attendies";

  final List<String>? images;
  static const String imagesKey = "images";

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  @JsonKey(name: '__v')
  final int? v;
  static const String vKey = "__v";

  EventModel copyWith({
    String? type,
    String? status,
    String? bannerImages,
    String? checkInName,
    DateTime? startDateTime,
    DateTime? endDateTime,
    LocationModel? location,
    String? description,
    String? createdBy,
    List<String>? attendies,
    List<String>? images,
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return EventModel(
      type: type ?? this.type,
      status: status ?? this.status,
      bannerImages: bannerImages ?? this.bannerImages,
      checkInName: checkInName ?? this.checkInName,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      location: location ?? this.location,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      attendies: attendies ?? this.attendies,
      images: images ?? this.images,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory EventModel.fromJson(Map<String, dynamic> json) =>
      _$EventModelFromJson(json);

  Map<String, dynamic> toJson() => _$EventModelToJson(this);

  @override
  String toString() {
    return "$type, $status, $bannerImages, $checkInName, $startDateTime, $endDateTime, $location, $description, $createdBy, $attendies, $images, $id, $createdAt, $updatedAt, $v, ";
  }
}
