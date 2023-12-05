import 'package:talk_to_me/features/home/data/models/room_model.dart';

abstract class HomeRepo {
  Future<RoomModel?> createRoom(
      {required String title,
      required String language,
      required String languageLevel,
      required String hostId});
  Future<List<RoomModel>> getRooms();
  Future<void> addParticipant({required String roomId});
  Future<void> removeParticipant({required String roomId});
  Future<void> updateRoom({required String roomId, required Map<String,dynamic> body});
}
