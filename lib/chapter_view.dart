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

  void openDetailsPage(BuildContext ctx, int chapter_index) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
//      return Details(poem, lines, links);
      return Details(poem['id'], chapter_index);
    }));
  }

  List<Widget> buildChapters() {
    List chapters = poem['chapters'] as List;
    List<Widget> items = [];
    chapters
        .asMap()
        .forEach((index, chapter) {
      items.add(GestureDetector(
          onTap: () {
            openDetailsPage(context, index);
          },
          child: ChapterCard(title: chapter["name"])));
    });
    return items;
    }


  @override
  Widget build(BuildContext context) {
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
                child: Center(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: buildChapters(),
                ),)
            )))
    ;
  }
}