// To parse this JSON data, do
//
//     final selectModel = selectModelFromJson(jsonString);

import 'dart:convert';

SelectModel selectModelFromJson(String str) => SelectModel.fromJson(json.decode(str));

String selectModelToJson(SelectModel data) => json.encode(data.toJson());

class SelectModel {
  String label;
  dynamic value;

  SelectModel({
    required this.label,
    required this.value,
  });

  factory SelectModel.fromJson(Map<String, dynamic> json) => SelectModel(
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "label": label,
    "value": value,
  };
}
