import 'package:elborda/title_card.dart';
import 'package:flutter/material.dart';
import 'details_screen.dart';
import 'dart:convert' as convert;

class ChapterView extends StatefulWidget {
  var body;
  ChapterView(this.body);

  @override
  _ChapterViewState createState() => _ChapterViewState(body);
}

class _ChapterViewState extends State<ChapterView> {
  _ChapterViewState(this.poem);
  var poem;
  List<Widget> chapterNames= [];

  void openDetailsPage(BuildContext ctx, String id) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return Details(poem);
    }));
  }

  @override
  Widget build(BuildContext context) {
    print("before");
    List chapters = poem['chapters'] as List;
    setState(() {
      chapterNames = chapters.map((chapter){
        return GestureDetector(
              onTap: () {
                openDetailsPage(context, chapter["id"]);
              },
              child: TitleCard(title: chapter["name"]));

      }).toList();
    });
    return Scaffold(
        appBar: AppBar(
          title: Text("الفصول"),
        ),
        body: DecoratedBox(
            position: DecorationPosition.background,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/bg.png'), fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
                child: Center(child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: chapterNames,
                ),)
            )))
      ;
  }
}