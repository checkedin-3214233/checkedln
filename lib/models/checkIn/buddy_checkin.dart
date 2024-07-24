import 'package:checkedln/models/checkIn/home_event_model.dart';
import 'package:checkedln/models/user/userModel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'buddy_checkin.g.dart';

@JsonSerializable()
class BuddyCheckIn {
  BuddyCheckIn({
    required this.buddy,
    required this.event,
  });

  final UserModel? buddy;
  static const String buddyKey = "buddy";

  final HomeEventModel? event;
  static const String eventKey = "event";

  BuddyCheckIn copyWith({
    UserModel? buddy,
    HomeEventModel? event,
  }) {
    return BuddyCheckIn(
      buddy: buddy ?? this.buddy,
      event: event ?? this.event,
    );
  }

  factory BuddyCheckIn.fromJson(Map<String, dynamic> json) =>
      _$BuddyCheckInFromJson(json);

  Map<String, dynamic> toJson() => _$BuddyCheckInToJson(this);

  @override
  String toString() {
    return "$buddy, $event, ";
  }
}
