part of 'packages_cubit.dart';

@immutable
abstract class PackagesState {}

class PackagesInitial extends PackagesState {}
class LoadingPackagesState extends PackagesState {}
class SuccessPackagesState extends PackagesState {}
class FailPackagesState extends PackagesState {}
