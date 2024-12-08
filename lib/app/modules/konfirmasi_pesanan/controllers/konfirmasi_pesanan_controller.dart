import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:progress_tracker/progress_tracker.dart';
import 'package:waterxpress_admin/app/data/Pesanan.dart';

class KonfirmasiPesananController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Status list untuk progress tracker dengan icon
  List<Status> statusList = [
    Status(
      name: 'Diproses', 
      icon: Icons.pending_outlined
    ),
    Status(
      name: 'Diprose4s', 
      icon: Icons.build_circle_outlined
    ),
    Status(
      name: 'Dikirim', 
      icon: Icons.local_shipping_outlined
    ),
    Status(
      name: 'Selesai', 
      icon: Icons.check_circle_outline
    )
  ];
  
  // Observable untuk index status saat ini
  RxInt index = 0.obs;

  // Stream untuk mendapatkan pesanan yang menunggu konfirmasi
  // Stream<List<Pesanan>> getPesananMenungguKonfirmasi() {
  //   return _firestore
  //     .collection('Pesanan')
  //     .snapshots()
  //     .map((snapshot) => 
  //       snapshot.docs.map((doc) => 
  //         Pesanan.fromMap(doc.data() as Map<String, dynamic>)
  //       ).toList()
  //     );
  // }

  // Metode untuk memperbarui status pesanan
  Future<bool> updateStatusPesanan(String? pesananId, String status) async {
  try {
    // Validasi pesananId
    if (pesananId == null || pesananId.isEmpty) {
      print('Error: ID Pesanan tidak valid');
      return false;
    }

    // Update status langsung menggunakan ID dokumen
    await _firestore.collection('Pesanan').doc(pesananId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp()
    });

    // Logging untuk debugging
    print('Pesanan diupdate:');
    print('Document ID: $pesananId');
    print('New Status: $status');

    return true;
  } catch (e) {
    print('Error updating status: $e');
    return false;
  }
}

  // Metode untuk maju ke status berikutnya
  void nextButton() {
    if (index.value < statusList.length - 1) {
      index.value++;
    }
  }

  // Metode untuk mendapatkan detail pesanan berdasarkan ID
Future<Pesanan?> getPesananById(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('Pesanan').doc(id).get();
      
      if (doc.exists) {
        // Membuat objek Pesanan dengan menambahkan ID dokumen
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // Menambahkan ID dokumen ke dalam map data
        return Pesanan.fromMap(data);
      }
      return null;
    } catch (e) {
      print('Error getting pesanan: $e');
      return null;
    }
  }
}