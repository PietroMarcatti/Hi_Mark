import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:hi_mark/Networking/network.dart';
import 'package:hi_mark/Product/product_list_class.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import '../Components/rounded_button.dart';

class ListsScreen extends StatefulWidget {
  static const String id = 'lists_screen';
  @override
  _ListsScreenState createState() => _ListsScreenState();
}

class _ListsScreenState extends State<ListsScreen> {
  List<ProductList> productLists = [];
  List<ExpansionTile> listExpansionTile = [];
  TextEditingController _textFieldController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  String codeDialog;
  String valueText;
  String _scanBarcode = 'Unknown';
  bool showSpinner = false;

  @override
  void initState() {
    super.initState();
    getProductLists();
  }

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void getProductLists() async {
    productLists = await Network().getProductsLists();
    setState(() {
      listExpansionTile = getProductListWidget();
    });
  }

  List<Widget> getProductTilesWidget(ProductList list, int index) {
    List<Widget> result = List<Widget>.generate(list.products.length,
        (i) => ListTile(title: Text(list.products[i].code.toString())));
    result.add(ListTile(
      title: Text('Add Item'),
      leading: Icon(Icons.add),
      onTap: () async {
        await scanBarcodeNormal();
        if (int.parse(_scanBarcode) != -1) {
          var success = await Network().addProductToList(_scanBarcode, list);
          if (success) {
            getProductLists();
          }
        }
      },
    ));
    return result;
  }

  List<ExpansionTile> getProductListWidget() {
    List<ExpansionTile> res = [];
    int index = 0;
    for (var list in productLists) {
      res.add(
        ExpansionTile(
          title: Text(list.listName),
          children: getProductTilesWidget(list, index++),
        ),
      );
    }
    return res;
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    bool isEmpty = true;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Insert List Name'),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  valueText = value;
                  if (valueText == '' || valueText == null) {
                    isEmpty = true;
                    print(true);
                  } else {
                    isEmpty = false;
                    print(false);
                  }
                });
              },
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "List Name"),
            ),
            actions: <Widget>[
              Row(
                children: [
                  RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: 'Cancel',
                    onPressed: () {
                      setState(() {
                        valueText = '';
                        Navigator.pop(context);
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RoundedButton(
                    colour: Colors.lightBlue,
                    title: 'Confirm',
                    onPressed: () async {
                      setState(() {
                        codeDialog = valueText;
                        valueText = '';
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as String;
    if (args != null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => addProductToNewList(args));
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'New List',
        child: Icon(
          Icons.add,
          size: 35.0,
        ),
        onPressed: () async {
          await _displayTextInputDialog(context);
        },
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: ListView(
          children: listExpansionTile,
        ),
      ),
    );
  }

  void addProductToNewList(String args) async {
    await _displayTextInputDialog(context);
    await Network().addProductToList(_scanBarcode, productLists[0]);
    getProductLists();
  }
}
