import 'package:json_annotation/json_annotation.dart';

part 'userModel.g.dart';

@JsonSerializable()
class UserModel {
  UserModel({
    required this.buddies,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final List<dynamic>? buddies;
  static const String buddiesKey = "buddies";


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

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";


  @JsonKey(name: '__v')
  final int? v;
  static const String vKey = "__v";


  UserModel copyWith({
    List<dynamic>? buddies,
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
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
  }) {
    return UserModel(
      buddies: buddies ?? this.buddies,
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
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString(){
    return "$buddies, $id, $name, $userName, $phone, $profileImageUrl, $notificationToken, $dateOfBirth, $gender, $userImages, $bio, $createdAt, $updatedAt, $v, ";
  }
}
