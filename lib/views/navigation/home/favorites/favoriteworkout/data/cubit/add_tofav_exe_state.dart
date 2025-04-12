part of 'add_tofav_exe_cubit.dart';

@immutable
sealed class AddTofavExeState {}

final class AddTofavExeInitial extends AddTofavExeState {}
class AddToFavExeSuccessState extends AddTofavExeState {}
class DeleteFavExeSuccessState extends AddTofavExeState {}
