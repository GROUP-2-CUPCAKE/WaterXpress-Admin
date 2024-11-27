import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '/app/modules/home/controllers/home_controller.dart';

class TambahProdukController extends GetxController {
  final image = XFile("").obs;

  CollectionReference ref = FirebaseFirestore.instance.collection('Produk');
  late TextEditingController namaController = TextEditingController();
  late TextEditingController hargaController = TextEditingController();
  late TextEditingController stokController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
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
    namaController.dispose();
    hargaController.dispose();
    stokController.dispose();
    super.onClose();
  }

  Future<String?> uploadFile(File image) async {
    final storageReference =
        FirebaseStorage.instance.ref().child('Produk/${image.path}');
    await storageReference.putFile(image);
    String returnURL = "";
    await storageReference.getDownloadURL().then(
      (fileURL) {
        returnURL = fileURL;
      },
    );
    return returnURL;
  }

  Future<void> saveImages(
    File images,
    String nama,
    int harga,
    int stok,
  ) async {
    Get.bottomSheet(
      Container(
          height: 80,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          )),
    );
    String? imageURL = await uploadFile(images);
    final refDoc = ref.doc();
    final data = {
      "id": refDoc.id,
      "nama": nama,
      "harga": harga,
      "stok": stok,
      "images": imageURL
    };
    refDoc.set(data);
    Get.back();
  }
}
