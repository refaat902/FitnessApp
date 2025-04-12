import 'package:json_annotation/json_annotation.dart';

part 'meals_response_model.g.dart';

@JsonSerializable()
class MealsResponseModel {
  int? id;
  int? dietPlanId;
  String? mealType;
  String? name;
  String? description;
  String? foodItems;
  int? calories;
  double? protein;
  int? carbs;
  double? fat;
  String? imageUrl;

  MealsResponseModel({
    this.id,
    this.dietPlanId,
    this.mealType,
    this.name,
    this.description,
    this.foodItems,
    this.calories,
    this.protein,
    this.carbs,
    this.fat,
    this.imageUrl
  });

  factory MealsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MealsResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MealsResponseModelToJson(this);
}
