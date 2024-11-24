import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_produk_controller.dart';

class EditProdukView extends GetView<EditProdukController> {
  const EditProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditProdukView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EditProdukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
