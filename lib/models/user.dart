import '../constants.dart';

class User {
  int id;
  String name;
  String email;
  String password;
  int birthdate;

  User(
      {required this.birthdate,
      required this.email,
      required this.id,
      required this.name,
      required this.password});

  factory User.fromjson(Map<String, dynamic> jsonData) {
    return User(
        birthdate: jsonData['birthdate'],
        email: jsonData['email'],
        id: jsonData['id'],
        name: jsonData['name'],
        password: jsonData['password']);
  }

  toJson() {
    return {
      cEmail: email,
      cId: id,
      cUserName: name,
      cPassword: password,
      cBirthdate: birthdate
    };
  }
}
