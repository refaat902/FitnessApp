part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class CreateNewUSerSuccessState extends SignUpState {
  final SignUpResponsetModel signUpResponsetModel;

  CreateNewUSerSuccessState({required this.signUpResponsetModel});

}
