class Poem {
  final int id;
  final String name;
  final String desc;

  Poem({this.id, this.name, this.desc});

  factory Poem.fromJson(Map<String, dynamic> json){
    return Poem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
    );
  }
}