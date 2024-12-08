import 'package:get/get.dart';

import '../controllers/status_pesanan_controller.dart';

class StatusPesananBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StatusPesananController>(
      () => StatusPesananController(),
    );
  }
}
