import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../widgets/document/src/editor_toolbar_shared/color.dart';
import '../../controllers/users_controller.dart';
import 'add_user.dart'; // Import the add_user dialog function
import 'add_user_type.dart'; // Import the add_user_type dialog function

class UsersSettings extends ConsumerWidget {
  const UsersSettings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersProvider);

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
                child: usersState.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        itemCount: usersState.users.length,
                        itemBuilder: (context, index) {
                          final user = usersState.users[index];
                          return InkWell(
                            onTap: () => addUser(context, user),
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
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
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        CustomBadge(
                                          label:
                                              user.userType?.userType ?? 'N/A',
                                          color:
                                              user.userType?.color?.color !=
                                                  null
                                              ? hexToColor(
                                                  user.userType?.color?.color,
                                                )
                                              : Colors.green,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(user.gender ?? '-'),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () => ref
                                              .read(usersProvider.notifier)
                                              .toggleUserStatus(user),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                              vertical: 5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: user.deleted
                                                  ? Colors.green.withValues(
                                                      alpha: 0.2,
                                                    )
                                                  : Colors.red.withValues(
                                                      alpha: 0.2,
                                                    ),
                                              border: Border.all(
                                                color: user.deleted
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Text(
                                              user.deleted
                                                  ? "Activate"
                                                  : "Deactivate",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: user.deleted
                                                    ? Colors.green
                                                    : Colors.red,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
                  AddButton(onPress: () => addUserType(context)),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: usersState.userTypes.length,
                  itemBuilder: (context, index) {
                    final type = usersState.userTypes[index];
                    return InkWell(
                      onTap: () => addUserType(context, type),
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Pallet.inside1,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: type.color?.color != null
                                    ? hexToColor(type.color?.color)
                                    : Colors.grey,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(type.userType),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
