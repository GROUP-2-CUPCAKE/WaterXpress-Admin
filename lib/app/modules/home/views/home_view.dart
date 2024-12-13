import 'package:flutter/material.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:waterxpress_admin/app/modules/home/controllers/home_controller.dart';
import 'package:waterxpress_admin/app/routes/app_pages.dart';
import 'package:waterxpress_admin/app/modules/riwayat_pesanan/views/riwayat_pesanan_view.dart';

import '../../status_pesanan/views/status_pesanan_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const StatusPesananView(),
    const RiwayatPesananView(),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0288D1),
              Color(0xFF40C4FF),
            ],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              if (_currentIndex == 0)
                // Header
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Tambahkan ini untuk memisahkan elemen
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.white,
                                child: ClipOval(
                                  // Membuat gambar berbentuk lingkaran
                                  child: Image.asset(
                                    'assets/images/logo2.png',
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'WaterXpress',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // Tambahkan PopupMenuButton
                          PopupMenuButton<String>(
                            icon: Icon(Icons.more_vert, color: Colors.white),
                            color: Colors.white,
                            onSelected: (value) {
                              if (value == 'logout') {
                                // Tampilkan dialog konfirmasi logout
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    title: const Text(
                                      'Konfirmasi Logout',
                                      style: TextStyle(
                                        // color: Color(0xFF40C4FF),
                                        color: Color(0xFF0288D1),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    content: const Text(
                                      'Kamu yakin ingin keluar dari aplikasi?',
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text(
                                          'Batal',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Panggil method logout dari HomeController
                                          final HomeController controller =
                                              Get.find<HomeController>();
                                          controller.logout();

                                          // Tutup dialog
                                          Navigator.pop(context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF0288D1)
                                                  .withOpacity(0.9),
                                        ),
                                        child: const Text(
                                          'Logout',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'logout',
                                child: Row(
                                  children: [
                                    Icon(Icons.logout, color: Colors.red),
                                    SizedBox(width: 13),
                                    Text('Logout'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Text(
                          'Halo, Admin Kenzi!',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Pemasukan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                                // color: Colors.grey,
                                // color: Color(0xFF0288D1),
                              ),
                            ),
                            // Di dalam build method
                            StreamBuilder<double>(
                              stream: controller.calculateTotalPemasukan(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text(
                                    'Loading...',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF0288D1),
                                    ),
                                  );
                                }

                                if (snapshot.hasError) {
                                  return const Text(
                                    'Error',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  );
                                }

                                double totalPemasukan = snapshot.data ?? 0;
                                return Text(
                                  'Rp${controller.formatCurrency(totalPemasukan)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    // color: Color(0xFF0288D1),
                                    color: Color(0xFF43A047),
                                    // shadows: [
                                    // Shadow(
                                    // blurRadius: 2.0,
                                    // color: Colors.black26,
                                    // offset: Offset(1.0, 1.0),
                                    // ),
                                    // ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 5),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 252, 252, 252),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _pages,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: const Color(0xFF0288D1),
        buttonBackgroundColor: const Color(0xFF40C4FF),
        height: 58,
        items: const <CurvedNavigationBarItem>[
          CurvedNavigationBarItem(
            child: Icon(Icons.home, size: 30, color: Colors.white),
            label: 'Beranda',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.list_alt, size: 30, color: Colors.white),
            label: 'Pesanan',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.history, size: 30, color: Colors.white),
            label: 'Riwayat',
            labelStyle: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        animationDuration: const Duration(milliseconds: 300),
      ),
      floatingActionButton:
          _currentIndex == 0 ? _buildFloatingActionButton() : null,
    );
  }

  // Method untuk membangun FloatingActionButton
  Widget _buildFloatingActionButton() {
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Color(0xFF40C4FF),
                Color(0xFF0288D1),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: InkWell(
            splashColor: const Color.fromARGB(255, 144, 200, 233),
            child: const SizedBox(
              width: 50,
              height: 50,
              child: Icon(Icons.add, color: Colors.white, size: 28),
            ),
            onTap: () {
              Get.toNamed(Routes.TAMBAH_PRODUK);
            },
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    const bottomNavHeight = 1.0;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Text(
              'Produk yang Tersedia',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0288D1),
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Area yang dapat digulir
          Expanded(
            child: StreamBuilder(
              stream: controller.getAllProducts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF0288D1),
                    ),
                  );
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
                            controller.getAllProducts();
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
                          'Tidak ada produk',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Kamu belum memiliki produk apapun',
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

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    bottom: bottomNavHeight + 10,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var produk = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6.0),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed('/edit-produk', arguments: produk.id);
                        },
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
                          //tampilan card
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
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Gambar Produk
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl: produk.images,
                                          width: 60,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey[200],
                                            child: const Icon(Icons.error,
                                                color: Colors.red),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    // Informasi Produk
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15),
                                          Text(
                                            produk.nama,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black87,
                                              // color: Color(0xFF0288D1),
                                              fontSize: 16,
                                              letterSpacing: 0.5,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Text('Rp${produk.harga},00',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w900,
                                                    // fontWeight: FontWeight.bold,
                                                    // color: Color(0xFF2E7D32),
                                                    color: Colors.black54,
                                                  )),
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.fact_check,
                                                color: produk.stok > 0
                                                    // ? const Colors.grey
                                                    ? const Color.fromARGB(
                                                        255, 83, 89, 93)
                                                    : const Color(
                                                        0xFFD32F2F), // Merah untuk stok habis
                                                size: 14,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Stok: ${produk.stok}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w200,
                                                  color: produk.stok > 0
                                                      ? const Color.fromARGB(
                                                          255, 83, 89, 93)
                                                      : const Color(
                                                          0xFFD32F2F), // Merah untuk stok habis
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Tombol Edit dan Hapus
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        const SizedBox(height: 44),
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                    ..withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Icon(
                                                  Icons.edit,
                                                  color: Color(0xFF40C4FF),
                                                  size: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                Get.toNamed('/edit-produk',
                                                    arguments: produk.id);
                                              },
                                            ),
                                            IconButton(
                                              icon: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                    ..withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 20,
                                                ),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    title: const Text(
                                                      'Konfirmasi Hapus',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF0288D1),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                    content: const Text(
                                                      'Kamu yakin ingin menghapus produk ini?',
                                                      style: TextStyle(
                                                          color: Colors.grey),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text(
                                                          'Batal',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          controller
                                                              .deleteProduct(
                                                                  produk.id);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              const Color(
                                                                      0xFF0288D1)
                                                                  .withOpacity(
                                                                      0.9),
                                                        ),
                                                        child: const Text(
                                                          'Hapus',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
}
