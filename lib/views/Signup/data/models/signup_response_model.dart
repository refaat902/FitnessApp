
import 'package:json_annotation/json_annotation.dart';

part 'signup_response_model.g.dart';


@JsonSerializable()


class SignUpResponsetModel {
  String? message;

  SignUpResponsetModel({this.message});
  factory SignUpResponsetModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponsetModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SignUpResponsetModelToJson(this);

}