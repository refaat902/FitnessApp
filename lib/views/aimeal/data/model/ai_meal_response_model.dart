

import 'package:json_annotation/json_annotation.dart';

part 'ai_meal_response_model.g.dart';


@JsonSerializable()
class AiMealResponsetModel {
  Map? recommendations;
  String? status;

  AiMealResponsetModel({this.recommendations, this.status});

        factory AiMealResponsetModel.fromJson(Map<String, dynamic> json) =>
      _$AiMealResponsetModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AiMealResponsetModelToJson(this);

}