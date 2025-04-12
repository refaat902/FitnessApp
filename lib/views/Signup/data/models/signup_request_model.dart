


import 'package:json_annotation/json_annotation.dart';

part 'signup_request_model.g.dart';


@JsonSerializable()
class SignUpRequestModel {
  String? fullName;
  String? email;
  String? password;
  String? confirmPassword;

  SignUpRequestModel(
      {this.fullName, this.email, this.password, this.confirmPassword});
        factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);

}