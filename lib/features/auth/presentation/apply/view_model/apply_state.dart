part of 'apply_cubit.dart';

abstract class ApplyState {}

class ApplyInitial extends ApplyState {}

class ApplyChanged extends ApplyState {}

class ApplyLoading extends ApplyState {}

class ApplySuccess extends ApplyState {
  final String message;
  ApplySuccess(this.message);
}

class ApplyError extends ApplyState {
  final String message;
  ApplyError(this.message);
}
