part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

class GetProfileSuccessState extends ProfileState {
  final ProfileModel profileModel;

  GetProfileSuccessState({required this.profileModel});

}
