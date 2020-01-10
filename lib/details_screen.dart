import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Details extends StatefulWidget {
  final String id;
  Details(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState(id);
  }
}

class DetailsState extends State<Details> {
  final String id;
  DetailsState(this.id);
  List<dynamic> lines = [
    {
      "id": 961,
      "body": ["أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ,  حَتَّى الى الْغِيَرَ تحوجونى"]
    },
    {
      "id": 962,
      "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ,  يا سَادَةُ الحى تداركونى"]
    }
  ];
  @override
  void initState() {
    print('before init state in details page ');
    print(lines);
    getPoem();
    super.initState();
  }

  Future<void> getPoem() async {
    final String url = 'http://www.elborda.com/poems/${id}?format=json';
    print(url);
    var response = await http.get(url);
    print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {

    List chapters =
        convert.jsonDecode(response.body)['poem']['chapters'] as List;
    List items = chapters.map((chapter) {
      return chapter['lines'];
    }).toList()[0];
    print('----------');
    // var poemOfDay = DetailPoem.fromJson(convert.jsonDecode(response.body)['poem_of_day']);
    print(items);
    setState(() {
      lines = items;
    });

    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('details page'),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                textDirection: TextDirection.rtl,
                children: lines.map((line) {
                  print(line);
                  return Container(
                      width: 350,
                      color: Color.fromRGBO(255, 255, 255, 1),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(line['body'].join('\n')));
                }).toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
