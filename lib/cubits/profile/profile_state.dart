part of 'profile_cubit.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}
class ProfileEditedState extends ProfileState {}
class LoadingState extends ProfileState {}
class SuccessState extends ProfileState {}
class FailState extends ProfileState {}


