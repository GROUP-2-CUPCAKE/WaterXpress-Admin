import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header non-scrollable
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Daftar pesanan yang telah terselesaikan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0288D1),
              ),
            ),
          ),

          Expanded(
            child: StreamBuilder<List<Pesanan>>(
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

                //riwayat kosong
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Gambar ilustrasi
                        Image.asset(
                          'assets/images/foto.jpeg',
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Tidak ada riwayat pesanan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Kamu belum memiliki riwayat pesanan apapun',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black45,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  );
                }

                return ListView.separated(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 18, right: 18),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    Pesanan pesanan = snapshot.data![index];
                    return GestureDetector(
                      // onTap: () {
                      // Sesuaikan dengan kebutuhan navigasi di RiwayatPesananView
                      // Get.toNamed(Routes.KONFIRMASI_PESANAN, arguments: pesanan.id);
                      // },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.withOpacity(0.1),
                              Colors.blue.withOpacity(0.02),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.05),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Card(
                          elevation: 0,
                          color: Colors.transparent,
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(
                              color: const Color(0xFF0288D1).withOpacity(0.5),
                              width: 0.5,
                            ),
                          ),
                          child: Container(
                            // Dekorasi border bawah
                            decoration: BoxDecoration(
                              border: const Border(
                                bottom: BorderSide(
                                  color: Color(0xFF0288D1),
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Header Section
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF0288D1)
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'ID : ${pesanan.id}',
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0288D1),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        pesanan.tanggalPesanan != null
                                            ? _formatTanggal(
                                                pesanan.tanggalPesanan!)
                                            : 'Tanggal tidak tersedia',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.black54,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                    ],
                                  ),

                                  // Divider
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Divider(
                                      color: Colors.blue.withOpacity(0.2),
                                      thickness: 1,
                                    ),
                                  ),

                                  // Informasi Pembeli
                                  _buildInfoRow(
                                    icon: Icons.person_outline,
                                    label: 'Pembeli',
                                    value:
                                        pesanan.email ?? 'Email tidak tersedia',
                                  ),
                                  const SizedBox(height: 10),

                                  // Informasi Pesanan
                                  _buildInfoRow(
                                    icon: Icons.shopping_basket_outlined,
                                    label: 'Pesanan',
                                    value: _formatProdukList(pesanan.produk),
                                  ),
                                  const SizedBox(height: 10),

                                  // Informasi Alamat
                                  _buildInfoRow(
                                    icon: Icons.location_on_outlined,
                                    label: 'Alamat',
                                    value: pesanan.alamat ??
                                        'Alamat tidak tersedia',
                                  ),

                                  // Divider
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Divider(
                                      color: Colors.blue.withOpacity(0.2),
                                      thickness: 1,
                                    ),
                                  ),

                                  // Total Pembayaran
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total Pembayaran',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        'Rp${NumberFormat('#,###').format(pesanan.total)},00',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF0288D1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Widget helper untuk baris informasi
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF0288D1).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF0288D1),
            size: 20,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
