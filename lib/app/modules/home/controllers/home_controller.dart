import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/data/Produk.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:waterxpress_admin/app/modules/login/views/login_view.dart'; // Impor LoginView

class HomeController extends GetxController {
  // Inisialisasi FirebaseAuth
  final FirebaseAuth auth = FirebaseAuth.instance;

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
      Get.snackbar(
        'Berhasil', 
        'Produk berhasil dihapus',
        backgroundColor: Colors.white,
        colorText: Color(0xFF0288D1),
      );
    } catch (e) {
      Get.snackbar(
        'Error', 
        'Gagal menghapus produk: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }

  Stream<double> calculateTotalPemasukan() {
    return FirebaseFirestore.instance
        .collection('Pesanan')
        .where('status', isEqualTo: 'Selesai')
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.fold(0.0, (total, doc) {
        // Pastikan menggunakan tipe data yang sesuai
        dynamic totalValue = doc.data()['total'];
        double parsedTotal = totalValue is num ? totalValue.toDouble() : 0.0;
        return total + parsedTotal;
      });
    });
  }

  // Method untuk memformat mata uang
  String formatCurrency(double value) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID', 
      symbol: '', 
      decimalDigits: 2
    );
    return formatter.format(value);
  }
}