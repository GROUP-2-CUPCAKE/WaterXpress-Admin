import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 147, 191, 248),
        actions: [
          IconButton(
            onPressed: () {
              controller.logout();
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.blue,
              size: 30,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Obx(() {
          if (controller.products.isEmpty) {
            return const Center(child: Text('No products available'));
          }

          return ListView.builder(
            itemCount: controller.products.length,
            itemBuilder: (context, index) {
              final product = controller.products[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  leading: Image.network(product.image, width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(product.name),
                  subtitle: Text('Price: \$${product.price}'),
                  trailing: Text('Stock: ${product.stock}'),
                ),
              );
            },
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/tambah-produk'); 
        },
        backgroundColor: const Color.fromARGB(255, 147, 191, 248),
        child: const Icon(
          Icons.add,
          color: Colors.blue,
        ),
      ),
    );
  }
}
