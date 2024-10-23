class UserModel {
  final String userId;
  final String email;

  UserModel({required this.userId, required this.email});

  Map<String, String> toMap() {
    return {
      'userId': userId,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, String> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
