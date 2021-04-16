import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Adapt extends StatelessWidget {
  final String txt;
  final Function handler;
  Adapt(this.txt,this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(txt,
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold)),
      onPressed: () {
        handler();
      },
    )
        : FlatButton(
      splashColor: Colors.white10,
      onPressed: () {
        handler();
      },
      child: Text(txt,
          style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold)),
    );
  }
}
