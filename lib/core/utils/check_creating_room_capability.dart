import '../../features/home/data/models/room_model.dart';

bool checkCreatingRoomCapability(List<RoomModel> rooms, String userId) {
  for (var room in rooms) {
    if (DateTime.now().difference(room.createdAt).inMinutes <= 2 &&
        room.host.id == userId) {
      return false;
    }
  }
  return true;
}
