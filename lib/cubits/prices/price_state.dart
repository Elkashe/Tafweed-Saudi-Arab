part of 'price_cubit.dart';

@immutable
abstract class PriceState {}

class PriceInitial extends PriceState {}
class CurrencyChangedState extends PriceState {}
class LoadingState extends PriceState {}
class FailState extends PriceState {}

