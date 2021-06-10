import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hi_mark/Product/product_class.dart';

class ProductList {
  ProductList({this.listName, List<Product> list, DocumentReference reference})
      : this.products = list ?? [];
  String listName;
  List<Product> products;
  DocumentReference reference;
  void addProduct(Product item) {
    products.add(item);
  }
}
