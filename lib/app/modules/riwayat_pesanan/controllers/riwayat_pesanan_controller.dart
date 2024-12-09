import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:waterxpress_admin/app/data/Pesanan.dart';

class RiwayatPesananController extends GetxController {

  // Referensi ke koleksi Pesanan di Firestore
  CollectionReference ref = FirebaseFirestore.instance.collection('Pesanan');

  // Stream untuk mendapatkan Pesanan dengan status 'selesai'
 Stream<List<Pesanan>> getAllCompletedProducts() {
    return FirebaseFirestore.instance
        .collection('Pesanan')
        .where('status', isEqualTo: 'Selesai') 
        .snapshots()
        .map((snapshot) => 
            snapshot.docs.map((doc) {
              var pesanan = Pesanan.fromMap(doc.data());
              pesanan.id = doc.id;
              return pesanan;
            }).toList());
  }
}