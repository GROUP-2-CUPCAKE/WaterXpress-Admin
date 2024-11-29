import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/data/Produk.dart';

class HomeController extends GetxController {
  // Referensi ke koleksi Produk di Firestore
  CollectionReference ref = FirebaseFirestore.instance.collection('Produk');

  // Stream untuk mendapatkan semua produk
  Stream<List<Produk>> getAllProducts() {
    return FirebaseFirestore.instance
        .collection('Produk')
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Produk.fromJson(doc.data())).toList());
  }

  // Fungsi untuk menghapus produk
  Future<void> deleteProduct(String id) async {
    try {
      await ref.doc(id).delete();
      Get.snackbar('Berhasil', 'Produk berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus produk: $e');
    }
  }
}