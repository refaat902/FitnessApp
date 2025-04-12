

import 'package:json_annotation/json_annotation.dart';

part 'exercise_model.g.dart';


@JsonSerializable()
class ExerciseModel {
  int? id;
  String? name;
  String? description;
  String? category;
  String? muscleGroup;
  String? difficultyLevel;
  String? instructionSteps;
  String? videoUrl;
  String? imageUrl;
  String? aiModelReference;


  ExerciseModel(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.muscleGroup,
      this.difficultyLevel,
      this.instructionSteps,
      this.videoUrl,
      this.imageUrl,
      this.aiModelReference,});

      
  factory ExerciseModel.fromJson(Map<String, dynamic> json) =>
      _$ExerciseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExerciseModelToJson(this);

}








