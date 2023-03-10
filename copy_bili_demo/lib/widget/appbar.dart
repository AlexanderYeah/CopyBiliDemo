import 'package:flutter/material.dart';

appBar(String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(fontSize: 18, color: Colors.black),
    ),
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        ),
      )
    ],
  );
}
