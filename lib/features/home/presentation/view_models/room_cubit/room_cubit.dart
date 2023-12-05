import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:talk_to_me/features/home/data/repos/home_repo.dart';

import '../../../data/models/room_model.dart';

part 'room_state.dart';

class RoomCubit extends Cubit<RoomState> {
  RoomCubit(this.homeRepo) : super(RoomInitial());

  final HomeRepo homeRepo;

  Future<void> createRoom(
      {required String title,
      required String language,
      required String languageLevel,
      required String hostId}) async {
    emit(RoomLoading());
    try {
      RoomModel? room = await homeRepo.createRoom(
          title: title,
          language: language,
          languageLevel: languageLevel,
          hostId: hostId);
      emit(RoomSuccess(room!));
    } catch (e) {
      emit(RoomFailure('Something went wrong'));
    }
  }

  Future<void> getRooms() async {
    emit(GetRoomsLoading());
    try {
      emit(GetRoomsSuccess(await homeRepo.getRooms()));
    } catch (e) {
      emit(GetRoomsFailure('Something went wrong'));
    }
  }

  Future<void> addParticipant({required String roomId}) async {
    await homeRepo.addParticipant(roomId: roomId);
  }

  Future<void> removeParticipant({required String roomId}) async {
    await homeRepo.removeParticipant(roomId: roomId);
  }

  Future<void> updateRoom(
      {required String roomId, required Map<String, dynamic> body}) async {
    await homeRepo.updateRoom(roomId: roomId, body: body);
  }
}
