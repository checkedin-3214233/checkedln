import 'package:json_annotation/json_annotation.dart';

part 'home_event_model.g.dart';

@JsonSerializable()
class HomeEventModel {
  HomeEventModel({
    required this.id,
    required this.type,
    required this.bannerImages,
    required this.checkInName,
    required this.startDateTime,
    required this.endDateTime,
    required this.description,
    required this.createdBy,
    required this.attendies,
    required this.images,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final String? type;
  static const String typeKey = "type";

  final String? bannerImages;
  static const String bannerImagesKey = "bannerImages";

  final String? checkInName;
  static const String checkInNameKey = "checkInName";

  final DateTime? startDateTime;
  static const String startDateTimeKey = "startDateTime";

  final DateTime? endDateTime;
  static const String endDateTimeKey = "endDateTime";

  final String? description;
  static const String descriptionKey = "description";

  final String? createdBy;
  static const String createdByKey = "createdBy";

  final List<String>? attendies;
  static const String attendiesKey = "attendies";

  final List<String>? images;
  static const String imagesKey = "images";

  final Location? location;
  static const String locationKey = "location";

  final int? price;
  static const String priceKey = "price";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";


  @JsonKey(name: '__v')
  final int? v;
  static const String vKey = "__v";


  HomeEventModel copyWith({
    String? id,
    String? type,
    String? bannerImages,
    String? checkInName,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? description,
    String? createdBy,
    List<String>? attendies,
    List<String>? images,
    Location? location,
    int? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return HomeEventModel(
      id: id ?? this.id,
      type: type ?? this.type,
      bannerImages: bannerImages ?? this.bannerImages,
      checkInName: checkInName ?? this.checkInName,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      attendies: attendies ?? this.attendies,
      images: images ?? this.images,
      location: location ?? this.location,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory HomeEventModel.fromJson(Map<String, dynamic> json) => _$HomeEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$HomeEventModelToJson(this);

  @override
  String toString(){
    return "$id, $type, $bannerImages, $checkInName, $startDateTime, $endDateTime, $description, $createdBy, $attendies, $images, $location, $price, $createdAt, $updatedAt, $v, ";
  }
}

@JsonSerializable()
class Location {
  Location({
    required this.coordinates,
    required this.id,
    required this.address,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final Coordinates? coordinates;
  static const String coordinatesKey = "coordinates";


  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final String? address;
  static const String addressKey = "address";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";


  @JsonKey(name: '__v')
  final int? v;
  static const String vKey = "__v";


  Location copyWith({
    Coordinates? coordinates,
    String? id,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return Location(
      coordinates: coordinates ?? this.coordinates,
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  @override
  String toString(){
    return "$coordinates, $id, $address, $createdAt, $updatedAt, $v, ";
  }
}

@JsonSerializable()
class Coordinates {
  Coordinates({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  static const String typeKey = "type";

  final List<double>? coordinates;
  static const String coordinatesKey = "coordinates";


  Coordinates copyWith({
    String? type,
    List<double>? coordinates,
  }) {
    return Coordinates(
      type: type ?? this.type,
      coordinates: coordinates ?? this.coordinates,
    );
  }

  factory Coordinates.fromJson(Map<String, dynamic> json) => _$CoordinatesFromJson(json);

  Map<String, dynamic> toJson() => _$CoordinatesToJson(this);

  @override
  String toString(){
    return "$type, $coordinates, ";
  }
}
