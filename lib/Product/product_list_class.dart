import 'package:hi_mark/Product/product_class.dart';

class ProductList {
  ProductList({this.listName, List<Product> list}) : this.products = list ?? [];
  String listName;
  List<Product> products;
  void addProduct(Product item) {
    products.add(item);
  }
}
