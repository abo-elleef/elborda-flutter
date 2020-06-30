// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:elborda/poem_card.dart';
import 'package:flutter/material.dart';
import './models/poem.dart';
import './models/DetailPoem.dart';
import 'details_screen.dart';
import 'chapter_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'poems.dart';
import 'package:admob_flutter/admob_flutter.dart';
import 'dart:io' show Platform;

void main() {
  Admob.initialize(Platform.isIOS
      ? "ca-app-pub-2772630944180636~4608953642"
      : "ca-app-pub-2772630944180636~1708790676");
  runApp(
    MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      title: 'Elborda Test Title',
      theme: ThemeData(primaryColor: Color(0xff4caf50), fontFamily: "uthmanic"),
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
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;

  @override
  void initState() {
    getPoems();
    super.initState();
    bannerSize = AdmobBannerSize.BANNER;
  }

  var poemsHash = poemsSource;

  List<dynamic> poems = [];

  Future<void> getPoems() async {
//    final String url = 'http://www.elborda.com?format=json';
//    var response = await http.get(url);

    var items = poemsHash.values.toList().map((hash) {
      return Poem.fromJson(hash);
    }).toList();
    setState(() {
      poems = items;
    });
  }

  void openDetailsPage(BuildContext ctx, String id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      var poem = poemsHash[id];
      List chapters = poem['chapters'] as List;
      if (chapters.length > 1) {
        return ChapterView(poem);
      } else {
        return Details(id, -1);
      }
    }));
  }

  void filterPoems(search) {
    var items = poemsHash.values.toList().map((hash) {
      return Poem.fromJson(hash);
    }).toList();
    items.removeWhere((poem) {
      return !poem.name.contains(search);
    });
    setState(() {
      poems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      title: 'المدائح',
      theme: ThemeData(primaryColor: Color(0xff4caf50), fontFamily: "uthmanic"),
      home: Scaffold(
          appBar: AppBar(
            title: Text('المدائح '),
          ),
          body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      padding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color.fromRGBO(255, 255, 255, 0.8),
                      ),
                      child: TextField(
                        onChanged: (search) {
                          filterPoems(search);
                        },
                        decoration: InputDecoration(
                            hintText: 'ابحث باسم القصيدة',
                            icon: Icon(Icons.search),
                            border: InputBorder.none),
                      ),
                    ),
                    AdmobBanner(
                      adUnitId: Platform.isIOS
                          ? "ca-app-pub-2772630944180636/8356626963"
                          : "ca-app-pub-2772630944180636/3185523871",
                      adSize: bannerSize,
                      listener:
                          (AdmobAdEvent event, Map<String, dynamic> args) {
                        print("loaded");
//                        handleEvent(event, args, 'Banner');
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Column(
                        children: poems.map((poem) {
                          return GestureDetector(
                              onTap: () {
                                openDetailsPage(context, poem.id.toString());
                              },
                              child: PoemCard(
                                title: poem.name,
                                desc: poem.desc,
                                author: poem.author,
                              ));
                        }).toList(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
