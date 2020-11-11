import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget VegCard(String title, String count, String price){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      Text(
        count,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
      Text(
        price,
        style: TextStyle(
          fontSize: 14.0,
        ),
      ),
    ],
  );
}

Widget VegDivider(){
  return Container(
    margin: EdgeInsets.only(top: 1.0,left: 30.0,right: 30.0),
    child: Divider(
      height: 1.0,
      color: Colors.black,
    ),
  );
}