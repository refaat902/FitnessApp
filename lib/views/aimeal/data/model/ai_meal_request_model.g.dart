// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_meal_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiMealRequestModel _$AiMealRequestModelFromJson(Map<String, dynamic> json) =>
    AiMealRequestModel(
      age: (json['age'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      height: (json['height'] as num?)?.toInt(),
      weight: (json['weight'] as num?)?.toInt(),
      activity_level: (json['activity_level'] as num?)?.toInt(),
      dietary_preference: (json['dietary_preference'] as num?)?.toInt(),
      has_diabetes: json['has_diabetes'] as bool?,
      has_hypertension: json['has_hypertension'] as bool?,
      has_heart_disease: json['has_heart_disease'] as bool?,
      has_kidney_disease: json['has_kidney_disease'] as bool?,
      has_weight_gain: json['has_weight_gain'] as bool?,
      has_weight_loss: json['has_weight_loss'] as bool?,
      has_acne: json['has_acne'] as bool?,
    );

Map<String, dynamic> _$AiMealRequestModelToJson(AiMealRequestModel instance) =>
    <String, dynamic>{
      'age': instance.age,
      'gender': instance.gender,
      'height': instance.height,
      'weight': instance.weight,
      'activity_level': instance.activity_level,
      'dietary_preference': instance.dietary_preference,
      'has_diabetes': instance.has_diabetes,
      'has_hypertension': instance.has_hypertension,
      'has_heart_disease': instance.has_heart_disease,
      'has_kidney_disease': instance.has_kidney_disease,
      'has_weight_gain': instance.has_weight_gain,
      'has_weight_loss': instance.has_weight_loss,
      'has_acne': instance.has_acne,
    };
