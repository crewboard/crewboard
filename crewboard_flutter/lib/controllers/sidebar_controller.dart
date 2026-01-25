import 'package:get/get.dart';
import '../config/palette.dart';

class SidebarController extends GetxController {
  var isOpen = true.obs;
  var closeOnExit = false.obs;
  var currentPage = CurrentPage.chat.obs;

  void toggleSidebar() {
    isOpen.value = !isOpen.value;
  }

  void openSidebar() {
    isOpen.value = true;
  }

  void closeSidebar() {
    isOpen.value = false;
  }

  void navigate(CurrentPage page) {
    currentPage.value = page;
  }
}
