import 'package:checkedln/models/user/userModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  PostModel({
    required this.images,
    required this.friends,
    required this.location,
    required this.description,
    required this.id,
    required this.likes,
  });

  final List<String>? images;
  static const String imagesKey = "images";

  final List<UserModel>? friends;
  static const String friendsKey = "friends";

  final String? location;
  static const String locationKey = "location";

  final String? description;
  static const String descriptionKey = "description";

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  final List<String>? likes;
  static const String likesKey = "likes";

  PostModel copyWith({
    List<String>? images,
    List<UserModel>? friends,
    String? location,
    String? description,
    String? id,
    List<String>? likes,
  }) {
    return PostModel(
      images: images ?? this.images,
      friends: friends ?? this.friends,
      location: location ?? this.location,
      description: description ?? this.description,
      id: id ?? this.id,
      likes: likes ?? this.likes,
    );
  }

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  String toString() {
    return "$images, $friends, $location, $description, $id, $likes, ";
  }
}
