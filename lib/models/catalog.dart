// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Catalog{
  static List<Person>? person;
}

class Feed{
  final String name;
  final String group;
  final String mobile;
  final String location;
  final String des;

  Feed(this.name, this.group, this.mobile, this.location, this.des);
}

class Person {
  final String name;
  final String group;
  final String mobile;
  final String username;
  final String password;
  final String email;
  final String location;

  Person(
  this.name,
  this.group,
  this.mobile,
  this.username,
  this.password,
  this.email,
  this.location,
  );

  Person copyWith({
  String? name,
  String? group,
  String? mobile,
  String? username,
  String? password,
  String? email,
  String? location,
  }) {
  return Person(
  name ?? this.name,
  group ?? this.group,
  mobile ?? this.mobile,
  username ?? this.username,
  password ?? this.password,
  email ?? this.email,
  location ?? this.location,
  );
  }

  Map<String, dynamic> toMap() {
  return <String, dynamic>{
  'name': name,
  'group': group,
  'mobile': mobile,
  'username': username,
  'password': password,
  'email': email,
  'location': location,
  };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
  return Person(
  map['name'] as String,
  map['group'] as String,
  map['mobile'] as String,
  map['username'] as String,
  map['password'] as String,
  map['email'] as String,
  map['location'] as String,
  );
  }

  String toJson() => json.encode(toMap());

  factory Person.fromJson(String source) => Person.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
  return 'Person( name: $name, group: $group, mobile: $mobile, username: $username, password: $password, email: $email, location: $location)';
  }

  @override
  bool operator ==(covariant Person other) {
  if (identical(this, other)) return true;

  return
  other.name == name &&
  other.group == group &&
  other.mobile == mobile &&
  other.username == username &&
  other.password == password &&
  other.email == email &&
  other.location == location;
  }

  @override
  int get hashCode {
  return name.hashCode ^
  group.hashCode ^
  mobile.hashCode ^
  username.hashCode ^
  password.hashCode ^
  email.hashCode ^
  location.hashCode;
  }
}
