import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.userName,
    required this.phone,
    required this.profileImageUrl,
    required this.notificationToken,
    required this.dateOfBirth,
    required this.gender,
    required this.userImages,
    required this.bio,
    required this.buddies,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.requestedUser,
  });

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final String? name;
  static const String nameKey = "name";

  final String? userName;
  static const String userNameKey = "userName";

  final String? phone;
  static const String phoneKey = "phone";

  final String? profileImageUrl;
  static const String profileImageUrlKey = "profileImageUrl";

  final String? notificationToken;
  static const String notificationTokenKey = "notificationToken";

  final DateTime? dateOfBirth;
  static const String dateOfBirthKey = "dateOfBirth";

  final String? gender;
  static const String genderKey = "gender";

  final List<String>? userImages;
  static const String userImagesKey = "userImages";

  final String? bio;
  static const String bioKey = "bio";

  final List<dynamic>? buddies;
  static const String buddiesKey = "buddies";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  @JsonKey(name: '__v')
  final num? v;
  static const String vKey = "__v";

  final RequestedUser? requestedUser;
  static const String requestedUserKey = "requestedUser";

  UserModel copyWith({
    String? id,
    String? name,
    String? userName,
    String? phone,
    String? profileImageUrl,
    String? notificationToken,
    DateTime? dateOfBirth,
    String? gender,
    List<String>? userImages,
    String? bio,
    List<dynamic>? buddies,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? v,
    RequestedUser? requestedUser,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      userName: userName ?? this.userName,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      notificationToken: notificationToken ?? this.notificationToken,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      userImages: userImages ?? this.userImages,
      bio: bio ?? this.bio,
      buddies: buddies ?? this.buddies,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      requestedUser: requestedUser ?? this.requestedUser,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return "$id, $name, $userName, $phone, $profileImageUrl, $notificationToken, $dateOfBirth, $gender, $userImages, $bio, $buddies, $createdAt, $updatedAt, $v, $requestedUser, ";
  }
}

@JsonSerializable()
class RequestedUser {
  RequestedUser({
    required this.id,
    required this.userId,
    required this.requestedUser,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final String? userId;
  static const String userIdKey = "userId";

  final List<dynamic>? requestedUser;
  static const String requestedUserKey = "requestedUser";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  @JsonKey(name: '__v')
  final num? v;
  static const String vKey = "__v";

  RequestedUser copyWith({
    String? id,
    String? userId,
    List<dynamic>? requestedUser,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? v,
  }) {
    return RequestedUser(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      requestedUser: requestedUser ?? this.requestedUser,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory RequestedUser.fromJson(Map<String, dynamic> json) =>
      _$RequestedUserFromJson(json);

  Map<String, dynamic> toJson() => _$RequestedUserToJson(this);

  @override
  String toString() {
    return "$id, $userId, $requestedUser, $createdAt, $updatedAt, $v, ";
  }
}
