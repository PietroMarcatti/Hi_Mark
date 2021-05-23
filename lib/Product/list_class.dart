import 'package:hi_mark/Product/product_class.dart';

class ProductList {
  ProductList({this.listName, this.products});
  String listName;
  List<Product> products;
  void addProduct(Product item) {
    products.add(item);
  }
}
