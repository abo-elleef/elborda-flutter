class DetailPoem {
  final String id;
  final String name;
  final String desc;

  DetailPoem({this.id, this.name, this.desc});

  factory DetailPoem.fromJson(Map<String, dynamic> json){
    return DetailPoem(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
    );
  }
}