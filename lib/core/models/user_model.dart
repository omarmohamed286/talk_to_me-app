class UserModel {
  final String id;
  final String username;
  final String email;
  final String image;

  UserModel(
      {required this.username,
      required this.email,
      required this.id,
      required this.image});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        username: json['username'],
        email: json['email'],
        id: json['_id'],
        image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'email': email, '_id': id, 'image': image};
  }
}
