class UserProfileModel {
  final String uid;
  final String photoURL;
  final String username;
  final String displayName;
  final String email;

  UserProfileModel({
    required this.uid,
    required this.photoURL,
    required this.username,
    required this.displayName,
    required this.email,
  });

  factory UserProfileModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserProfileModel(
      uid: uid,
      photoURL: data['photoURL'] ?? '',
      username: data['username'] ?? '',
      displayName: data['displayName'] ?? '',
      email: data['email'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'photoURL': photoURL,
      'username': username,
      'displayName': displayName,
      'email': email,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? photoURL,
    String? username,
    String? displayName,
    String? email,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      photoURL: photoURL ?? this.photoURL,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
    );
  }
}
