part of 'user_data_cubit.dart';

@immutable
sealed class UserDataState {}

final class UserDataInitial extends UserDataState {}

class GetUserDataLoading extends UserDataState {}
class GetUserDataSuccess extends UserDataState {}
class GetUserDataFailure extends UserDataState {
  final String errMessage;

  GetUserDataFailure(this.errMessage);
}