
import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';


@JsonSerializable()
class LoginRequesttModel {
  String? email;
  String? password;

  LoginRequesttModel({this.email, this.password});


      factory LoginRequesttModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequesttModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginRequesttModelToJson(this);


}