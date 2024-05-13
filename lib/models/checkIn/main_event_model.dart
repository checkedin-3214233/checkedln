import 'package:json_annotation/json_annotation.dart';

import 'info_event_model.dart';

part 'main_event_model.g.dart';

@JsonSerializable()
class MainEventModel {
  MainEventModel({
    required this.event,
    required this.status,
  });

  final InfoEventModel? event;
  static const String eventKey = "event";

  final String? status;
  static const String statusKey = "status";


  MainEventModel copyWith({
    InfoEventModel? event,
    String? status,
  }) {
    return MainEventModel(
      event: event ?? this.event,
      status: status ?? this.status,
    );
  }

  factory MainEventModel.fromJson(Map<String, dynamic> json) => _$MainEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$MainEventModelToJson(this);

  @override
  String toString(){
    return "$event, $status, ";
  }
}

