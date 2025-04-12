
import 'package:json_annotation/json_annotation.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  int? id;
  int? dietPlanId;
  String? mealType;
  String? name;
  String? description;
  String? foodItems;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;


  MealModel(
      {this.id,
      this.dietPlanId,
      this.mealType,
      this.name,
      this.description,
      this.foodItems,
      this.calories,
      this.protein,
      this.carbs,
      this.fat,
});

  factory MealModel.fromJson(Map<String, dynamic> json) =>
      _$MealModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MealModelToJson(this);


}