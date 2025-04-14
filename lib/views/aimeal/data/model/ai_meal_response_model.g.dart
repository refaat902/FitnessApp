// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_meal_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AiMealResponsetModel _$AiMealResponsetModelFromJson(
        Map<String, dynamic> json) =>
    AiMealResponsetModel(
      recommendations: json['recommendations'] as Map<String, dynamic>?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$AiMealResponsetModelToJson(
        AiMealResponsetModel instance) =>
    <String, dynamic>{
      'recommendations': instance.recommendations,
      'status': instance.status,
    };
