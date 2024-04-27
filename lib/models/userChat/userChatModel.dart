import 'package:json_annotation/json_annotation.dart';

import '../message/messageModel.dart';
import '../user/userModel.dart';

part 'userChatModel.g.dart';

@JsonSerializable()
class UserChatModel {
  UserChatModel({
    required this.users,
    required this.lastMessage,
    required this.totalUnreadMessage,
    required this.lastSeen,
    required this.id,
  });

  final UserModel? users;
  static const String usersKey = "users";

  final MessageModel? lastMessage;
  static const String lastMessageKey = "lastMessage";

  final int? totalUnreadMessage;
  static const String totalUnreadMessageKey = "totalUnreadMessage";

  final DateTime? lastSeen;
  static const String lastSeenKey = "lastSeen";

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  UserChatModel copyWith({
    UserModel? users,
    MessageModel? lastMessage,
    int? totalUnreadMessage,
    DateTime? lastSeen,
    String? id,
  }) {
    return UserChatModel(
      users: users ?? this.users,
      lastMessage: lastMessage ?? this.lastMessage,
      totalUnreadMessage: totalUnreadMessage ?? this.totalUnreadMessage,
      lastSeen: lastSeen ?? this.lastSeen,
      id: id ?? this.id,
    );
  }

  factory UserChatModel.fromJson(Map<String, dynamic> json) =>
      _$UserChatModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserChatModelToJson(this);

  @override
  String toString() {
    return "$users, $lastMessage, $totalUnreadMessage, $lastSeen, $id, ";
  }
}
