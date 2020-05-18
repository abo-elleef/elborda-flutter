import 'package:flutter/cupertino.dart';

class Poem {
  final String id;
  final String name;
  final String desc;
  final String author;

  Poem({@required this.id, @required this.name, this.desc, this.author});

  factory Poem.fromJson(Map<String, dynamic> json){
    return Poem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'] ?? "",
      author: json['author'] ?? ""
    );
  }
}