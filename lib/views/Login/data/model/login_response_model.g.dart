// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponsetModel _$LoginResponsetModelFromJson(Map<String, dynamic> json) =>
    LoginResponsetModel(
      email: json['email'] as String?,
      fullName: json['fullName'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginResponsetModelToJson(
        LoginResponsetModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'fullName': instance.fullName,
      'token': instance.token,
    };
