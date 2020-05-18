import 'package:flutter/material.dart';
import 'constants.dart';

class DrawerItem extends StatelessWidget {
  DrawerItem({@required this.text, @required this.icon, this.onPressed});
  final onPressed;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPressed();
      },
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(fontSize: fontSize, color: Colors.white),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}
