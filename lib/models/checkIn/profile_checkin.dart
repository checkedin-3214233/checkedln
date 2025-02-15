class ProfileCheckIn {
  ProfileCheckIn({
    required this.id,
    required this.type,
    required this.status,
    required this.bannerImages,
    required this.checkInName,
    required this.startDateTime,
    required this.endDateTime,
    required this.description,
    required this.createdBy,
    required this.attendies,
    required this.interested,
    required this.checkedIn,
    required this.images,
    required this.location,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final String? id;
  static const String idKey = "_id";

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

  final String? description;
  static const String descriptionKey = "description";

  final String? createdBy;
  static const String createdByKey = "createdBy";

  final List<String> attendies;
  static const String attendiesKey = "attendies";

  final List<dynamic> interested;
  static const String interestedKey = "interested";

  final List<String> checkedIn;
  static const String checkedInKey = "checkedIn";

  final List<String> images;
  static const String imagesKey = "images";

  final String? location;
  static const String locationKey = "location";

  final num? price;
  static const String priceKey = "price";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  final num? v;
  static const String vKey = "__v";

  ProfileCheckIn copyWith({
    String? id,
    String? type,
    String? status,
    String? bannerImages,
    String? checkInName,
    DateTime? startDateTime,
    DateTime? endDateTime,
    String? description,
    String? createdBy,
    List<String>? attendies,
    List<dynamic>? interested,
    List<String>? checkedIn,
    List<String>? images,
    String? location,
    num? price,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? v,
  }) {
    return ProfileCheckIn(
      id: id ?? this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      bannerImages: bannerImages ?? this.bannerImages,
      checkInName: checkInName ?? this.checkInName,
      startDateTime: startDateTime ?? this.startDateTime,
      endDateTime: endDateTime ?? this.endDateTime,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      attendies: attendies ?? this.attendies,
      interested: interested ?? this.interested,
      checkedIn: checkedIn ?? this.checkedIn,
      images: images ?? this.images,
      location: location ?? this.location,
      price: price ?? this.price,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory ProfileCheckIn.fromJson(Map<String, dynamic> json) {
    return ProfileCheckIn(
      id: json["_id"],
      type: json["type"],
      status: json["status"],
      bannerImages: json["bannerImages"],
      checkInName: json["checkInName"],
      startDateTime: DateTime.tryParse(json["startDateTime"] ?? ""),
      endDateTime: DateTime.tryParse(json["endDateTime"] ?? ""),
      description: json["description"],
      createdBy: json["createdBy"],
      attendies: json["attendies"] == null
          ? []
          : List<String>.from(json["attendies"]!.map((x) => x)),
      interested: json["interested"] == null
          ? []
          : List<dynamic>.from(json["interested"]!.map((x) => x)),
      checkedIn: json["checkedIn"] == null
          ? []
          : List<String>.from(json["checkedIn"]!.map((x) => x)),
      images: json["images"] == null
          ? []
          : List<String>.from(json["images"]!.map((x) => x)),
      location: json["location"],
      price: json["price"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "type": type,
        "status": status,
        "bannerImages": bannerImages,
        "checkInName": checkInName,
        "startDateTime": startDateTime?.toIso8601String(),
        "endDateTime": endDateTime?.toIso8601String(),
        "description": description,
        "createdBy": createdBy,
        "attendies": attendies.map((x) => x).toList(),
        "interested": interested.map((x) => x).toList(),
        "checkedIn": checkedIn.map((x) => x).toList(),
        "images": images.map((x) => x).toList(),
        "location": location,
        "price": price,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };

  @override
  String toString() {
    return "$id, $type, $status, $bannerImages, $checkInName, $startDateTime, $endDateTime, $description, $createdBy, $attendies, $interested, $checkedIn, $images, $location, $price, $createdAt, $updatedAt, $v, ";
  }
}
