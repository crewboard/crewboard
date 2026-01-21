import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../backend/server.dart';
import '../../../backend/media_server.dart';
import '../../../services/arri_client.rpc.dart';

class Gender {
  final String? value;

  const Gender({required this.value});

  Gender.empty() : value = null;

  Map<String, dynamic> toJson() => {'name': value};
}

class BloodGroup {
  final String? value;

  const BloodGroup({required this.value});
  BloodGroup.empty() : value = null;

  Map<String, dynamic> toJson() => {'name': value};
}

class AddUserController extends GetxController {
  // Page management
  RxInt currentPage = 1.obs;
  RxBool isEdited = false.obs;

  // Form controllers
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final punchIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final salaryController = TextEditingController();
  final experienceController = TextEditingController();

  // Form data
  Rx<Gender> selectedGender = Gender.empty().obs;
  RxString dateOfBirth = ''.obs;
  Rx<BloodGroup> selectedBloodGroup = BloodGroup.empty().obs;
  Rx<UserType> selectedUserType = UserType.empty().obs;
  Rx<LeaveConfigItem> selectedLeaveConfig = LeaveConfigItem.empty().obs;
  Rx<SystemColor> selectedColor = SystemColor.empty().obs;

  // File data
  Rx<FilePickerResult?> image = Rx<FilePickerResult?>(null);
  Rx<FilePickerResult?> verificationFiles = Rx<FilePickerResult?>(null);
  Rx<Uint8List?> profilePreviewBytes = Rx<Uint8List?>(null);
  RxList<Map<String, dynamic>> attachments = <Map<String, dynamic>>[].obs;

  // Validation errors
  RxString userNameError = ''.obs;
  RxString passwordError = ''.obs;
  RxString userTypeError = ''.obs;
  RxString leaveConfigError = ''.obs;
  RxString firstNameError = ''.obs;
  RxString lastNameError = ''.obs;
  RxString genderError = ''.obs;
  RxString dateOfBirthError = ''.obs;
  RxString phoneError = ''.obs;
  RxString emailError = ''.obs;
  RxString bloodGroupError = ''.obs;

  // Loading states
  RxBool isLoading = false.obs;
  RxBool isCheckingUsername = false.obs;

  // Data lists
  RxList<UserType> userTypes = <UserType>[].obs;
  RxList<LeaveConfigItem> leaveConfigs = <LeaveConfigItem>[].obs;
  final List<Gender> genders = [
    Gender(value: "male"),
    Gender(value: "female"),
    Gender(value: "others"),
  ];
  final List<BloodGroup> bloodGroups = [
    BloodGroup(value: "A+"),
    BloodGroup(value: "A-"),
    BloodGroup(value: "B+"),
    BloodGroup(value: "B-"),
    BloodGroup(value: "O+"),
    BloodGroup(value: "O-"),
    BloodGroup(value: "AB+"),
    BloodGroup(value: "AB-"),
  ];

  @override
  void onInit() {
    super.onInit();
    loadInitialData();
  }

  @override
  void onClose() {
    userNameController.dispose();
    passwordController.dispose();
    punchIdController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    salaryController.dispose();
    experienceController.dispose();
    super.onClose();
  }

  Future<void> loadInitialData() async {
    await loadUserTypes();
    await loadLeaveConfigs();
    await loadDefaultColor();
  }

  Future<void> loadUserTypes() async {
    try {
      final response = await server.admin.users.getUserTypes(
        AdminUsersGetUserTypesParams.empty(),
      );
      userTypes.value = response.userTypes;
    } catch (e) {
      print("Error fetching user types: $e");
    }
  }

  Future<void> loadLeaveConfigs() async {
    try {
      final response = await server.admin.getLeaveConfigs(
        AdminGetLeaveConfigsParams.empty(),
      );
      leaveConfigs.value = response.leaveConfigs;
    } catch (e) {
      print("Error fetching leave configs: $e");
    }
  }

  Future<void> loadDefaultColor() async {
    try {
      final colorsResponse = await server.admin.system.getColors(
        AdminSystemGetColorsParams(k_default: true),
      );
      if (colorsResponse.k_default.isNotEmpty) {
        selectedColor.value = colorsResponse.k_default.first;
      }
    } catch (e) {
      // Keep existing fallback color
    }
  }

  Future<void> checkUsername(String username) async {
    if (username.isEmpty || username.length < 2) {
      userNameError.value = '';
      return;
    }

    isCheckingUsername.value = true;
    try {
      final response = await server.auth.checkUsername(
        CheckUsernameParams(userName: username),
      );
      userNameError.value = response.exists ? "user name exists" : "";
    } catch (e) {
      print("Error checking username: $e");
      userNameError.value = "";
    } finally {
      isCheckingUsername.value = false;
    }
  }

  void setFormData(Map? data) {
    // if (data == null) return;

    // userNameController.text = data["userName"] ?? '';
    // punchIdController.text = data["punchId"] ?? '';
    // firstNameController.text = data["firstName"] ?? '';
    // lastNameController.text = data["lastName"] ?? '';
    // phoneController.text = data["phone"] ?? '';
    // emailController.text = data["email"] ?? '';
    // salaryController.text = data["salary"]?.toString() ?? '';
    // experienceController.text = data["experience"]?.toString() ?? '';

    // selectedGender.value = data["gender"] ?? '';
    // dateOfBirth.value = data["dateOfBirth"] ?? '';
    // selectedBloodGroup.value = data["bloodGroup"] ?? '';

    // if (data["typeId"] != null) {
    //   selectedUserType.value = {
    //     "typeId": data["typeId"],
    //     "userType": data["userType"],
    //   };
    // }
    // if (data["configId"] != null) {
    //   selectedLeaveConfig.value = {
    //     "configId": data["configId"],
    //     "configName": data["configName"],
    //   };
    // }
    // if (data["colorId"] != null) {
    //   selectedColor.value = {
    //     "colorId": data["colorId"],
    //     "color": data["color"],
    //   };
    // }
  }

  Future<void> pickImage() async {
    image.value = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: true,
    );
    if (image.value != null &&
        image.value!.files.isNotEmpty &&
        image.value!.files.first.bytes != null) {
      profilePreviewBytes.value = image.value!.files.first.bytes;
    }
    isEdited.value = true;
  }

  Future<void> pickVerificationFiles() async {
    final picked = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      withData: true,
    );
    if (picked != null && picked.files.isNotEmpty) {
      attachments.value = picked.files
          .map(
            (f) => {
              "name": f.name,
              "size": f.size,
              "stream": const Stream.empty(),
            },
          )
          .toList();
    }
    isEdited.value = true;
  }

  bool validatePage1() {
    userNameError.value = userNameController.text.isEmpty
        ? "username is required"
        : "";
    passwordError.value = passwordController.text.isEmpty
        ? "password is required"
        : "";
    userTypeError.value = selectedUserType.value == null
        ? "user type is required"
        : "";
    leaveConfigError.value = selectedLeaveConfig.value == null
        ? "leave config is required"
        : "";

    return userNameError.value.isEmpty &&
        passwordError.value.isEmpty &&
        userTypeError.value.isEmpty &&
        leaveConfigError.value.isEmpty;
  }

  bool validatePage2() {
    firstNameError.value = firstNameController.text.isEmpty
        ? "first name is required"
        : "";
    lastNameError.value = lastNameController.text.isEmpty
        ? "last name is required"
        : "";
    genderError.value = selectedGender.value == null
        ? "gender is required"
        : "";
    dateOfBirthError.value = dateOfBirth.value.isEmpty
        ? "please select date of birth"
        : "";
    phoneError.value = phoneController.text.isEmpty ? "phone is required" : "";
    emailError.value = emailController.text.isEmpty
        ? "email id is required"
        : "";

    return firstNameError.value.isEmpty &&
        lastNameError.value.isEmpty &&
        genderError.value.isEmpty &&
        dateOfBirthError.value.isEmpty &&
        phoneError.value.isEmpty &&
        emailError.value.isEmpty;
  }

  Future<void> createUser() async {
    isLoading.value = true;
    try {
      List<String> attachmentsMap = [];
      String? imageUrl;

      // Upload image if provided
      if (image.value != null &&
          image.value!.files.isNotEmpty &&
          image.value!.files.first.bytes != null) {
        imageUrl = await MediaServer.uploadImage(
          originalName: image.value!.files.first.name,
          bytes: image.value!.files.first.bytes!,
          path: "profiles",
        );
      }

      // Upload verification files
      final vf = verificationFiles.value;
      if (vf != null && vf.files.isNotEmpty) {
        for (final f in vf.files) {
          if (f.bytes != null) {
            final url = await MediaServer.uploadImage(
              originalName: f.name,
              bytes: f.bytes!,
              path: "verifications",
            );
            if (url != null) {
              attachmentsMap.add(url);
            }
          }
        }
      }

      final params = CreateUserParams(
        userId: null, // For new user
        userName: userNameController.text,
        password: passwordController.text, // In real app, hash this
        colorId: selectedColor.value.colorId ?? "",
        image: imageUrl ?? "",
        userTypeId: selectedUserType.value?.typeId ?? "",
        leaveConfigId: selectedLeaveConfig.value?.configId ?? "",
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        gender: selectedGender.value?.value ?? "",
        dateOfBirth: dateOfBirth.value,
        phone: phoneController.text,
        email: emailController.text,
        bloodGroup: selectedBloodGroup.value.value ?? "",
        punchId: punchIdController.text,
        salary: double.tryParse(salaryController.text) ?? 0.0,
        experience: double.tryParse(experienceController.text) ?? 0.0,
        attachments: attachmentsMap,
      );

      await server.admin.users.createUser(params);
      // Trigger refresh of users list
      // You might want to use a stream or callback here
    } catch (e) {
      print("Error creating user: $e");
      rethrow;
    } finally {
      isLoading.value = false;
    }
  }

  void reset() {
    currentPage.value = 1;
    isEdited.value = false;
    userNameController.clear();
    passwordController.clear();
    punchIdController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    salaryController.clear();
    experienceController.clear();
    selectedGender.value = Gender.empty();
    dateOfBirth.value = '';
    selectedBloodGroup.value = BloodGroup.empty();
    selectedUserType.value = UserType.empty();
    selectedLeaveConfig.value = LeaveConfigItem.empty();
    selectedColor.value = SystemColor.empty();
    image.value = null;
    verificationFiles.value = null;
    profilePreviewBytes.value = null;
    attachments.clear();
    userNameError.value = '';
    passwordError.value = '';
    userTypeError.value = '';
    leaveConfigError.value = '';
    firstNameError.value = '';
    lastNameError.value = '';
    genderError.value = '';
    dateOfBirthError.value = '';
    phoneError.value = '';
    emailError.value = '';
    bloodGroupError.value = '';
  }
}
