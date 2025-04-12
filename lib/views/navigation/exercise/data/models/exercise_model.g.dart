// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExerciseModel _$ExerciseModelFromJson(Map<String, dynamic> json) =>
    ExerciseModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      description: json['description'] as String?,
      category: json['category'] as String?,
      muscleGroup: json['muscleGroup'] as String?,
      difficultyLevel: json['difficultyLevel'] as String?,
      instructionSteps: json['instructionSteps'] as String?,
      videoUrl: json['videoUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      aiModelReference: json['aiModelReference'] as String?,
    );

Map<String, dynamic> _$ExerciseModelToJson(ExerciseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'muscleGroup': instance.muscleGroup,
      'difficultyLevel': instance.difficultyLevel,
      'instructionSteps': instance.instructionSteps,
      'videoUrl': instance.videoUrl,
      'imageUrl': instance.imageUrl,
      'aiModelReference': instance.aiModelReference,
    };
