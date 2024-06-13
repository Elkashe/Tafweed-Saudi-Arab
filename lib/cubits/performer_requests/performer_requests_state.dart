part of 'performer_requests_cubit.dart';

@immutable
abstract class PerformerRequestsState {}

class PerformerRequestsInitial extends PerformerRequestsState {}
class LoadingVideoState extends PerformerRequestsState {}
class VideoSentState extends PerformerRequestsState {}
class VideoFailState extends PerformerRequestsState {}
class LoadingState extends PerformerRequestsState {}
class SuccessState extends PerformerRequestsState {}
class FailState extends PerformerRequestsState {}

