import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/konfirmasi_pesanan_controller.dart';

class KonfirmasiPesananView extends GetView<KonfirmasiPesananController> {
  const KonfirmasiPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KonfirmasiPesananView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KonfirmasiPesananView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
