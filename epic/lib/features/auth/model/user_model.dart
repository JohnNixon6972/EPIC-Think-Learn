class UserModel {
  final String username;
  final String email;
  final String profilePic;
  final String userId;
  final String type;
  final List<String> strategies;

  UserModel({
    required this.username,
    required this.email,
    required this.profilePic,
    required this.userId,
    required this.type,
    required this.strategies,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'profilePic': profilePic,
      'userId': userId,
      'type': type,
      'strategies': strategies,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      username: map['username'],
      email: map['email'],
      profilePic: map['profilePic'],
      userId: map['userId'],
      type: map['type'],
      strategies: List<String>.from(map['strategies']),
    );
  }
}
