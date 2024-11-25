import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waterxpress_admin/app/modules/home/controllers/home_controller.dart';

class TambahProdukController extends GetxController {
  final image = XFile("").obs;
  final CollectionReference ref =
      FirebaseFirestore.instance.collection('Products');

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  Future<void> getImage(bool gallery) async {
    final ImagePicker picker = ImagePicker();
    XFile? pickedFile;

    if (gallery) {
      pickedFile = await picker.pickImage(source: ImageSource.gallery);
    } else {
      pickedFile = await picker.pickImage(source: ImageSource.camera);
    }

    if (pickedFile != null) {
      image.value = pickedFile;
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    super.onClose();
  }

  Future<String> uploadImage(File imageFile) async {
    final Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('Products/${DateTime.now().millisecondsSinceEpoch}.jpg');
    await storageReference.putFile(imageFile);
    final String downloadURL = await storageReference.getDownloadURL();
    return downloadURL;
  }

  Future<void> saveProduct() async {
    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        stockController.text.isEmpty ||
        image.value.path.isEmpty) {
      Get.snackbar(
        'Error',
        'Lengkapi semua data terlebih dahulu',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final price = double.tryParse(priceController.text);
    final stock = int.tryParse(stockController.text);
    
    if (price == null || price <= 0) {
      Get.snackbar(
        'Error',
        'Harga tidak valid. Harap masukkan angka yang valid.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 110, 108, 231),
        colorText: Colors.white,
      );
      return;
    }

    if (stock == null || stock <= 0) {
      Get.snackbar(
        'Error',
        'Stok tidak valid. Harap masukkan angka yang valid.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 114, 158, 223),
        colorText: Colors.white,
      );
      return;
    }

    try {
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      final String imageURL = await uploadImage(File(image.value.path));


      final DocumentReference refDoc = ref.doc();
      await refDoc.set({
        'id': refDoc.id,
        'name': nameController.text,
        'price': price,
        'stock': stock,
        'image': imageURL,
      });

      Get.back();
      Get.snackbar(
        "Berhasil",
        "Produk berhasil ditambahkan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: const Color.fromARGB(255, 108, 130, 253),
        colorText: Colors.white,
      );

      nameController.clear();
      priceController.clear();
      stockController.clear();
      image.value = XFile("");

    } catch (e) {
      Get.back();
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat menambahkan produk: $e",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
