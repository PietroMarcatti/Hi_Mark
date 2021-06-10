import 'package:flutter/material.dart';

class FullScreenDialog extends StatefulWidget {
  String _skillOne = "You have";
  String _skillTwo = "not Added";
  String _skillThree = "any skills yet";

  @override
  FullScreenDialogState createState() => new FullScreenDialogState();
}

class FullScreenDialogState extends State<FullScreenDialog> {
  TextEditingController _skillOneController = new TextEditingController();
  TextEditingController _skillTwoController = new TextEditingController();

  TextEditingController _skillThreeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Add your top 3 skills"),
        ),
        body: new Padding(
          child: new ListView(
            children: <Widget>[
              new TextField(
                controller: _skillOneController,
              ),
              new TextField(
                controller: _skillTwoController,
              ),
              new TextField(
                controller: _skillThreeController,
              ),
              new Row(
                children: <Widget>[
                  new Expanded(
                      child: new RaisedButton(
                    onPressed: () {
                      widget._skillThree = _skillThreeController.text;
                      widget._skillTwo = _skillTwoController.text;
                      widget._skillOne = _skillOneController.text;
                      Navigator.pop(context);
                    },
                    child: new Text("Save"),
                  ))
                ],
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
        ));
  }
}
