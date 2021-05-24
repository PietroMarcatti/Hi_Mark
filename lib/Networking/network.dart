import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_mark/Product/product_class.dart';
import 'package:hi_mark/Product/product_list_class.dart';

class Network {
  Future<List<ProductList>> getProductsLists() async {
    final _auth = FirebaseAuth.instance;
    final _firestore = FirebaseFirestore.instance;
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
}
