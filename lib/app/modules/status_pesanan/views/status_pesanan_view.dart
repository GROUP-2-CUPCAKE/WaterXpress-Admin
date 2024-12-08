import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:waterxpress_admin/app/modules/status_pesanan/controllers/status_pesanan_controller.dart';
import 'package:waterxpress_admin/app/data/Pesanan.dart';
import 'package:waterxpress_admin/app/routes/app_pages.dart';
import 'package:intl/intl.dart';

class StatusPesananView extends StatefulWidget {
  const StatusPesananView({Key? key}) : super(key: key);

  @override
  _StatusPesananViewState createState() => _StatusPesananViewState();
}

class _StatusPesananViewState extends State<StatusPesananView> {
  int _currentIndex = 1;

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

  // Fungsi untuk mendapatkan warna status
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'proses':
        return Colors.orange;
      case 'dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final StatusPesananController controller = Get.put(StatusPesananController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Konfirmasi Pesanan'),
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
              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman konfirmasi pesanan dengan membawa ID pesanan
                  Get.toNamed(
                    Routes.KONFIRMASI_PESANAN, 
                    arguments: pesanan.id // Kirim ID pesanan sebagai argumen
                  );
                },
                child: Card(
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
                                color: Colors.blue,
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
                        const SizedBox(height: 13),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Pembeli : ', 
                                style: TextStyle(
                                  color: Colors.black45, 
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: pesanan.email ?? 'Email tidak tersedia', 
                                style: TextStyle(
                                  color: Colors.black, 
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Pesanan: ', 
                                style: TextStyle(
                                  color: Colors.black45,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: _formatProdukList(pesanan.produk), 
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 5),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Alamat   : ', 
                                style: TextStyle(
                                  color: Colors.black45, 
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: pesanan.alamat ?? 'Alamat tidak tersedia', 
                                style: TextStyle(
                                  color: Colors.black, 
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 13),
                        Text(
                          'Total Pembayaran',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black45,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Rp${NumberFormat('####').format(pesanan.total)},00',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0288D1),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        height: 57.0,
        items: const <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.home, size: 28, color: Colors.white),
              Text(
                'Home',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 28, color: Colors.white),
              Text(
                'Konfir',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.history, size: 28, color: Colors.white),
              Text(
                'Riwayat',
                style: TextStyle(fontSize: 11, color: Colors.white),
              ),
            ],
          ),
        ],
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Navigasi ke halaman baru
          switch (index) {
            case 0:
              Get.toNamed(Routes.HOME);
              break;
            case 1:
              Get.toNamed(Routes.STATUS_PESANAN);
              break;
            case 2:
              Get.toNamed(Routes.RIWAYAT_PESANAN);
              break;
          }
        },
        color: const Color(0xFF0288D1),
        buttonBackgroundColor: const Color(0xFF40C4FF),
        animationDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}

// Extension atau helper method tambahan (opsional)
extension PesananExtension on Pesanan {
  // Contoh method untuk mendapatkan status warna
  Color get statusColor {
    switch (status?.toLowerCase()) {
      case 'selesai':
        return Colors.green;
      case 'proses':
        return Colors.orange;
      case 'dibatalkan':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Method untuk format mata uang
  String get formattedTotal {
    return NumberFormat.currency(
      locale: 'id_ID', 
      symbol: 'Rp', 
      decimalDigits: 0
    ).format(total);
  }
}