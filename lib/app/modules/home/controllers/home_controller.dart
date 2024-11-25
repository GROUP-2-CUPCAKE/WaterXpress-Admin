import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var products = <Product>[].obs; 

  final CollectionReference ref =
      FirebaseFirestore.instance.collection('Products');

  @override
  void onInit() {
    super.onInit();
    fetchProducts();  
  }


  void fetchProducts() {
    ref.snapshots().listen((QuerySnapshot snapshot) {
      products.clear();  
      for (var doc in snapshot.docs) {
        products.add(Product.fromFirestore(doc)); 
      }
    });
  }

  void logout() {}
}

class Product {
  final String id;
  final String name;
  final double price;
  final int stock;
  final String image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.image,
  });

  factory Product.fromFirestore(DocumentSnapshot doc) {
    return Product(
      id: doc['id'],
      name: doc['name'],
      price: doc['price'],
      stock: doc['stock'],
      image: doc['image'],
    );
  }
}
