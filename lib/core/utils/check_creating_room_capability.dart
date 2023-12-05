import '../../features/home/data/models/room_model.dart';

bool checkCreatingRoomCapability(List<RoomModel> rooms) {
  for (var room in rooms) {
    if (DateTime.now().difference(room.createdAt).inMinutes <= 2) {
      return false;
    }
  }
  return true;
}
