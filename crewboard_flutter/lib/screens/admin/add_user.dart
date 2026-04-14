import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../controllers/add_user_controller.dart';

Future<void> addUser(BuildContext context, [User? user]) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AddUserDialog(user: user);
    },
  );
}

class AddUserDialog extends ConsumerStatefulWidget {
  final User? user;
  const AddUserDialog({super.key, this.user});

  @override
  ConsumerState<AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends ConsumerState<AddUserDialog> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(addUserProvider.notifier).setFormData(widget.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(addUserProvider);
    final notifier = ref.read(addUserProvider.notifier);

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: AlertDialog(
        backgroundColor: Colors.transparent,
        contentPadding: EdgeInsets.zero,
        content: GlassMorph(
          borderRadius: 15,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          width: 500,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state.currentPage == 1)
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("user name", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(
                              controller: notifier.userNameController,
                              errorText: state.userNameError.isNotEmpty ? state.userNameError : null,
                              onType: (value) async {
                                notifier.checkUsername(value);
                                if (widget.user != null) notifier.setEdited(true);
                              },
                            ),
                            const SizedBox(height: 10),
                            Text("password", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(
                              isPassword: true,
                              controller: notifier.passwordController,
                              errorText: state.passwordError.isNotEmpty ? state.passwordError : null,
                              onType: (value) {
                                notifier.setPasswordError('');
                                if (widget.user != null) notifier.setEdited(true);
                              },
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("user type", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label: state.selectedUserType?.userType ?? "Select",
                                        itemKey: "userType",
                                        items: state.userTypesList,
                                        onPress: (userType) {
                                          notifier.selectUserType(userType as UserTypes);
                                          if (widget.user != null) notifier.setEdited(true);
                                        },
                                      ),
                                      if (state.userTypeError.isNotEmpty)
                                        Text(state.userTypeError, style: const TextStyle(fontSize: 10, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("leave config", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label: state.selectedLeaveConfig?.configName ?? "Select",
                                        itemKey: "configName",
                                        items: state.leaveConfigsList,
                                        onPress: (config) {
                                          notifier.selectLeaveConfig(config as LeaveConfig);
                                          if (widget.user != null) notifier.setEdited(true);
                                        },
                                      ),
                                      if (state.leaveConfigError.isNotEmpty)
                                        Text(state.leaveConfigError, style: const TextStyle(fontSize: 10, color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("punch id", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(
                              controller: notifier.punchIdController,
                              onType: (value) {
                                if (widget.user != null) notifier.setEdited(true);
                              },
                            ),
                          ],
                        ),
                      )
                    else if (state.currentPage == 2)
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("first name", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      SmallTextBox(
                                        controller: notifier.firstNameController,
                                        errorText: state.firstNameError.isNotEmpty ? state.firstNameError : null,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("last name", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      SmallTextBox(
                                        controller: notifier.lastNameController,
                                        errorText: state.lastNameError.isNotEmpty ? state.lastNameError : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("gender", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      DropDown(
                                        label: state.selectedGender.toString(),
                                        itemKey: "name",
                                        items: notifier.genders,
                                        onPress: (gender) {
                                          notifier.selectGender(gender as Gender);
                                        },
                                      ),
                                      if (state.genderError.isNotEmpty)
                                        Text(state.genderError, style: const TextStyle(fontSize: 10, color: Colors.red)),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("date of birth", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                                      const SizedBox(height: 10),
                                      DatePicker(
                                        value: state.dateOfBirth,
                                        label: "Select",
                                        onTap: () async {
                                          showDialog(
                                            context: context,
                                            builder: (context) => WheelDatePicker(
                                              initialDate: state.dateOfBirth.isEmpty ? DateTime.now() : DateTime.parse(state.dateOfBirth),
                                              onDateSelected: (date) {
                                                notifier.setDateOfBirth(date.toString().split(' ')[0]);
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      if (state.dateOfBirthError.isNotEmpty)
                                        Text(state.dateOfBirthError, style: const TextStyle(fontSize: 10, color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text("phone", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(
                              controller: notifier.phoneController,
                              errorText: state.phoneError.isNotEmpty ? state.phoneError : null,
                            ),
                            const SizedBox(height: 10),
                            Text("email", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(
                              controller: notifier.emailController,
                              errorText: state.emailError.isNotEmpty ? state.emailError : null,
                            ),
                            const SizedBox(height: 10),
                            Text("blood group", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            DropDown(
                              label: state.selectedBloodGroup.toString(),
                              itemKey: "name",
                              items: notifier.bloodGroups,
                              onPress: (group) {
                                notifier.selectBloodGroup(group as BloodGroup);
                              },
                            ),
                          ],
                        ),
                      )
                    else if (state.currentPage == 3)
                      SizedBox(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("salary (per month)", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(controller: notifier.salaryController),
                            const SizedBox(height: 10),
                            Text("experience (years)", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            SmallTextBox(controller: notifier.experienceController),
                            const SizedBox(height: 10),
                            Text("identity verification files", style: TextStyle(fontSize: 14, color: Pallet.font3)),
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                InkWell(
                                  onTap: () => notifier.pickVerificationFiles(),
                                  child: Container(
                                    width: 90,
                                    height: 70,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Pallet.font3)),
                                    child: const Center(child: Icon(Icons.upload_file, size: 30)),
                                  ),
                                ),
                                for (var file in state.attachments)
                                  FilePreview(name: file["name"], size: file["size"]),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(width: 15),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 10),
                          InkWell(
                            onTap: () => notifier.pickImage(),
                            child: state.profilePreviewBytes != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(55),
                                    child: Image.memory(state.profilePreviewBytes!, width: 65, height: 65, fit: BoxFit.cover),
                                  )
                                : Container(
                                    width: 65,
                                    height: 65,
                                    decoration: BoxDecoration(
                                      color: state.selectedColor != null ? Color(int.parse(state.selectedColor!.color.replaceAll("#", "0xFF"))) : Colors.blue,
                                      borderRadius: BorderRadius.circular(65),
                                    ),
                                    child: Center(
                                      child: Text(
                                        notifier.userNameController.text.isEmpty ? "A" : notifier.userNameController.text[0].toUpperCase(),
                                        style: GoogleFonts.poppins(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white)),
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 10),
                          Text("color", style: TextStyle(fontSize: 12, color: Pallet.font3)),
                          const SizedBox(height: 10),
                          ColorPicker(
                            selectedColorId: state.selectedColor?.id,
                            onColorSelected: (systemColor) {
                              notifier.selectColor(systemColor);
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.currentPage > 1)
                      SmallButton(
                        label: "Back",
                        onPress: () => notifier.setCurrentPage(state.currentPage - 1),
                      ),
                    const SizedBox(width: 10),
                    if (state.currentPage < 3)
                      SmallButton(
                        label: "Next",
                        onPress: () {
                          if (state.currentPage == 1 && notifier.validatePage1()) {
                            notifier.setCurrentPage(2);
                          } else if (state.currentPage == 2 && notifier.validatePage2()) {
                            notifier.setCurrentPage(3);
                          }
                        },
                      )
                    else
                      SmallButton(
                        label: "Submit",
                        onPress: () => notifier.createUser(),
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
