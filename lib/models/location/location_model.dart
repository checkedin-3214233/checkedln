import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable()
class LocationModel {
  LocationModel({
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


  LocationModel copyWith({
    Coordinates? coordinates,
    String? id,
    String? address,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return LocationModel(
      coordinates: coordinates ?? this.coordinates,
      id: id ?? this.id,
      address: address ?? this.address,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory LocationModel.fromJson(Map<String, dynamic> json) => _$LocationModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);

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
