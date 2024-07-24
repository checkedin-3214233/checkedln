import 'package:json_annotation/json_annotation.dart';

import '../user/userModel.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel {
  NotificationModel({
    required this.notificationData,
    required this.fromUser,
    required this.type,
    required this.createdAt,
    required this.id,
  });

  final String? notificationData;
  static const String notificationDataKey = "notificationData";

  final UserModel? fromUser;
  static const String fromUserKey = "fromUser";

  final String? type;
  static const String typeKey = "type";

  final DateTime? createdAt;
  static const String createdAtKey = "createdAt";

  @JsonKey(name: '_id')
  final String? id;
  static const String idKey = "_id";

  NotificationModel copyWith({
    String? notificationData,
    UserModel? fromUser,
    String? type,
    DateTime? createdAt,
    String? id,
  }) {
    return NotificationModel(
      notificationData: notificationData ?? this.notificationData,
      fromUser: fromUser ?? this.fromUser,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
    );
  }

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  @override
  String toString() {
    return "$notificationData, $fromUser, $type, $id, $createdAt";
  }
}
