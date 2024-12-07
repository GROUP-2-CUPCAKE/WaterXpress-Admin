import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/edit_produk_controller.dart';

class EditProdukView extends StatelessWidget {
  const EditProdukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EditProdukController());
    final String productId = Get.arguments;

    // Load product details when view is first created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadProductDetails(productId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Produk'),
        centerTitle: true,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF40C4FF), Color(0xFF0288D1)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
        ),
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Foto Produk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded( // Menggunakan Expanded agar menyesuaikan dengan lebar layar
                    child: controller.selectedImage.value != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFF40C4FF).withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 8,
                                  ),
                                ],
                              ),
                              child: Image.file(
                                controller.selectedImage.value!,
                                height: 200,
                                width: double.infinity, // Menyesuaikan lebar layar
                                fit: BoxFit.cover,
                              ),
                            ),
                          )
                        : (controller.existingImageUrl.value.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF40C4FF).withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: CachedNetworkImage(
                                    imageUrl: controller.existingImageUrl.value,
                                    height: 200,
                                    width: double.infinity, // Menyesuaikan lebar layar
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error, size: 50),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: () => controller.pickImage(),
                                child: Container(
                                  height: 200,
                                  width: double.infinity, // Menyesuaikan lebar layar
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.blueAccent.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 8,
                                      ),
                                    ],
                                  ),
                                  child: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add_a_photo,
                                          size: 40,
                                          color: Colors.black54,
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          "Tambah Foto",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                  ),
                  if (controller.selectedImage.value != null || controller.existingImageUrl.value.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.blue),
                      onPressed: () {
                        controller.selectedImage.value = null;
                        controller.existingImageUrl.value = '';
                      },
                    ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                "Nama Produk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.namaController,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Nama Produk',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Harga Produk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.hargaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Harga Produk',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Stok Produk",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: TextField(
                  controller: controller.stokController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Masukkan Stok Produk',
                    hintStyle: TextStyle(color: Colors.black54),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Validasi input
                    if (controller.namaController.text.isEmpty ||
                        controller.hargaController.text.isEmpty ||
                        controller.stokController.text.isEmpty) {
                      Get.snackbar(
                        'Error', 
                        'Lengkapi data terlebih dahulu',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                        borderRadius: 10,
                        margin: const EdgeInsets.all(10),
                        snackStyle: SnackStyle.FLOATING
                      );
                      return;
                    }

                    // Panggil method update produk
                    controller.updateProduct(productId);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF40C4FF), Color(0xFF0288D1)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 20),
                      child: Obx(() => 
                        controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : const Text(
                            "Update Produk",
                            style: TextStyle(
                              color: Colors.white, 
                              fontSize: 16
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
