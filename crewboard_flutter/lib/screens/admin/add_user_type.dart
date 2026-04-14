import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../controllers/add_user_type_controller.dart';
import 'package:crewboard_client/crewboard_client.dart';

Future<void> addUserType(BuildContext context, [UserTypes? type]) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AddUserTypeDialog(initialType: type);
    },
  );
}

class AddUserTypeDialog extends ConsumerStatefulWidget {
  final UserTypes? initialType;
  const AddUserTypeDialog({super.key, this.initialType});

  @override
  ConsumerState<AddUserTypeDialog> createState() => _AddUserTypeDialogState();
}

class _AddUserTypeDialogState extends ConsumerState<AddUserTypeDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final notifier = ref.read(addUserTypeProvider.notifier);
      if (widget.initialType != null) {
        notifier.initFrom(widget.initialType!);
      } else {
        notifier.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addUserTypeProvider);
    final notifier = ref.read(addUserTypeProvider.notifier);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: GlassMorph(
          borderRadius: 15,
          padding: const EdgeInsets.all(25),
          width: 450,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.editingId != null ? "Edit User Type" : "Add User Type",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Pallet.font1,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  "Role Name",
                  style: TextStyle(fontSize: 14, color: Pallet.font3),
                ),
                const SizedBox(height: 10),
                SmallTextBox(
                  controller: notifier.nameController,
                  hintText: "Enter role name",
                ),
                const SizedBox(height: 25),
                Text(
                  "Color",
                  style: TextStyle(fontSize: 14, color: Pallet.font3),
                ),
                const SizedBox(height: 10),
                ColorPicker(
                  selectedColorId: state.selectedColor?.id,
                  onColorSelected: (color) => notifier.selectColor(color),
                ),
                const SizedBox(height: 25),
                Text(
                  "Permissions",
                  style: TextStyle(fontSize: 14, color: Pallet.font3),
                ),
                const SizedBox(height: 10),
                Column(
                  children: state.permissions.keys.map((key) {
                    return InkWell(
                      onTap: () => notifier.togglePermission(key),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 24,
                              height: 24,
                              child: Checkbox(
                                value: state.permissions[key],
                                onChanged: (_) =>
                                    notifier.togglePermission(key),
                                activeColor: Colors.blue,
                                checkColor: Colors.white,
                                side: BorderSide(
                                  color: Pallet.font3,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              key.replaceAll('_', ' ').toLowerCase(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Pallet.font1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      label: "Cancel",
                      onPress: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 12),
                    SmallButton(
                      label: state.isLoading ? "Submitting..." : "Submit",
                      onPress: () async {
                        final success = await notifier.addUserType();
                        if (success) {
                          if (context.mounted) Navigator.pop(context);
                          notifier.reset();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
