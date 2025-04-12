// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exe_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExeResponseModel _$ExeResponseModelFromJson(Map<String, dynamic> json) =>
    ExeResponseModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      muscleGroup: json['muscleGroup'] as String?,
      equipment: json['equipment'] as String?,
      difficultyLevel: json['difficultyLevel'] as String?,
      instructionSteps: json['instructionSteps'] as String?,
      videoUrl: json['videoUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      aiModelReference: json['aiModelReference'] as String?,
    );

Map<String, dynamic> _$ExeResponseModelToJson(ExeResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'muscleGroup': instance.muscleGroup,
      'equipment': instance.equipment,
      'difficultyLevel': instance.difficultyLevel,
      'instructionSteps': instance.instructionSteps,
      'videoUrl': instance.videoUrl,
      'imageUrl': instance.imageUrl,
      'aiModelReference': instance.aiModelReference,
    };
