



import 'package:json_annotation/json_annotation.dart';

part 'ai_meal_request_model.g.dart';


@JsonSerializable()
class AiMealRequestModel {
  int? age;
  String? gender;
  int? height;
  int? weight;
  int? activity_level;
  int? dietary_preference;
  bool? has_diabetes;
  bool? has_hypertension;
  bool? has_heart_disease;
  bool? has_kidney_disease;
  bool? has_weight_gain;
  bool? has_weight_loss;
  bool? has_acne;

  AiMealRequestModel(
      {this.age,
      this.gender,
      this.height,
      this.weight,
      this.activity_level,
      this.dietary_preference,
      this.has_diabetes,
      this.has_hypertension,
      this.has_heart_disease,
      this.has_kidney_disease,
      this.has_weight_gain,
      this.has_weight_loss,
      this.has_acne});

    
      factory AiMealRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AiMealRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AiMealRequestModelToJson(this);
}