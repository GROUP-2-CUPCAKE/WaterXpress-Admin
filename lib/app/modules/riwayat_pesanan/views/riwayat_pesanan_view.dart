import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/riwayat_pesanan_controller.dart';

class RiwayatPesananView extends GetView<RiwayatPesananController> {
  const RiwayatPesananView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RiwayatPesananView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RiwayatPesananView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
