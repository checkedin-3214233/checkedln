import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel {
  StoryModel({
    required this.id,
    required this.userId,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.userStories,
  });

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final UserId? userId;
  static const String userIdKey = "userId";

  @JsonKey(name: '__v')
  final num? v;
  static const String vKey = "__v";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  final List<UserStory>? userStories;
  static const String userStoriesKey = "userStories";

  StoryModel copyWith({
    String? id,
    UserId? userId,
    num? v,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<UserStory>? userStories,
  }) {
    return StoryModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      v: v ?? this.v,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      userStories: userStories ?? this.userStories,
    );
  }

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);

  @override
  String toString() {
    return "$id, $userId, $v, $createdAt, $updatedAt, $userStories, ";
  }
}

@JsonSerializable()
class UserId {
  UserId({
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
  final num? v;
  static const String vKey = "__v";

  UserId copyWith({
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
    num? v,
  }) {
    return UserId(
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

  factory UserId.fromJson(Map<String, dynamic> json) => _$UserIdFromJson(json);

  Map<String, dynamic> toJson() => _$UserIdToJson(this);

  @override
  String toString() {
    return "$id, $name, $userName, $phone, $profileImageUrl, $notificationToken, $dateOfBirth, $gender, $userImages, $bio, $buddies, $createdAt, $updatedAt, $v, ";
  }
}

@JsonSerializable()
class UserStory {
  UserStory({
    required this.id,
    required this.userId,
    required this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final String? userId;
  static const String userIdKey = "userId";

  final String? imageUrl;
  static const String imageUrlKey = "imageUrl";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  final DateTime? updatedAt;
  static const String updatedAtKey = "updatedAt";

  @JsonKey(name: '__v')
  final num? v;
  static const String vKey = "__v";

  UserStory copyWith({
    String? id,
    String? userId,
    String? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    num? v,
  }) {
    return UserStory(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      imageUrl: imageUrl ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
    );
  }

  factory UserStory.fromJson(Map<String, dynamic> json) =>
      _$UserStoryFromJson(json);

  Map<String, dynamic> toJson() => _$UserStoryToJson(this);

  @override
  String toString() {
    return "$id, $userId, $imageUrl, $createdAt, $updatedAt, $v, ";
  }
}
