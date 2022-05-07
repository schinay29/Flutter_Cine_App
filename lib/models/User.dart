class User {
  final int userId;
  final String email;
  final String password;

  User(this.userId, this.email, this.password);

  User.fromJson(Map<String, dynamic> json)
    : userId = json['userId'],
      email = json['email'],
      password = json['password'];

      
}