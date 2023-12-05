part of 'room_cubit.dart';

@immutable
sealed class RoomState {}

final class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomSuccess extends RoomState {
  final RoomModel room;

  RoomSuccess(this.room);
}

class RoomFailure extends RoomState {
  final String errMessage;

  RoomFailure(this.errMessage);
}

class GetRoomsLoading extends RoomState {}

class GetRoomsSuccess extends RoomState {
 final List<RoomModel> rooms;

  GetRoomsSuccess(this.rooms);
}

class GetRoomsFailure extends RoomState {
  final String errMessage;

  GetRoomsFailure(this.errMessage);
}
