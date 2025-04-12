part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}


class LoginSuccessState extends LoginState {
  final LoginResponsetModel loginData;

  LoginSuccessState({required this.loginData});

}
