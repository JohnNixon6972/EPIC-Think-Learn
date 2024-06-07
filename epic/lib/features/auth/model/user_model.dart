class UserModel {
  final String displayName;
  final String username;
  final String email;
  final String profilePic;
  final String userId;
  final String type;

  UserModel({
    required this.displayName,
    required this.username,
    required this.email,
    required this.profilePic,
    required this.userId,
    required this.type,
  });

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'userId': userId,
      'type': type,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'],
      username: map['username'],
      email: map['email'],
      profilePic: map['profilePic'],
      userId: map['userId'],
      type: map['type'],
    );
  }
}
