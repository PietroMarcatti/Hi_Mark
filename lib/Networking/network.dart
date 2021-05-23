import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hi_mark/Product/list_class.dart';

class Network {
  Future<List<ProductList>> getProductsLists(User user) async {
    final _firestore = FirebaseFirestore.instance;
    var productTable = await _firestore.collection('products').get();
    var listTable = await _firestore.collection('lists').get();
    List<ProductList> result;
    for(var list in listTable.docs){
      if(list.data()['user']==user.email){
        ProductList list;
        for(var product in productTable.docs){
          list.
        }
      }
    }
  }
}
