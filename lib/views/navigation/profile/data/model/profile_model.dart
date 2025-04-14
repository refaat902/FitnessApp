
import 'package:json_annotation/json_annotation.dart';

part 'profile_model.g.dart';


@JsonSerializable()
class ProfileModel {
  String? fullName;
  String? email;
  String? phoneNumber;


  ProfileModel(
      {
      this.fullName,
      this.email,
      this.phoneNumber,
 });

   factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

}