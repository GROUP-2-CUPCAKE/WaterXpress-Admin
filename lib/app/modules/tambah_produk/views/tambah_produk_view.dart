import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tambah_produk_controller.dart';

class TambahProdukView extends GetView<TambahProdukController> {
  const TambahProdukView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TambahProdukView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TambahProdukView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
