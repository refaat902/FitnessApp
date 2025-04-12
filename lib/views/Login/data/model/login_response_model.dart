import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';


@JsonSerializable()
class LoginResponsetModel {
  String? email;
  String? fullName;
  String? token;

  LoginResponsetModel({this.email, this.fullName, this.token});

    factory LoginResponsetModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponsetModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginResponsetModelToJson(this);


}