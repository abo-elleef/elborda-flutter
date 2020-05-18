import 'package:elborda/chapter_card.dart';
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

  void openDetailsPage(BuildContext ctx, List lines, String title) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      poem["name"] = title;
      return Details(poem, lines);
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
                openDetailsPage(context, chapter["lines"], chapter["name"]);
              },
              child: ChapterCard(title: chapter["name"]));

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