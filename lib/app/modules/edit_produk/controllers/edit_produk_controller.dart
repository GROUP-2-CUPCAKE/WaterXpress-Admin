import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class EditProdukController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final stokController = TextEditingController();

  Rx<File?> selectedImage = Rx<File?>(null);
  RxString existingImageUrl = RxString('');
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> loadProductDetails(String productId) async {
    try {
      var productDoc =
          await _firestore.collection('Produk').doc(productId).get();

      namaController.text = productDoc['nama'];
      hargaController.text = productDoc['harga'].toString();
      stokController.text = productDoc['stok'].toString();

      // Simpan URL gambar yang ada
      existingImageUrl.value = productDoc['images'] ?? '';
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat detail produk',
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        colorText: const Color(0xFFFF5252),
      );
    }
  }

  Future<void> updateProduct(String productId) async {
    if (namaController.text.isEmpty ||
        hargaController.text.isEmpty ||
        stokController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Semua field harus diisi',
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        colorText: const Color(0xFFFF5252),
      );
      return;
    }

    try {
      isLoading.value = true;
      String imageUrl = existingImageUrl.value;

      if (selectedImage.value != null) {
        // Upload new image
        final ref = _storage
            .ref()
            .child('produk_images/${DateTime.now().millisecondsSinceEpoch}');
        await ref.putFile(selectedImage.value!);
        imageUrl = await ref.getDownloadURL();
      }

      // Prepare update data
      Map<String, dynamic> updateData = {
        'nama': namaController.text,
        'harga': int.parse(hargaController.text),
        'stok': int.parse(stokController.text),
        'images': imageUrl
      };

      // Update Firestore
      await _firestore.collection('Produk').doc(productId).update(updateData);

      isLoading.value = false;
      Get.back(); // Kembali ke halaman sebelumnya
      Get.snackbar(
        'Berhasil',
        'Produk berhasil diupdate',
        backgroundColor: Colors.white,
        colorText: Color(0xFF0288D1),
      );
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error',
        'Gagal update produk: ${e.toString()}',
        margin: const EdgeInsets.all(12),
        backgroundColor: Colors.white,
        colorText: const Color(0xFFFF5252),
      );
    }
  }

  @override
  void onClose() {
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.onClose();
  }
}
