import 'package:flutter/material.dart';
import 'package:ocekoo/utils/classes.dart';
import 'package:ocekoo/utils/constant.dart';

class TopPrograssBar extends StatelessWidget {
  final String progressBarImagePath;

  TopPrograssBar({Key key, this.progressBarImagePath}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 35.0),
      alignment: Alignment.topCenter,
      height: 25,
      child: Image.asset(progressBarImagePath, fit: BoxFit.fill),
    );
  }
}

class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: FlatButton.icon(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          label: Text("Back")),
    );
  }
}

class TopTitle extends StatelessWidget {
  final double topMargin;
  final double leftMargin;
  final String title;

  const TopTitle({Key key, this.topMargin, this.leftMargin, this.title})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(
        top: topMargin,
        left: leftMargin,
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class SendButton extends StatelessWidget {
  final Function sendAction;
  final Icon buttonIcon;

  SendButton({Key key, this.sendAction, this.buttonIcon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        backgroundColor: Utils.TEXT_BLUE,
        child: Icon(Icons.arrow_forward,color: Colors.white,),
        onPressed: () => sendAction,
      ),
    );
  }
}