import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../config/palette.dart';
import '../../widgets/widgets.dart';
import '../../controllers/add_user_controller.dart'; // Import the new controller

Future<void> addUser(context, Map? data) async {
  final controller = Get.put(AddUserController());
  controller.setFormData(data);

  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        backgroundColor: Pallet.inside1,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 15,
        ),
        content: Obx(() {
          return SizedBox(
            width: 415,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (controller.currentPage.value == 1)
                          SizedBox(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "user name",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.userNameController,
                                  errorText:
                                      controller.userNameError.value.isNotEmpty
                                      ? controller.userNameError.value
                                      : null,
                                  onType: (value) async {
                                    controller.checkUsername(value);
                                    if (data != null) {
                                      controller.isEdited.value = true;
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "password",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  isPassword: true,
                                  controller: controller.passwordController,
                                  errorText:
                                      controller.passwordError.value.isNotEmpty
                                      ? controller.passwordError.value
                                      : null,
                                  onType: (value) {
                                    controller.passwordError.value = '';
                                    if (data != null) {
                                      controller.isEdited.value = true;
                                    }
                                  },
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "user type",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          Options(
                                            width: 140,
                                            selected: controller
                                                .selectedUserType
                                                .value,
                                            items: controller.userTypes,
                                            onSelect: (userType) {
                                              controller
                                                      .selectedUserType
                                                      .value =
                                                  userType as UserTypes;
                                              controller.userTypeError.value =
                                                  '';
                                              if (data != null) {
                                                controller.isEdited.value =
                                                    true;
                                              }
                                            },
                                          ),
                                          if (controller
                                              .userTypeError
                                              .value
                                              .isNotEmpty)
                                            Text(
                                              controller.userTypeError.value,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "leave config",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          Options(
                                            width: 140,
                                            selected: controller
                                                .selectedLeaveConfig
                                                .value,
                                            items: controller.leaveConfigs,
                                            onSelect: (config) {
                                              controller
                                                      .selectedLeaveConfig
                                                      .value =
                                                  config as LeaveConfig;
                                              controller
                                                      .leaveConfigError
                                                      .value =
                                                  '';
                                              if (data != null) {
                                                controller.isEdited.value =
                                                    true;
                                              }
                                            },
                                          ),
                                          if (controller
                                              .leaveConfigError
                                              .value
                                              .isNotEmpty)
                                            Text(
                                              controller.leaveConfigError.value,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "punch id",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.punchIdController,
                                  onType: (value) {
                                    if (data != null) {
                                      controller.isEdited.value = true;
                                    }
                                  },
                                ),
                              ],
                            ),
                          )
                        else if (controller.currentPage.value == 2)
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "first name",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          SmallTextBox(
                                            controller:
                                                controller.firstNameController,
                                            errorText:
                                                controller
                                                    .firstNameError
                                                    .value
                                                    .isNotEmpty
                                                ? controller
                                                      .firstNameError
                                                      .value
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "last name",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          SmallTextBox(
                                            controller:
                                                controller.lastNameController,
                                            errorText:
                                                controller
                                                    .lastNameError
                                                    .value
                                                    .isNotEmpty
                                                ? controller.lastNameError.value
                                                : null,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "gender",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          Options(
                                            width: 140,
                                            selected:
                                                controller.selectedGender.value,
                                            items: controller.genders,
                                            onSelect: (gender) {
                                              controller.selectedGender.value =
                                                  gender as Gender;
                                              controller.genderError.value = '';
                                            },
                                          ),
                                          if (controller
                                              .genderError
                                              .value
                                              .isNotEmpty)
                                            Text(
                                              controller.genderError.value,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "date of birth",
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          const SizedBox(height: 10),
                                          InkWell(
                                            onTap: () async {
                                              final date = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (date != null) {
                                                controller.dateOfBirth.value =
                                                    date.toString().split(
                                                      ' ',
                                                    )[0];
                                                controller
                                                        .dateOfBirthError
                                                        .value =
                                                    '';
                                              }
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: Pallet.inside1,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Text(
                                                controller
                                                        .dateOfBirth
                                                        .value
                                                        .isEmpty
                                                    ? "Select"
                                                    : controller
                                                          .dateOfBirth
                                                          .value,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (controller
                                              .dateOfBirthError
                                              .value
                                              .isNotEmpty)
                                            Text(
                                              controller.dateOfBirthError.value,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.red,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "phone",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.phoneController,
                                  errorText:
                                      controller.phoneError.value.isNotEmpty
                                      ? controller.phoneError.value
                                      : null,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "email",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.emailController,
                                  errorText:
                                      controller.emailError.value.isNotEmpty
                                      ? controller.emailError.value
                                      : null,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "blood group",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Options(
                                  width: 140,
                                  selected: controller.selectedBloodGroup.value,
                                  items: controller.bloodGroups,
                                  onSelect: (group) {
                                    controller.selectedBloodGroup.value =
                                        group as BloodGroup;
                                  },
                                ),
                              ],
                            ),
                          )
                        else if (controller.currentPage.value == 3)
                          SizedBox(
                            width: 300,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "salary (per month)",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.salaryController,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "experience (years)",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                SmallTextBox(
                                  controller: controller.experienceController,
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  "identity verification files",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 10,
                                  runSpacing: 10,
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          controller.pickVerificationFiles(),
                                      child: Container(
                                        width: 90,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Pallet.font3,
                                          ),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.upload_file,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    for (var file in controller.attachments)
                                      Container(
                                        width: 90,
                                        height: 70,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          border: Border.all(
                                            color: Pallet.font3,
                                          ),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.file_present,
                                              size: 20,
                                            ),
                                            Text(
                                              file["name"],
                                              style: const TextStyle(
                                                fontSize: 10,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                        const SizedBox(width: 15),
                        // Right side: Profile Preview & Color Picker
                        SizedBox(
                          width: 100,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 10),
                              InkWell(
                                onTap: () => controller.pickImage(),
                                child:
                                    controller.profilePreviewBytes.value != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(55),
                                        child: Image.memory(
                                          controller.profilePreviewBytes.value!,
                                          width: 65,
                                          height: 65,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
                                        width: 65,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color:
                                              controller.selectedColor.value !=
                                                  null
                                              ? Color(
                                                  int.parse(
                                                    controller
                                                        .selectedColor
                                                        .value!
                                                        .color
                                                        .replaceAll(
                                                          "#",
                                                          "0xFF",
                                                        ),
                                                  ),
                                                )
                                              : Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            65,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            controller
                                                    .userNameController
                                                    .text
                                                    .isEmpty
                                                ? "A"
                                                : controller
                                                      .userNameController
                                                      .text[0]
                                                      .toUpperCase(),
                                            style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "color",
                                style: TextStyle(fontSize: 12),
                              ),
                              const SizedBox(height: 10),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  for (var sysColor in controller.colors)
                                    InkWell(
                                      onTap: () {
                                        controller.selectedColor.value =
                                            sysColor;
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: BoxDecoration(
                                          color: Color(
                                            int.parse(
                                              sysColor.color.replaceAll(
                                                "#",
                                                "0xFF",
                                              ),
                                            ),
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color:
                                                controller
                                                        .selectedColor
                                                        .value
                                                        ?.id ==
                                                    sysColor.id
                                                ? Colors.white
                                                : Colors.transparent,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Footer Buttons (Next/Back/Submit)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (controller.currentPage.value > 1)
                          SmallButton(
                            label: "Back",
                            onPress: () => controller.currentPage.value--,
                          ),
                        const SizedBox(width: 10),
                        if (controller.currentPage.value < 3)
                          SmallButton(
                            label: "Next",
                            onPress: () {
                              if (controller.currentPage.value == 1 &&
                                  controller.validatePage1()) {
                                controller.currentPage.value++;
                              } else if (controller.currentPage.value == 2 &&
                                  controller.validatePage2()) {
                                controller.currentPage.value++;
                              }
                            },
                          )
                        else
                          SmallButton(
                            label: "Submit",
                            onPress: () => controller.createUser(),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      );
    },
  );
}
