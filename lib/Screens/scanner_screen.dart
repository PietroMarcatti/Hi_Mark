import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../Components/rounded_button.dart';
import 'lists_screen.dart';
import 'lists_screen.dart';

class ScannerScreen extends StatefulWidget {
  static const String id = 'scanner_screen';
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  String _scanBarcode = 'Unknown';
  bool isVisible = false;

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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
    _displayTextInputDialog(context);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    bool isEmpty = true;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Scanned Product'),
            content: Text(_scanBarcode),
            actions: <Widget>[
              Row(
                children: [
                  RoundedButton(
                    colour: Colors.lightBlueAccent,
                    title: 'Insert into existing list',
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RoundedButton(
                    colour: Colors.lightBlue,
                    title: 'Create new list',
                    onPressed: () async {
                      Navigator.pushNamed(context, ListsScreen.id,
                          arguments: _scanBarcode);
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'ScanResult: $_scanBarcode',
        ),
        TextButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.lightBlue)))),
          onPressed: () async {
            await scanBarcodeNormal();
          },
          child: Text(
            'Start Scanning',
          ),
        )
      ],
    );
  }
}
