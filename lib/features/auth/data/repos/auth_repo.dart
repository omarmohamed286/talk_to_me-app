abstract class AuthRepo {
  Future<void> register(
      {required String username,
      required String email,
      required String password});
  Future<void> login({required String email, required String password});
}
