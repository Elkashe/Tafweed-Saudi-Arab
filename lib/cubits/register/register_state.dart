part of 'register_cubit.dart';

@immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}
class LoadingState extends RegisterState {}
class SuccessState extends RegisterState {}
class FailState extends RegisterState {}
