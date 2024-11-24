import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../login/views/login_view.dart';

class HomeController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  void logout() async {
    await auth.signOut();
    Get.off(() => LoginView());
  }
}
