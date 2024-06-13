part of 'track_cubit.dart';

@immutable
abstract class TrackState {}

class TrackInitial extends TrackState {}
class LoadingArrivedState extends TrackState {}
class FailArrivedState extends TrackState{}
class InitArrivedState extends TrackState{}
class LoadingTawafState extends TrackState {}
class FailTawafState extends TrackState{}
class InitTawafState extends TrackState{}
class LoadingSafaAndMarwaState extends TrackState {}
class FailSafaAndMarwaState extends TrackState{}
class InitSafaAndMarwaState extends TrackState{}
class LoadingCuttingHairState extends TrackState {}
class FailCuttingHairState extends TrackState{}
class InitCuttingHairState extends TrackState{}
class ChangePageState extends TrackState{}

