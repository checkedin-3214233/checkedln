// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'buddy_checkin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuddyCheckIn _$BuddyCheckInFromJson(Map<String, dynamic> json) => BuddyCheckIn(
      buddy: json['buddy'] == null
          ? null
          : UserModel.fromJson(json['buddy'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : HomeEventModel.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BuddyCheckInToJson(BuddyCheckIn instance) =>
    <String, dynamic>{
      'buddy': instance.buddy,
      'event': instance.event,
    };
