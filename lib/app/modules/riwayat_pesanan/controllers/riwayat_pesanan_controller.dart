import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/data/Riwayat.dart';

class RiwayatPesananController extends GetxController {

  // Referensi ke koleksi Riwayat di Firestore
  CollectionReference ref = FirebaseFirestore.instance.collection('Riwayat');

  // Stream untuk mendapatkan Riwayat dengan status 'selesai'
  Stream<List<Riwayat>> getAllCompletedProducts() {
    return FirebaseFirestore.instance
        .collection('Riwayat')
        .where('status', isEqualTo: 'selesai') // Tambahkan filter status 'selesai'
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) => Riwayat.fromJson(doc.data())).toList());
  }
}