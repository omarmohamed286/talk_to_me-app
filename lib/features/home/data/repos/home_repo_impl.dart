import 'package:talk_to_me/constants.dart';
import 'package:talk_to_me/core/utils/api_service.dart';
import 'package:talk_to_me/features/home/data/models/room_model.dart';
import 'package:talk_to_me/features/home/data/repos/home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final ApiService apiService;

  HomeRepoImpl(this.apiService);

  String baseUrl = kBaseUrl;

  @override
  Future<RoomModel?> createRoom(
      {required String title,
      required String language,
      required String languageLevel,
      required String hostId}) async {
    var response = await apiService.post(
      url: '$baseUrl/audioRoom',
      data: {
        'title': title,
        'language': language,
        'languageLevel': languageLevel,
        'host': hostId
      },
    );
    return response != null ? RoomModel.fromJson(response) : null;
  }

  @override
  Future<List<RoomModel>> getRooms() async {
    List<RoomModel> rooms = [];
    var response = await apiService.get(url: '$baseUrl/audioRoom');
    for (var room in response!) {
      rooms.add(RoomModel.fromJson(room));
    }
    return rooms;
  }

  @override
  Future<void> addParticipant({required String roomId}) async {
    await apiService.post(
      url: '$baseUrl/audioRoom/$roomId',
      data: {},
    );
  }

  @override
  Future<void> removeParticipant({required String roomId}) async {
    await apiService.delete(
      url: '$baseUrl/audioRoom/removeParticipant/$roomId',
    );
  }

  @override
  Future<void> updateRoom(
      {required String roomId, required Map<String, dynamic> body}) async {
    await apiService.patch(url: '$baseUrl/audioRoom/$roomId', data: body);
  }
}
