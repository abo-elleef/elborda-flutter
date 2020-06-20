import 'package:flutter/material.dart';

class PoemCard extends StatelessWidget {
  PoemCard({@required this.title, this.desc, this.author});

  final String title;
  final String desc;
  final String author;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.png'),
                fit: BoxFit.cover
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        margin: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  child: Image.asset("assets/book.png", width: 16),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xff3a863d),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    child: Text(
                      desc,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
