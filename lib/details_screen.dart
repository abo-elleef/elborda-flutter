import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Details extends StatefulWidget {
  final String id;
  Details(this.id);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DetailsState(id, '...');
  }
}

class DetailsState extends State<Details> {
  String id;
  String pageTitle;
  DetailsState(this.id, this.pageTitle);
  // List<dynamic> lines = [];
  List<dynamic> lines = [
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
    // {
    //   "id": 961,
    //   "body": [
    //     "أَمَّا كَفَاكُمْ أَنَّى مُحِبّ ",
    //     " حَتَّى الى الْغِيَرَ تحوجونى"
    //   ]
    // },
    // {
    //   "id": 962,
    //   "body": ["فَصَرَّتْ فى حَبَّكُمْ أَنَادَى ", " يا سَادَةُ الحى تداركونى"]
    // },
  ];
  @override
  void initState() {
    // print('before init state in details page ');
    getPoem();
    super.initState();
  }

  Future<void> getPoem() async {
    final String url = 'http://www.elborda.com/poems/${id}?format=json';
    var response = await http.get(url);
    // print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {

    List chapters =
        convert.jsonDecode(response.body)['poem']['chapters'] as List;
    List items = chapters
        .map((chapter) {
          return chapter['lines'];
        })
        .expand((pair) => pair)
        .toList();
    String pageTitle2 = convert.jsonDecode(response.body)['poem']['name'];
    int id2 = convert.jsonDecode(response.body)['poem']['id'];
    setState(() {
      lines = items;
      pageTitle = pageTitle2;
      id = id2.toString();
    });

    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  Future<void> getNextPoem() async {
    final String url = 'http://www.elborda.com/poems/${id}/next?format=json';
    var response = await http.get(url);
    // print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {

    List chapters =
        convert.jsonDecode(response.body)['poem']['chapters'] as List;
    List items = chapters
        .map((chapter) {
          return chapter['lines'];
        })
        .expand((pair) => pair)
        .toList();
    String pageTitle2 = convert.jsonDecode(response.body)['poem']['name'];
    int id2 = convert.jsonDecode(response.body)['poem']['id'];
    // print('----------');
    // var poemOfDay = DetailPoem.fromJson(convert.jsonDecode(response.body)['poem_of_day']);

    setState(() {
      lines = items;
      pageTitle = pageTitle2;
      id = id2.toString();
    });

    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  Future<void> getPreviousPoem() async {
    final String url =
        'http://www.elborda.com/poems/${id}/previous?format=json';
    var response = await http.get(url);
    // print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {

    List chapters =
        convert.jsonDecode(response.body)['poem']['chapters'] as List;
    List items = chapters
        .map((chapter) {
          return chapter['lines'];
        })
        .expand((pair) => pair)
        .toList();
    String pageTitle2 = convert.jsonDecode(response.body)['poem']['name'];
    int id2 = convert.jsonDecode(response.body)['poem']['id'];
    // print('----------');
    // var poemOfDay = DetailPoem.fromJson(convert.jsonDecode(response.body)['poem_of_day']);
    // print(items);
    setState(() {
      lines = items;
      pageTitle = pageTitle2;
      id = id2.toString();
    });

    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  void openNext() {
    getNextPoem();
  }

  void openPrevious() {
    getPreviousPoem();
  }

  List<Widget> generateBody(List<dynamic> lines) {
    List<Widget> body = [];
    // print('the vlaue of lines');
    // print(lines);
    List<Container> items = lines.map((line) {
      return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 255, 255, 1),
            border: Border.all(
              color: Color.fromRGBO(255, 255, 255, 1),
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Text(
          line['body'].join('\n'),
          style: TextStyle(
            fontSize: 20,
            color: Color.fromRGBO(34, 34, 34, 1),
          ),
        ),
      );
    }).toList();
    body.addAll(items);
    body.add(Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RaisedButton(
          child: Text(
            "السابق",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onPressed: openPrevious,
          color: Color(0xff4caf50),
        ),
        RaisedButton(
          child: Text(
            "التالي",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
          onPressed: openNext,
          color: Color(0xff4caf50),
        ),
      ],
    ));

    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.pageTitle),
      ),
      body: DecoratedBox(
        position: DecorationPosition.background,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: 70),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: generateBody(lines),
            ),
          ),
        ),
      ),
    );
  }
}
