import 'dart:typed_data';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:frontend/widgets/button.dart';
import 'package:frontend/widgets/textbox.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart'; // TODO: Add intl package to pubspec.yaml
import '../../../backend/server.dart';
import '../../../backend/media_server.dart';
import '../../../globals.dart';
import '../../../widgets/widgets.dart';
import '../../../widgets/dropdown.dart';
import '../../../services/arri_client.rpc.dart'
    show
        AdminUsersGetUserTypesParams,
        AdminGetLeaveConfigsParams,
        CreateUserParams,
        AdminSystemGetColorsParams,
        CheckUsernameParams;
import 'add_user_controller.dart';

Future<void> addUser(context, Map? data) async {
  final controller = Get.put(AddUserController());
  controller.setFormData(data);

  return showDialog<void>(
    context: context,
    barrierDismissible: true, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        backgroundColor: Pallet.inside1,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        content: Obx(() {
          return Container(
            width: 415,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (controller.currentPage.value == 1)
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("user name", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.userNameController,
                              errorText: controller.userNameError.value,
                              onType: (value) async {
                                controller.checkUsername(value);
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Text("password", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              isPassword: true,
                              controller: controller.passwordController,
                              errorText: controller.passwordError.value,
                              onType: (value) {
                                controller.passwordError.value = '';
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),

                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "user type",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            controller
                                                .selectedUserType
                                                .value
                                                ?.userType ??
                                            "select",
                                        onPress: (userType) {
                                          controller.selectedUserType.value =
                                              userType;
                                          controller.userTypeError.value = '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                        itemKey: "userType",
                                        items: controller.userTypes,
                                        menuDecoration: BoxDecoration(
                                          color: Pallet.inside3,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                      // userTypeError
                                      if (controller
                                          .userTypeError
                                          .value
                                          .isNotEmpty)
                                        Text(
                                          controller.userTypeError.value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "leave config",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            controller
                                                .selectedLeaveConfig
                                                .value
                                                ?.configName ??
                                            "select",
                                        onPress: (leaveConfig) {
                                          controller.selectedLeaveConfig.value =
                                              leaveConfig;
                                          controller.leaveConfigError.value =
                                              '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                        itemKey: "configName",
                                        items: controller.leaveConfigs,
                                        menuDecoration: BoxDecoration(
                                          color: Pallet.inside3,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                      // String? leaveConfigError;
                                      if (controller
                                          .leaveConfigError
                                          .value
                                          .isNotEmpty)
                                        Text(
                                          controller.leaveConfigError.value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("punch id", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.punchIdController,
                              onType: (value) {
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),

                            // SmallTextBox(),
                          ],
                        ),
                      )
                    else if (controller.currentPage.value == 2)
                      Container(
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
                                      Text(
                                        "first name",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      SmallTextBox(
                                        controller:
                                            controller.firstNameController,
                                        errorText:
                                            controller.firstNameError.value,
                                        onType: (value) {
                                          controller.firstNameError.value = '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "last name",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      SmallTextBox(
                                        controller:
                                            controller.lastNameController,
                                        errorText:
                                            controller.lastNameError.value,
                                        onType: (value) {
                                          controller.lastNameError.value = '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "gender",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            controller
                                                .selectedGender
                                                .value
                                                ?.value ??
                                            "select",
                                        onPress: (gender) {
                                          controller.selectedGender.value =
                                              gender;
                                          controller.genderError.value = '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                        itemKey: "name",
                                        items: controller.genders,
                                        menuDecoration: BoxDecoration(
                                          color: Pallet.inside3,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                      if (controller
                                          .genderError
                                          .value
                                          .isNotEmpty)
                                        Text(
                                          controller.genderError.value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        ),
                                      // SmallTextBox(),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "date of birth",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      InkWell(
                                        onTap: () {
                                          showDatePicker(
                                            helpText: "test",
                                            builder: (context, child) {
                                              return Theme(
                                                data: Theme.of(context).copyWith(
                                                  colorScheme: Theme.of(context)
                                                      .colorScheme
                                                      .copyWith(
                                                        surface: Pallet.inside2,
                                                        primary: Pallet.inside1,
                                                        onPrimary: Pallet.font1,
                                                        onSurface: Pallet.font1,
                                                      ),
                                                  datePickerTheme: DatePickerThemeData(
                                                    backgroundColor:
                                                        Pallet.inside2,
                                                    headerBackgroundColor:
                                                        Pallet.inside1,
                                                    headerForegroundColor:
                                                        Pallet.font1,
                                                    dayForegroundColor:
                                                        MaterialStatePropertyAll(
                                                          Pallet.font1,
                                                        ),
                                                    yearForegroundColor:
                                                        MaterialStatePropertyAll(
                                                          Pallet.font1,
                                                        ),
                                                    // selected day/year colors
                                                    dayOverlayColor:
                                                        MaterialStatePropertyAll(
                                                          Pallet.inside1
                                                              .withOpacity(0.2),
                                                        ),
                                                    dayBackgroundColor:
                                                        MaterialStateProperty.resolveWith(
                                                          (states) {
                                                            if (states.contains(
                                                              MaterialState
                                                                  .selected,
                                                            )) {
                                                              return Pallet
                                                                  .inside1;
                                                            }
                                                            return Colors
                                                                .transparent;
                                                          },
                                                        ),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            6,
                                                          ),
                                                    ),
                                                  ),
                                                  textButtonTheme:
                                                      TextButtonThemeData(
                                                        style:
                                                            TextButton.styleFrom(
                                                              textStyle:
                                                                  TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                  ),
                                                              foregroundColor:
                                                                  Pallet.font1,
                                                            ),
                                                      ),
                                                  dialogBackgroundColor:
                                                      Pallet.inside2,
                                                ),
                                                child: child!,
                                              );
                                            },
                                            context: context,
                                            initialDate: DateTime.now(),
                                            firstDate: DateTime(
                                              DateTime.now().year - 100,
                                            ),
                                            lastDate: DateTime.now(),
                                          ).then((date) {
                                            controller.dateOfBirthError.value =
                                                '';
                                            if (data != null) {
                                              controller.isEdited.value = true;
                                            }
                                            if (date != null) {
                                              controller
                                                  .dateOfBirth
                                                  .value = date.toString().split(
                                                ' ',
                                              )[0]; // TODO: Fix DateFormat when intl package is added
                                              print(
                                                controller.dateOfBirth.value,
                                              );
                                            }
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Pallet.inside1,
                                            borderRadius: BorderRadius.circular(
                                              5,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              SizedBox(width: 2),
                                              Expanded(
                                                child: Text(
                                                  controller
                                                          .dateOfBirth
                                                          .value
                                                          .isEmpty
                                                      ? "select"
                                                      : controller
                                                            .dateOfBirth
                                                            .value,
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: 4,
                                                height: 20,
                                                color:
                                                    (controller
                                                        .dateOfBirth
                                                        .value
                                                        .isNotEmpty)
                                                    ? Colors.green
                                                    : Colors.transparent,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      if (controller
                                          .dateOfBirthError
                                          .value
                                          .isNotEmpty)
                                        Text(
                                          controller.dateOfBirthError.value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text("phone", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.phoneController,
                              errorText: controller.phoneError.value,
                              onType: (value) {
                                controller.phoneError.value = '';
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Text("email", style: TextStyle(fontSize: 14)),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.emailController,
                              errorText: controller.emailError.value,
                              onType: (value) {
                                controller.emailError.value = '';
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "blood group",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      SizedBox(height: 10),
                                      DropDown(
                                        label:
                                            controller
                                                .selectedBloodGroup
                                                .value
                                                .value ??
                                            "select",
                                        onPress: (group) {
                                          controller.selectedBloodGroup.value =
                                              group;
                                          controller.bloodGroupError.value = '';
                                          if (data != null) {
                                            controller.isEdited.value = true;
                                          }
                                        },
                                        itemKey: "name",
                                        items: controller.bloodGroups,
                                        menuDecoration: BoxDecoration(
                                          color: Pallet.inside3,
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                      ),
                                      if (controller
                                          .bloodGroupError
                                          .value
                                          .isNotEmpty)
                                        Text(
                                          controller.bloodGroupError.value,
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.red,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(child: SizedBox()),
                              ],
                            ),
                          ],
                        ),
                      )
                    else if (controller.currentPage.value == 3)
                      Container(
                        width: 300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "salary (per month)",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.salaryController,
                              onType: (value) {
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "experience (years)",
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(height: 10),
                            SmallTextBox(
                              controller: controller.experienceController,
                              onType: (value) {
                                if (data != null) {
                                  controller.isEdited.value = true;
                                }
                              },
                            ),
                            SizedBox(height: 10),
                            Text(
                              "identity verification files",
                              style: TextStyle(fontSize: 14),
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    right: 10,
                                    top: 10,
                                  ),
                                  child: InkWell(
                                    onTap: () async {
                                      final picked = await FilePicker.platform
                                          .pickFiles(
                                            allowMultiple: true,
                                            withData: true,
                                          );
                                      if (picked != null &&
                                          picked.files.isNotEmpty) {
                                        // Replace current attachments preview list with picked files
                                        controller.attachments.assignAll(
                                          picked.files.map(
                                            (f) => {
                                              "name": f.name,
                                              "size": f.size,
                                              "stream": const Stream.empty(),
                                            },
                                          ),
                                        );
                                        refreshSink.add("");
                                      }

                                      if (data != null) {
                                        controller.isEdited.value = true;
                                      }
                                    },
                                    child: Container(
                                      width: 130,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: Pallet.font2),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.upload_file, size: 40),
                                            SizedBox(height: 8),
                                            Text(
                                              "add file",
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                for (var attachment in controller.attachments)
                                  Container(
                                    width: 130,
                                    height: 90,
                                    margin: EdgeInsets.only(right: 10, top: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Pallet.font2),
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: Stack(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/file/blue.svg", // TODO: Fix getFileColor function
                                                  width: 35,
                                                  height: 42,
                                                  fit: BoxFit.fill,
                                                ),
                                                Center(
                                                  child: Text(
                                                    attachment["name"]
                                                        .split(".")
                                                        .last,
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            attachment["name"],
                                            style: TextStyle(fontSize: 14),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                // )
                              ],
                            ),
                            // SmallTextBox(),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    SizedBox(width: 15),
                    Container(
                      width: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10),
                          if (controller.profilePreviewBytes.value != null)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.memory(
                                controller.profilePreviewBytes.value!,
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            )
                          else if ((data != null) &&
                              (data["image"] != null) &&
                              (data["image"] as String).isNotEmpty)
                            ClipRRect(
                              borderRadius: BorderRadius.circular(55),
                              child: Image.network(
                                data["image"],
                                width: 65,
                                height: 65,
                                fit: BoxFit.cover,
                              ),
                            )
                          else
                            Container(
                              width: 65,
                              height: 65,
                              decoration: BoxDecoration(
                                color: (controller.selectedColor.value.color.isEmpty) ? Colors.red : Color(
                                  int.parse(controller.selectedColor.value.color),
                                ),
                                borderRadius: BorderRadius.circular(65),
                              ),
                              child: Center(
                                child: Text(
                                  (controller.userNameController.text.isEmpty)
                                      ? "A"
                                      : controller.userNameController.text[0]
                                            .toString()
                                            .toUpperCase(),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("color", style: TextStyle(fontSize: 12)),
                              SizedBox(width: 10),
                              ColorPicker(
                                color: (data == null)
                                    ? Color(0xffdc143c)
                                    : Color(int.parse(data["color"])),
                                onSelect: (val) {
                                  controller.selectedColor.value = val;
                                  if (data != null) {
                                    controller.isEdited.value = true;
                                  }
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          InkWell(
                            onTap: () async {
                              await controller.pickImage();
                            },
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Pallet.inside1,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Text("image", style: TextStyle(fontSize: 12)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmallButton(
                      label: "back",
                      onPress: () {
                        if (controller.currentPage.value > 1) {
                          controller.currentPage.value -= 1;
                        } else {
                          Navigator.pop(context);
                        }
                      },
                    ),
                    SizedBox(width: 10),
                    SmallButton(
                      label: (controller.currentPage.value == 3)
                          ? (controller.isEdited.value)
                                ? "save"
                                : "done"
                          : "next",
                      onPress: () async {
                        if (controller.currentPage.value == 1) {
                          if (controller.validatePage1()) {
                            controller.currentPage.value += 1;
                          }
                        } else if (controller.currentPage.value == 2) {
                          if (controller.validatePage2()) {
                            controller.currentPage.value += 1;
                          }
                        } else if (controller.currentPage.value == 3) {
                          await controller.createUser();
                          requestSink.add("get_users_data");
                          Navigator.pop(context);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      );
    },
  );
}
