import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Details extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState();
  }
}

class DetailsState extends State<Details> {
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
    // getPoem();
    super.initState();
  }

  Future<void> getPoem() async {
    final int id = 7;
    final String url = 'http://www.elborda.com/poems/${id}?format=json';
    var response = await http.get(url);
    print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {

    List chapters =
        convert.jsonDecode(response.body)['poem']['chapters'] as List;
    List lines = chapters.map((chapter) {
      return chapter['lines'];
    }).toList();
    // print('----------');
    // var poemOfDay = DetailPoem.fromJson(convert.jsonDecode(response.body)['poem_of_day']);
    print(lines);
    setState(() {
      lines = lines;
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Column(
              textDirection: TextDirection.rtl,
              children: lines.map((line) {
                return Column(
                  textDirection: TextDirection.rtl,
                  children: <Widget>[
                    Container(
                        width: 500,
                        color: Color.fromRGBO(255, 0, 0, 1),
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        child: Text(line['body'][0].split(',')[0])),
                    Container(
                        width: 500,
                        color: Color.fromRGBO(255, 0, 0, 1),
                        padding:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        margin:
                            EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                        child: Text(line['body'][0].split(',')[1])),
                  ],
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }
}
