part of 'order_cubit.dart';

@immutable
abstract class OrderState {}

class OrderInitial extends OrderState {}
class StatusChanged extends OrderState {}
class GenderChanged extends OrderState {}
class LoadingState extends OrderState {}
class SuccessState extends OrderState {}
class FailState extends OrderState {}
class LoadingPersonCasesState extends OrderState {}
class SuccessPersonCasesState extends OrderState {}
class FailPersonCasesState extends OrderState {}
class CaseSelectedState extends OrderState {}
class LoadingNewOrderState extends OrderState {}
class SuccessNewOrderState extends OrderState {}
class FailNewOrderState extends OrderState {}
class DoneCouponState extends OrderState {}
class LoadingPayState extends OrderState {}
class SuccessPayState extends OrderState {}
class FailPayState extends OrderState {}
