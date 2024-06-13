part of 'requests_cubit.dart';

@immutable
abstract class RequestsState {}

class RequestsInitial extends RequestsState {}
class OrderAdded extends RequestsState {}
class LoadingRequestsState extends RequestsState {}
class SuccessRequestsState extends RequestsState {}
class FailRequestsState extends RequestsState {}


