class Users {
  int id;
  String username;
  String firstName;
  String lastName;
  String email;

  Users({
    required this.id,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Users.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        firstName = json['first_name'],
        lastName = json['last_name'],
        email = json['email'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}
