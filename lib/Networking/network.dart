import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_mark/Product/product_class.dart';
import 'package:hi_mark/Product/product_list_class.dart';

class Network {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<List<ProductList>> getProductsLists() async {
    var listTable = await _firestore
        .collection('lists')
        .where('user', isEqualTo: _auth.currentUser.email)
        .get();
    List<ProductList> result = [];
    for (var list in listTable.docs) {
      ProductList productList = ProductList();
      var listData = list.data();
      var productTable = await _firestore
          .collection('products')
          .where('list', isEqualTo: list.reference)
          .get();
      productList.listName = listData['name'];
      productList.reference = list.reference;
      for (var product in productTable.docs) {
        var item = product.data();
        var p = Product(code: item['product']);
        productList.addProduct(p);
      }
      result.add(productList);
    }
    print('hello');
    return result;
  }

  Future<bool> addProductsList(String listName) async {
    var result = await _firestore
        .collection('lists')
        .add({'name': listName, 'user': _auth.currentUser.email});
    if (result == null)
      return false;
    else
      return true;
  }

  Future<bool> addProductToList(String scanBarcode, ProductList list) async {
    var result = await _firestore
        .collection('products')
        .add({'list': list.reference, 'product': int.parse(scanBarcode)});
    if (result == null)
      return false;
    else
      return true;
  }
}
