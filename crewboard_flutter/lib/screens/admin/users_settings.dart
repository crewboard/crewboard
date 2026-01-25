import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/glass_morph.dart';
import '../../widgets/document/src/editor_toolbar_shared/color.dart';
import '../../main.dart'; // For client
import 'add_user.dart'; // Import the add_user dialog function

class UsersController extends GetxController {
  RxList<User> users = <User>[].obs;
  RxList<UserTypes> userTypes = <UserTypes>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      users.value = await client.admin.getUsers();
      userTypes.value = await client.admin.getUserTypes();
    } catch (e) {
      print("Error fetching users data: $e");
    }
  }
}

class UsersSettings extends StatelessWidget {
  const UsersSettings({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UsersController());

    return Row(
      children: [
        // Users List Section
        Expanded(
          flex: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Users",
                    style: TextStyle(fontSize: 16, color: Pallet.font3),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              // Filter/Stats Section (Top 5, Birthdays, Actions)
              SizedBox(
                height: 155,
                child: Row(
                  children: [
                    Expanded(
                      child: GlassMorph(
                        borderRadius: 10,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Top 5 Performers"),
                            SizedBox(height: 5),
                            // TODO: Implement list
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GlassMorph(
                        borderRadius: 10,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: const [Text("Birthdays")],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: GlassMorph(
                        borderRadius: 10,
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Add User"),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () => addUser(context, null),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Pallet.inside1,
                                  border: Border.all(color: Pallet.font3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.all(10),
                                child: Icon(
                                  Icons.person_add_alt_1,
                                  size: 16,
                                  color: Pallet.font3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              // Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 10,
                ),
                child: Row(
                  children: const [
                    Expanded(flex: 2, child: Text("User")),
                    Expanded(flex: 2, child: Text("Role")),
                    Expanded(flex: 2, child: Text("Gender")),
                    Expanded(flex: 1, child: Text("Actions")),
                  ],
                ),
              ),
              // List
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.users.length,
                    itemBuilder: (context, index) {
                      final user = controller.users[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 25,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Pallet.inside1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  ProfileIcon(
                                    name: user.userName,
                                    color: hexToColor(user.color?.color),
                                    size: 30,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(user.userName),
                                ],
                              ),
                            ),
                            // ... other columns
                            Expanded(
                              flex: 2,
                              child: CustomBadge(
                                label: user.userType?.userType ?? 'N/A',
                                color: Colors.green, // TODO: Parse color
                              ),
                            ),
                            Expanded(flex: 2, child: Text(user.gender ?? '-')),
                            Expanded(
                              flex: 1,
                              child: const Icon(Icons.more_vert, size: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        // User Types Sidebar
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("User Types", style: TextStyle(color: Pallet.font3)),
                  AddButton(onPress: () {}), // TODO: Add User Type dialog
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemCount: controller.userTypes.length,
                    itemBuilder: (context, index) {
                      final type = controller.userTypes[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Pallet.inside1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(type.userType),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
