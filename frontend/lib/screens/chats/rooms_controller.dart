import 'package:get/get.dart';
import 'package:frontend/backend/server.dart';
import 'package:frontend/globals.dart' as g;
import 'package:frontend/services/arri_client.rpc.dart';
import 'package:frontend/services/local_storage_service.dart';

class RoomsController extends GetxController {
  final RxList<Room> rooms = <Room>[].obs;
  final RxList<Room> _backup = <Room>[].obs;
  final RxBool isLoading = false.obs;
  final Rx<Room?> selectedRoom = Rx<Room?>(null);

  @override
  void onInit() {
    super.onInit();
    // ignore: avoid_print
    print('[RoomsController] onInit');
    loadRooms();
  }

  Future<void> loadRooms() async {
    try {
      isLoading.value = true;
      // ignore: avoid_print
      print('[RoomsController] loadRooms called');
      final response = await server.chats.getRooms(GetRoomsParams());
      rooms.assignAll(response.rooms);
      _backup.assignAll(response.rooms);
    } catch (e) {
      // ignore: avoid_print
      print('Error getting rooms: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void resetSearch() {
    rooms.assignAll(_backup);
  }

  void searchRooms(String query) {
    if (query.isEmpty) {
      resetSearch();
      return;
    }
    final lower = query.toLowerCase();
    final List<Room> filtered = [];
    for (final room in _backup) {
      final name = room.roomName.toString().toLowerCase();
      if (name.contains(lower)) filtered.add(room);
    }
    rooms.assignAll(filtered);
  }

  void selectRoom(Room room) {
    selectedRoom.value = room;
  }
}
