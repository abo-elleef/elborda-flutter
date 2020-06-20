import 'package:flutter/material.dart';

class ChapterCard extends StatelessWidget {
  ChapterCard({@required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
              image: AssetImage('assets/bg.png'),
              fit: BoxFit.cover
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                child: Image.asset("assets/book.png", width: 16)),
            Text(title,
                style: TextStyle(
                    fontSize: 20, color: Color.fromRGBO(34, 34, 34, 1))),
          ],
        ));
  }
}
