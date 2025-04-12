// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealModel _$MealModelFromJson(Map<String, dynamic> json) => MealModel(
      id: (json['id'] as num?)?.toInt(),
      dietPlanId: (json['dietPlanId'] as num?)?.toInt(),
      mealType: json['mealType'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      foodItems: json['foodItems'] as String?,
      calories: (json['calories'] as num?)?.toInt(),
      protein: (json['protein'] as num?)?.toInt(),
      carbs: (json['carbs'] as num?)?.toInt(),
      fat: (json['fat'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MealModelToJson(MealModel instance) => <String, dynamic>{
      'id': instance.id,
      'dietPlanId': instance.dietPlanId,
      'mealType': instance.mealType,
      'name': instance.name,
      'description': instance.description,
      'foodItems': instance.foodItems,
      'calories': instance.calories,
      'protein': instance.protein,
      'carbs': instance.carbs,
      'fat': instance.fat,
    };
