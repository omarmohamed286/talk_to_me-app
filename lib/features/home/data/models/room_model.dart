import 'package:talk_to_me/core/models/user_model.dart';

class RoomModel {
  final String id;
  final String title;
  final String language;
  final String languageLevel;
  final UserModel host;
  final int participantsCount;
  final DateTime createdAt;
  final DateTime lastLog;

  RoomModel(this.id, this.title, this.language, this.languageLevel, this.host,
      this.participantsCount, this.createdAt, this.lastLog);

  factory RoomModel.fromJson(Map<String, dynamic> data) {
    return RoomModel(
        data['_id'],
        data['title'],
        data['language'],
        data['languageLevel'],
        UserModel.fromJson(data['host']),
        data['participantsCount'],
        DateTime.parse(data['createdAt']),
        DateTime.parse(data['lastLog']));
  }
}
