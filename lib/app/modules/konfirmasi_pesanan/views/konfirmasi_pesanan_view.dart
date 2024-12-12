import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:progress_tracker/progress_tracker.dart';
import 'package:waterxpress_admin/app/routes/app_pages.dart';
import 'package:waterxpress_admin/app/data/Pesanan.dart';
import '../controllers/konfirmasi_pesanan_controller.dart';

class KonfirmasiPesananView extends StatefulWidget {
  const KonfirmasiPesananView({Key? key}) : super(key: key);

  @override
  _KonfirmasiPesananViewState createState() => _KonfirmasiPesananViewState();
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

class _KonfirmasiPesananViewState extends State<KonfirmasiPesananView> {
  late Future<Pesanan?> pesananDetail;
  final KonfirmasiPesananController controller = Get.find();

  @override
  void initState() {
    super.initState();
    // Ambil orderId dari argumen yang dikirim
    final String orderId = Get.arguments as String;
    pesananDetail = controller.getPesananById(orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Konfirmasi Pesanan'),
      automaticallyImplyLeading: true,
      foregroundColor: Colors.white,
      // centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF40C4FF), Color(0xFF0288D1)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return FutureBuilder<Pesanan?>(
      future: pesananDetail,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(child: Text('Pesanan tidak ditemukan'));
        }

        final pesanan = snapshot.data!;
        return _buildPesananDetail(pesanan);
      },
    );
  }

  Widget _buildPesananDetail(Pesanan pesanan) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
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
            // decoration: BoxDecoration(
            // border: const Border(
            // bottom: BorderSide(
            // color: Color(0xFF0288D1),
            // width: 4,
            // style: BorderStyle.solid,
            // ),
            // ),
            // borderRadius: BorderRadius.circular(10),
            // ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 1),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0288D1).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
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
                            ? _formatTanggal(pesanan.tanggalPesanan!)
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
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Divider(
                      color: Colors.blue.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),

                  // Informasi Pembeli
                  _buildInfoRow(
                    icon: Icons.person_outline,
                    label: 'Pembeli',
                    value: pesanan.email ?? 'Email tidak tersedia',
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
                    value: pesanan.alamat ?? 'Alamat tidak tersedia',
                  ),
                  const SizedBox(height: 10),

                  // Informasi Ongkir
                  _buildInfoRow(
                    icon: Icons.local_shipping_outlined,
                    label: 'Total',
                    value: 'Rp${pesanan.total ?? 0}',
                  ),

                  // Divider
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 1),
                    child: Divider(
                      color: Colors.blue.withOpacity(0.2),
                      thickness: 1,
                    ),
                  ),

                  // Status Tracker
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0288D1).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'KONFIRMASI PEMESANAN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0288D1),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Obx(
                          () => ProgressTracker(
                            currentIndex: controller.index.value,
                            statusList: controller.statusList,
                            activeColor: Colors.green,
                            inActiveColor: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Tombol Next
                  Center(
                    child: _buildNextButton(pesanan),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

// Tambahkan method helper untuk baris informasi
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

// Tambahkan method untuk format tanggal
  String _formatTanggal(DateTime tanggalPesanan) {
    return DateFormat('dd MMM yyyy HH:mm').format(tanggalPesanan);
  }

  Widget _buildNextButton(Pesanan pesanan) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        height: 40,
        width: 350,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF40C4FF), Color(0xFF0288D1)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Obx(
          () => ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed:
                // Tambahkan null check untuk pesanan.id
                pesanan.id != null &&
                        controller.index.value !=
                            controller.statusList.length - 1
                    ? () {
                        print(pesanan.id);
                        controller.nextButton(pesanan.id!);
                      }
                    : null,
            child: const Text(
              'Next',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
