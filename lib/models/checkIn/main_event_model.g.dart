// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MainEventModel _$MainEventModelFromJson(Map<String, dynamic> json) =>
    MainEventModel(
      event: json['event'] == null
          ? null
          : InfoEventModel.fromJson(json['event'] as Map<String, dynamic>),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MainEventModelToJson(MainEventModel instance) =>
    <String, dynamic>{
      'event': instance.event,
      'status': instance.status,
    };
