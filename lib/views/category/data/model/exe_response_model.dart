
import 'package:json_annotation/json_annotation.dart';

part 'exe_response_model.g.dart';

@JsonSerializable()
class ExeResponseModel {
  int? id;
  String? name;
  String? description;
  String? category;
  String? muscleGroup;
  String? equipment;
  String? difficultyLevel;
  String? instructionSteps;
  String? videoUrl;
  String? imageUrl;
  String? aiModelReference;


  ExeResponseModel(
      {this.id,
      this.name,
      this.description,
      this.category,
      this.muscleGroup,
      this.equipment,
      this.difficultyLevel,
      this.instructionSteps,
      this.videoUrl,
      this.imageUrl,
      this.aiModelReference,
});
  factory ExeResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ExeResponseModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ExeResponseModelToJson(this);

}