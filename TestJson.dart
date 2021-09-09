// import 'package:json_annotation/json_annotation.dart';

// not need - can do by manual
// part 'dog.g.dart';

// @JsonSerializable(explicitToJson: true)
import 'dart:convert';

class Dog {
  final int id;
  final String name;
  final int age;

  Dog({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $age}';
  }

  factory Dog.fromJson(Map<String, dynamic> jsonMap) {
    return Dog(id: jsonMap["id"], name: jsonMap["name"], age: jsonMap["age"]);
  }
  Map<String, dynamic> toJson() {
    return toMap();
  }
}

void main(List<String> args) {
  Map<String, dynamic> map = {"id": 1, "name": "name", "age": 2};
  Dog dog = Dog(id: 2, name: "name 2", age: 23);
  List<Dog> lsDog = [dog];
  String json = jsonEncode(lsDog);
  json = "[]";
  Iterable iteDog = jsonDecode(json);
  print("decoded size: ${iteDog.length}");
  List<Dog> lsDogFromJson = List<Dog>.from(
      iteDog.where((e) => e != null).map((e) => Dog.fromJson(e)));
  print("Json:${json}, size: ${lsDogFromJson.length}");
  List<String> ls = ["aa", "bbb"];
  try {
    String tmp =
        ls.firstWhere((element) => (element == "a"), orElse: () => "null");
    print("test: ${tmp}");
  } on StateError catch (e) {
    print("handled ${e.runtimeType}!!");
  }
}
