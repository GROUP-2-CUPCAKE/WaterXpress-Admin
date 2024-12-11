import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:waterxpress_admin/app/modules/riwayat_pesanan/controllers/riwayat_pesanan_controller.dart';
import 'package:waterxpress_admin/app/data/Pesanan.dart';
import 'package:waterxpress_admin/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class RiwayatPesananView extends StatefulWidget {
  const RiwayatPesananView({Key? key}) : super(key: key);

  @override
  _RiwayatPesananViewState createState() => _RiwayatPesananViewState();
}

// Fungsi untuk memformat tanggal
String _formatTanggal(DateTime tanggalPesanan) {
  return DateFormat('dd MMM yyyy HH:mm').format(tanggalPesanan);
}

// Fungsi helper untuk memformat list produk
String _formatProdukList(List<dynamic>? produk) {
  if (produk == null || produk.isEmpty) {
    return 'Tidak ada produk';
  }

  // Map untuk menyimpan jumlah setiap produk
  Map<String, int> produkCount = {};

  // Hitung jumlah setiap produk
  for (var item in produk) {
    if (item is Map<String, dynamic>) {
      String namaProduk = item['nama'] ?? 'Produk Tidak Dikenal';
      int kuantitas = item['kuantitas'] ?? 0;

      produkCount[namaProduk] = (produkCount[namaProduk] ?? 0) + kuantitas;
    }
  }

  // Buat string dengan format "namaProduk(kuantitas)"
  return produkCount.entries
      .map((entry) => '${entry.value} ${entry.key}')
      .join(', ');
}

class _RiwayatPesananViewState extends State<RiwayatPesananView> {
  // int _currentIndex = 2;

  // Fungsi untuk memformat tanggal
  String _formatTanggal(DateTime tanggal) {
    return DateFormat('dd MMM yyyy HH:mm').format(tanggal);
  }

  @override
  Widget build(BuildContext context) {
    final RiwayatPesananController controller =
        Get.put(RiwayatPesananController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Riwayat Pesanan'),
        automaticallyImplyLeading: false,
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
      body: StreamBuilder<List<Pesanan>>(
        stream: controller.getAllCompletedProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Terjadi kesalahan: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      controller.getAllCompletedProducts();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0288D1),
                    ),
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Tidak ada riwayat pesanan'),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Pesanan pesanan = snapshot.data![index];
              return Card(
                color: const Color.fromARGB(255, 237, 246, 255),
                elevation: 2,
                margin: const EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'ID : ${pesanan.id}',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            pesanan.tanggalPesanan != null
                                ? _formatTanggal(pesanan.tanggalPesanan!)
                                : 'Tanggal tidak tersedia',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Nama Pengguna : ${pesanan.email}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Pesanan : ${_formatProdukList(pesanan.produk)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Pembayaran',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Rp${NumberFormat('#,###').format(pesanan.total)},00',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0288D1),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
