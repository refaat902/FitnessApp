// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meals_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MealsResponseModel _$MealsResponseModelFromJson(Map<String, dynamic> json) =>
    MealsResponseModel(
      id: (json['id'] as num?)?.toInt(),
      dietPlanId: (json['dietPlanId'] as num?)?.toInt(),
      mealType: json['mealType'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      foodItems: json['foodItems'] as String?,
      calories: (json['calories'] as num?)?.toInt(),
      protein: (json['protein'] as num?)?.toDouble(),
      carbs: (json['carbs'] as num?)?.toInt(),
      fat: (json['fat'] as num?)?.toDouble(),
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$MealsResponseModelToJson(MealsResponseModel instance) =>
    <String, dynamic>{
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
      'imageUrl': instance.imageUrl,
    };
