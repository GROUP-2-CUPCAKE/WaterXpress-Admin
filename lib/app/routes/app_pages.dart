import 'package:get/get.dart';

import '../modules/edit_produk/bindings/edit_produk_binding.dart';
import '../modules/edit_produk/views/edit_produk_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/konfirmasi_pesanan/bindings/konfirmasi_pesanan_binding.dart';
import '../modules/konfirmasi_pesanan/views/konfirmasi_pesanan_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/riwayat_pesanan/bindings/riwayat_pesanan_binding.dart';
import '../modules/riwayat_pesanan/views/riwayat_pesanan_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';
import '../modules/tambah_produk/bindings/tambah_produk_binding.dart';
import '../modules/tambah_produk/views/tambah_produk_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashscreenView(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PRODUK,
      page: () => const TambahProdukView(),
      binding: TambahProdukBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PRODUK,
      page: () => const EditProdukView(),
      binding: EditProdukBinding(),
    ),
    GetPage(
      name: _Paths.KONFIRMASI_PESANAN,
      page: () => const KonfirmasiPesananView(),
      binding: KonfirmasiPesananBinding(),
    ),
    GetPage(
      name: _Paths.RIWAYAT_PESANAN,
      page: () => const RiwayatPesananView(),
      binding: RiwayatPesananBinding(),
    ),
  ];
}
