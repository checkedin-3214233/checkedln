import 'package:json_annotation/json_annotation.dart';

part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfileModel {
  UserProfileModel(
      {required this.success,
      required this.message,
      required this.user,
      required this.isRequested,
      required this.isSent});

  final bool? success;
  static const String successKey = "success";

  final String? message;
  static const String messageKey = "message";

  final User? user;
  static const String userKey = "user";

  final bool? isRequested;
  static const String isRequestedKey = "isRequested";

  final bool? isSent;
  static const String isSentKey = "isSent";

  UserProfileModel copyWith({
    bool? success,
    String? message,
    User? user,
    bool? isRequested,
    bool? isSent,
  }) {
    return UserProfileModel(
      success: success ?? this.success,
      message: message ?? this.message,
      user: user ?? this.user,
      isRequested: isRequested ?? this.isRequested,
      isSent: isSent ?? this.isSent,
    );
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UserProfileModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileModelToJson(this);

  @override
  String toString() {
    return "$success, $message, $user, $isRequested, $isSent, ";
  }
}

@JsonSerializable()
class User {
  User({
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

  final List<String>? buddies;
  static const String buddiesKey = "buddies";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  @JsonKey(name: '__v')
  final int? v;
  static const String vKey = "__v";

  User copyWith({
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
    List<String>? buddies,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return User(
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
    );
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return "$id, $name, $userName, $phone, $profileImageUrl, $notificationToken, $dateOfBirth, $gender, $userImages, $bio, $buddies, $createdAt, $updatedAt, $v, ";
  }
}
