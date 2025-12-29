import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../../main.dart'; // Access to client

class Gender {
  final String? value;

  const Gender({required this.value});

  Gender.empty() : value = null;

  Map<String, dynamic> toJson() => {'name': value};

  @override
  String toString() => value ?? "Select";
}

class BloodGroup {
  final String? value;

  const BloodGroup({required this.value});
  BloodGroup.empty() : value = null;

  Map<String, dynamic> toJson() => {'name': value};

  @override
  String toString() => value ?? "Select";
}

class AddUserController extends GetxController {
  // Page management
  RxInt currentPage = 1.obs;
  RxBool isEdited = false.obs;

  // Form controllers
  final userNameController = TextEditingController();
  final passwordController =
      TextEditingController(); // NOTE: In prod, handle passwords securely
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
  Rx<UserTypes?> selectedUserType = Rx<UserTypes?>(null);
  Rx<LeaveConfig?> selectedLeaveConfig = Rx<LeaveConfig?>(null);
  Rx<SystemColor?> selectedColor = Rx<SystemColor?>(null);

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
  RxList<UserTypes> userTypes = <UserTypes>[].obs;
  RxList<LeaveConfig> leaveConfigs = <LeaveConfig>[].obs;
  RxList<SystemColor> colors = <SystemColor>[].obs;
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
    await loadColors();
  }

  Future<void> loadUserTypes() async {
    try {
      final types = await client.admin.getUserTypes();
      userTypes.value = types;
      if (types.isNotEmpty && selectedUserType.value == null) {
        selectedUserType.value = types.first;
      }
    } catch (e) {
      print("Error fetching user types: $e");
    }
  }

  Future<void> loadLeaveConfigs() async {
    try {
      final configs = await client.admin.getLeaveConfigs();
      leaveConfigs.value = configs;
      if (configs.isNotEmpty && selectedLeaveConfig.value == null) {
        selectedLeaveConfig.value = configs.first;
      }
    } catch (e) {
      print("Error fetching leave configs: $e");
    }
  }

  Future<void> loadColors() async {
    try {
      final fetchedColors = await client.admin.getColors();
      colors.value = fetchedColors;
      if (fetchedColors.isNotEmpty) {
        final defaultColor = fetchedColors.firstWhere(
          (c) => c.isDefault,
          orElse: () => fetchedColors.first,
        );
        selectedColor.value = defaultColor;
      }
    } catch (e) {
      print("Error fetching colors: $e");
    }
  }

  Future<void> checkUsername(String username) async {
    if (username.isEmpty || username.length < 2) {
      userNameError.value = '';
      return;
    }
    isCheckingUsername.value = true;
    try {
      final response = await client.auth.checkUsername(username);
      userNameError.value = response.exists ? "user name exists" : "";
    } catch (e) {
      print("Error checking username: $e");
    } finally {
      isCheckingUsername.value = false;
    }
  }

  void setFormData(Map? data) {
    if (data == null) return;
    userNameController.text = data["userName"] ?? '';
    punchIdController.text = data["punchId"] ?? '';
    firstNameController.text = data["firstName"] ?? '';
    lastNameController.text = data["lastName"] ?? '';
    phoneController.text = data["phone"] ?? '';
    emailController.text = data["email"] ?? '';
    salaryController.text = data["salary"]?.toString() ?? '';
    experienceController.text = data["experience"]?.toString() ?? '';

    if (data["gender"] != null) {
      selectedGender.value = genders.firstWhere(
        (g) => g.value == data["gender"],
        orElse: () => Gender.empty(),
      );
    }
    dateOfBirth.value = data["dateOfBirth"] ?? '';
    if (data["bloodGroup"] != null) {
      selectedBloodGroup.value = bloodGroups.firstWhere(
        (b) => b.value == data["bloodGroup"],
        orElse: () => BloodGroup.empty(),
      );
    }

    if (data["userTypeId"] != null) {
      selectedUserType.value = userTypes.firstWhereOrNull(
        (t) => t.id == data["userTypeId"],
      );
    }
    if (data["leaveConfigId"] != null) {
      selectedLeaveConfig.value = leaveConfigs.firstWhereOrNull(
        (c) => c.id == data["leaveConfigId"],
      );
    }
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
      verificationFiles.value = picked;
      attachments.value = picked.files
          .map(
            (f) => {
              "name": f.name,
              "size": f.size,
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
    genderError.value = selectedGender.value.value == null
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
      final user = User(
        userName: userNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        gender: selectedGender.value.value ?? 'unspecified',
        dateOfBirth: dateOfBirth.value.isNotEmpty
            ? DateTime.parse(dateOfBirth.value)
            : null,
        bloodGroup: selectedBloodGroup.value.value,
        salary: salaryController.text,
        experience: experienceController.text,
        punchId: punchIdController.text,
        userTypeId: selectedUserType.value!.id!,
        leaveConfigId: selectedLeaveConfig.value!.id!,
        colorId: selectedColor.value!.id!,
        organizationId: UuidValue.fromString(
          '00000000-0000-4000-8000-000000000000',
        ), // Set by server
        performance: 0,
        online: false,
        onsite: false,
        deleted: false,
      );

      final response = await client.admin.createUser(
        user,
        passwordController.text,
      );
      if (response.success) {
        Get.back();
        Get.snackbar(
          "Success",
          "User created successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.withOpacity(0.1),
          colorText: Colors.green,
        );
      } else {
        Get.snackbar(
          "Error",
          response.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.withOpacity(0.1),
          colorText: Colors.red,
        );
      }
    } catch (e) {
      print("Error creating user: $e");
      Get.snackbar(
        "Error",
        "Failed to connect to server",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.1),
        colorText: Colors.red,
      );
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
    selectedUserType.value = null;
    selectedLeaveConfig.value = null;
    loadColors(); // Reset to default color
    image.value = null;
    verificationFiles.value = null;
    profilePreviewBytes.value = null;
    attachments.clear();

    // Clear errors
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
