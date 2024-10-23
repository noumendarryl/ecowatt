class UserModel {
  final String uid;
  final String displayName;
  final String email;
  final String photoURL;
  final String username;

  UserModel({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.photoURL,
    required this.username,
  });

  factory UserModel.fromMap( Map<String, dynamic> data, String documentId) {
    return UserModel(
      uid:  documentId,
      displayName: data['displayName']?? '',
      email: data['email']?? '',
      photoURL: data['photoURL']?? '',
      username: data['username']?? '',
    );
  }

  UserModel copyWith({
    final String? uid,
    final String? displayName,
    final String? email,
    final String? photoURL,
    final String? username,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,

      photoURL: photoURL ?? this.photoURL,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'displayName': displayName,
      'email': email,
      'photoURL': photoURL,
    };
  }
}
