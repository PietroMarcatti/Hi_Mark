import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hi_mark/Networking/network.dart';
import 'package:hi_mark/Product/product_list_class.dart';

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';
  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  List<ProductList> productLists = [];
  List<ExpansionTile> listExpansionTile = [];
  final _auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProductLists();
  }

  void getProductLists() async {
    productLists = await Network().getProductsLists();
    setState(() {
      listExpansionTile = getProductListWidget();
    });
  }

  List<Widget> getProductTilesWidget(ProductList list) {
    List<Widget> result = List<Widget>.generate(list.products.length,
        (i) => ListTile(title: Text(list.products[i].code.toString())));
    result.add(ListTile(title: Text('Add Item'), leading: Icon(Icons.add)));
    return result;
  }

  List<ExpansionTile> getProductListWidget() {
    List<ExpansionTile> res = [];
    for (var list in productLists) {
      res.add(
        ExpansionTile(
          title: Text(list.listName),
          children: getProductTilesWidget(list),
        ),
      );
    }
    return res;
  }

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
        children: listExpansionTile,
      ),
    );
  }
}
