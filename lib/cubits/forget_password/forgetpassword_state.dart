part of 'forgetpassword_cubit.dart';

@immutable
abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}
class LoadingState extends ForgetPasswordState {}
class SuccessState extends ForgetPasswordState {}
class FailState extends ForgetPasswordState {}

