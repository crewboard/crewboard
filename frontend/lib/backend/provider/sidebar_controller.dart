import 'package:get/get.dart';
import '../../globals.dart';

class SidebarController extends GetxController {
  var isOpen = true.obs;
  var closeOnExit = false.obs;
  var currentPage = CurrentPage.planner.obs;

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