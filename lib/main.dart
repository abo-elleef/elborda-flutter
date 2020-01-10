// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import './models/poem.dart';
import './models/DetailPoem.dart';
import 'details_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

void main() {
  runApp(
    MaterialApp(
      title: 'Elborda Test Title',
      theme: ThemeData(primaryColor: Colors.green, fontFamily: "uthmanic"),
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    getPoems();
    super.initState();
  }

  List<dynamic> poems = [
    Poem(id: 52, name: 'first poem', desc: 'Ahmed'),
    Poem(id: 24, name: 'first poem 2 ', desc: 'Ahmed 2')
  ];

  Future<void> getPoems() async {
    final String url = 'http://www.elborda.com?format=json';
    var response = await http.get(url);
    print(response);
    print(convert.jsonDecode(response.body));
    // if (response.statusCode == 200) {
    var items = convert.jsonDecode(response.body)['poems'].map((hash) {
      return Poem.fromJson(hash);
    }).toList();
    // print('----------');
    // var poemOfDay = DetailPoem.fromJson(convert.jsonDecode(response.body)['poem_of_day']);
    // print(poemOfDay);
    setState(() {
      poems = items;
    });

    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }

  void openDetailsPage(BuildContext ctx, String id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Details(id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(primaryColor: Colors.green, fontFamily: "uthmanic"),
      home: Scaffold(
          appBar: AppBar(
            title: Text('Welcome to Flutter 2'),
          ),
          body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              color: Colors.red,
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                      width: double.infinity,
                      child: Card(
                        child: Text('this is the main header'),
                      )),
                  Column(
                    children: poems.map((poem) {
                      return Row(
                        textDirection: TextDirection.rtl,
                        children: <Widget>[
                          // Text('icon'),
                          GestureDetector(
                              onTap: () {
                                openDetailsPage(context, poem.id.toString());
                              },
                              child: Container(
                                  width: 300,
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  child: Text(poem.name,
                                      style: TextStyle(fontSize: 28)))),
                        ],
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
