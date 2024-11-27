import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
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

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }
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
