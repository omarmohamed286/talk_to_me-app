import '../../../../../core/models/user_model.dart';

abstract class UserDataRepo {
  Future<UserModel> getUser({required String token});
}
