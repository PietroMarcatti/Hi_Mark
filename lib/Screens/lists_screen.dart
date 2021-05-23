import 'package:flutter/material.dart';

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';
  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'New List',
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () {},
      ),
      body: ListView(
        //TODO use Network.getProductsLists(firebase user) to retrieve data
        children: [
          ExpansionTile(
            title: Text('Lista Casa'),
            children:
                List<Widget>.generate(4, (i) => ListTile(title: Text('B-$i'))),
          ),
          ExpansionTile(
            title: Text('Lista Ufficio'),
            children:
                List<Widget>.generate(4, (i) => ListTile(title: Text('B-$i'))),
          ),
        ],
      ),
    );
  }
}
