import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class TambahProdukView extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final Rx<XFile?> image = Rx<XFile?>(null);

  Future<void> getImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image.value = pickedImage;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Produk'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Foto Produk",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: getImage,
              child: Obx(() {
                return Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: image.value != null ? Colors.transparent : const Color.fromARGB(255, 226, 234, 247), 
                      width: 2, 
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: image.value != null ? Colors.transparent : const Color.fromARGB(255, 213, 229, 255).withOpacity(0.3), 
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: image.value != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(image.value!.path),
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: Colors.black54),
                              SizedBox(height: 10),
                              Text("Tambah Foto", style: TextStyle(fontSize: 14, color: Colors.black54)),
                            ],
                          ),
                        ),
                );
              }),
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
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Nama Produk',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Harga Produk',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Masukkan Stok Produk',
                  hintStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
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
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty ||
                      stockController.text.isEmpty ||
                      image.value == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lengkapi semua data terlebih dahulu'),
                        backgroundColor: Color.fromARGB(255, 186, 187, 192),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produk berhasil ditambahkan'),
                        backgroundColor: Color.fromARGB(255, 186, 187, 192),  
                        ),
                    );
                    Get.back();
                  }
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
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: const Text(
                      "Simpan",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
