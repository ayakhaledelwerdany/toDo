import 'dart:convert';

class UserModel {
  String id;
  String name;
  int age;
  String email;
  UserModel(
      {this.id = '',
      required this.name,
      required this.age,
      required this.email});
  UserModel.fromJson(Map<String, dynamic> Json)
      : this(
          id: Json['id'],
          name: Json['name'],
          email: Json['email'],
          age: Json['age'],
        );
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "age": age,
      "email": email,
    };
  }
}
