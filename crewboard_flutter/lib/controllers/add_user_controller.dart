import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import '../main.dart'; // Access to client

class Gender {
  final String? value;
  const Gender({required this.value});
  const Gender.empty() : value = null;
  Map<String, dynamic> toJson() => {'name': value};
  @override
  String toString() => value ?? "Select";
}

class BloodGroup {
  final String? value;
  const BloodGroup({required this.value});
  const BloodGroup.empty() : value = null;
  Map<String, dynamic> toJson() => {'name': value};
  @override
  String toString() => value ?? "Select";
}

class AddUserState {
  final int currentPage;
  final bool isEdited;
  final Gender selectedGender;
  final String dateOfBirth;
  final BloodGroup selectedBloodGroup;
  final UserTypes? selectedUserType;
  final LeaveConfig? selectedLeaveConfig;
  final SystemColor? selectedColor;
  final FilePickerResult? imageResult;
  final FilePickerResult? verificationFilesResult;
  final Uint8List? profilePreviewBytes;
  final List<Map<String, dynamic>> attachments;
  final String userNameError;
  final String passwordError;
  final String userTypeError;
  final String leaveConfigError;
  final String firstNameError;
  final String lastNameError;
  final String genderError;
  final String dateOfBirthError;
  final String phoneError;
  final String emailError;
  final String bloodGroupError;
  final bool isLoading;
  final bool isCheckingUsername;
  final List<UserTypes> userTypesList;
  final List<LeaveConfig> leaveConfigsList;
  final List<SystemColor> colorsList;
  final User? editingUser;

  AddUserState({
    this.currentPage = 1,
    this.isEdited = false,
    this.selectedGender = const Gender.empty(),
    this.dateOfBirth = '',
    this.selectedBloodGroup = const BloodGroup.empty(),
    this.selectedUserType,
    this.selectedLeaveConfig,
    this.selectedColor,
    this.imageResult,
    this.verificationFilesResult,
    this.profilePreviewBytes,
    this.attachments = const [],
    this.userNameError = '',
    this.passwordError = '',
    this.userTypeError = '',
    this.leaveConfigError = '',
    this.firstNameError = '',
    this.lastNameError = '',
    this.genderError = '',
    this.dateOfBirthError = '',
    this.phoneError = '',
    this.emailError = '',
    this.bloodGroupError = '',
    this.isLoading = false,
    this.isCheckingUsername = false,
    this.userTypesList = const [],
    this.leaveConfigsList = const [],
    this.colorsList = const [],
    this.editingUser,
  });

  AddUserState copyWith({
    int? currentPage,
    bool? isEdited,
    Gender? selectedGender,
    String? dateOfBirth,
    BloodGroup? selectedBloodGroup,
    UserTypes? selectedUserType,
    LeaveConfig? selectedLeaveConfig,
    SystemColor? selectedColor,
    FilePickerResult? imageResult,
    FilePickerResult? verificationFilesResult,
    Uint8List? profilePreviewBytes,
    List<Map<String, dynamic>>? attachments,
    String? userNameError,
    String? passwordError,
    String? userTypeError,
    String? leaveConfigError,
    String? firstNameError,
    String? lastNameError,
    String? genderError,
    String? dateOfBirthError,
    String? phoneError,
    String? emailError,
    String? bloodGroupError,
    bool? isLoading,
    bool? isCheckingUsername,
    List<UserTypes>? userTypesList,
    List<LeaveConfig>? leaveConfigsList,
    List<SystemColor>? colorsList,
    User? editingUser,
    bool clearEditingUser = false,
  }) {
    return AddUserState(
      currentPage: currentPage ?? this.currentPage,
      isEdited: isEdited ?? this.isEdited,
      selectedGender: selectedGender ?? this.selectedGender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      selectedBloodGroup: selectedBloodGroup ?? this.selectedBloodGroup,
      selectedUserType: selectedUserType ?? this.selectedUserType,
      selectedLeaveConfig: selectedLeaveConfig ?? this.selectedLeaveConfig,
      selectedColor: selectedColor ?? this.selectedColor,
      imageResult: imageResult ?? this.imageResult,
      verificationFilesResult: verificationFilesResult ?? this.verificationFilesResult,
      profilePreviewBytes: profilePreviewBytes ?? this.profilePreviewBytes,
      attachments: attachments ?? this.attachments,
      userNameError: userNameError ?? this.userNameError,
      passwordError: passwordError ?? this.passwordError,
      userTypeError: userTypeError ?? this.userTypeError,
      leaveConfigError: leaveConfigError ?? this.leaveConfigError,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
      genderError: genderError ?? this.genderError,
      dateOfBirthError: dateOfBirthError ?? this.dateOfBirthError,
      phoneError: phoneError ?? this.phoneError,
      emailError: emailError ?? this.emailError,
      bloodGroupError: bloodGroupError ?? this.bloodGroupError,
      isLoading: isLoading ?? this.isLoading,
      isCheckingUsername: isCheckingUsername ?? this.isCheckingUsername,
      userTypesList: userTypesList ?? this.userTypesList,
      leaveConfigsList: leaveConfigsList ?? this.leaveConfigsList,
      colorsList: colorsList ?? this.colorsList,
      editingUser: clearEditingUser ? null : (editingUser ?? this.editingUser),
    );
  }
}

final addUserProvider = NotifierProvider<AddUserNotifier, AddUserState>(AddUserNotifier.new);

class AddUserNotifier extends Notifier<AddUserState> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final punchIdController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final salaryController = TextEditingController();
  final experienceController = TextEditingController();

  final List<Gender> genders = const [
    Gender(value: "male"),
    Gender(value: "female"),
    Gender(value: "others"),
  ];
  
  final List<BloodGroup> bloodGroups = const [
    BloodGroup(value: "A+"), BloodGroup(value: "A-"),
    BloodGroup(value: "B+"), BloodGroup(value: "B-"),
    BloodGroup(value: "O+"), BloodGroup(value: "O-"),
    BloodGroup(value: "AB+"), BloodGroup(value: "AB-"),
  ];

  @override
  AddUserState build() {
    Future.microtask(() => loadInitialData());
    ref.onDispose(() {
      userNameController.dispose();
      passwordController.dispose();
      punchIdController.dispose();
      firstNameController.dispose();
      lastNameController.dispose();
      phoneController.dispose();
      emailController.dispose();
      salaryController.dispose();
      experienceController.dispose();
    });
    return AddUserState();
  }

  Future<void> loadInitialData() async {
    await Future.wait([
      loadUserTypes(),
      loadLeaveConfigs(),
      loadColors(),
    ]);
  }

  Future<void> loadUserTypes() async {
    try {
      final types = await client.admin.getUserTypes();
      state = state.copyWith(
        userTypesList: types,
        selectedUserType: state.selectedUserType ?? (types.isNotEmpty ? types.first : null),
      );
    } catch (e) {
      debugPrint("Error fetching user types: $e");
    }
  }

  Future<void> loadLeaveConfigs() async {
    try {
      final configs = await client.admin.getLeaveConfigs();
      state = state.copyWith(
        leaveConfigsList: configs,
        selectedLeaveConfig: state.selectedLeaveConfig ?? (configs.isNotEmpty ? configs.first : null),
      );
    } catch (e) {
      debugPrint("Error fetching leave configs: $e");
    }
  }

  Future<void> loadColors() async {
    try {
      final fetchedColors = await client.admin.getColors();
      SystemColor? defaultColor;
      if (fetchedColors.isNotEmpty) {
        defaultColor = fetchedColors.firstWhere((c) => c.isDefault, orElse: () => fetchedColors.first);
      }
      state = state.copyWith(colorsList: fetchedColors, selectedColor: defaultColor);
    } catch (e) {
      debugPrint("Error fetching colors: $e");
    }
  }

  Future<void> checkUsername(String username) async {
    if (username.isEmpty || username.length < 2) {
      state = state.copyWith(userNameError: '');
      return;
    }
    state = state.copyWith(isCheckingUsername: true);
    try {
      final response = await client.auth.checkUsername(username);
      state = state.copyWith(userNameError: response.exists ? "user name exists" : "", isCheckingUsername: false);
    } catch (e) {
      debugPrint("Error checking username: $e");
      state = state.copyWith(isCheckingUsername: false);
    }
  }

  void setCurrentPage(int page) => state = state.copyWith(currentPage: page);
  
  void setEdited(bool edited) => state = state.copyWith(isEdited: edited);
  void setPasswordError(String error) => state = state.copyWith(passwordError: error);

  void setFormData(User? user) {
    if (user == null) return;
    userNameController.text = user.userName;
    firstNameController.text = user.firstName;
    lastNameController.text = user.lastName;
    emailController.text = user.email;
    phoneController.text = user.phone;
    punchIdController.text = user.punchId ?? '';
    salaryController.text = user.salary ?? '';
    experienceController.text = user.experience ?? '';
    
    if (user.dateOfBirth != null) {
       state = state.copyWith(dateOfBirth: user.dateOfBirth.toString().split(' ')[0]);
    }
 
    state = state.copyWith(selectedGender: genders.firstWhere((g) => g.value == user.gender, orElse: () => const Gender.empty()));
 
    if (user.bloodGroup != null) {
      state = state.copyWith(selectedBloodGroup: bloodGroups.firstWhere((b) => b.value == user.bloodGroup, orElse: () => const BloodGroup.empty()));
    }
    
    // Set relations
    state = state.copyWith(
      selectedUserType: user.userType,
      selectedLeaveConfig: user.leaveConfig,
      selectedColor: user.color,
      editingUser: user,
    );
  }
  
  void selectGender(Gender gender) => state = state.copyWith(selectedGender: gender, isEdited: true);
  void selectBloodGroup(BloodGroup bg) => state = state.copyWith(selectedBloodGroup: bg, isEdited: true);
  void selectUserType(UserTypes type) => state = state.copyWith(selectedUserType: type, isEdited: true);
  void selectLeaveConfig(LeaveConfig config) => state = state.copyWith(selectedLeaveConfig: config, isEdited: true);
  void selectColor(SystemColor color) => state = state.copyWith(selectedColor: color, isEdited: true);
  void setDateOfBirth(String dob) => state = state.copyWith(dateOfBirth: dob, isEdited: true);

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
    if (result != null && result.files.isNotEmpty) {
      state = state.copyWith(imageResult: result, profilePreviewBytes: result.files.first.bytes, isEdited: true);
    }
  }

  Future<void> pickVerificationFiles() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true, withData: true);
    if (result != null && result.files.isNotEmpty) {
      final attachments = result.files.map((f) => {"name": f.name, "size": f.size}).toList();
      state = state.copyWith(verificationFilesResult: result, attachments: attachments, isEdited: true);
    }
  }

  bool validatePage1() {
    final uError = userNameController.text.isEmpty ? "username is required" : "";
    final pError = passwordController.text.isEmpty ? "password is required" : "";
    final utError = state.selectedUserType == null ? "user type is required" : "";
    final lcError = state.selectedLeaveConfig == null ? "leave config is required" : "";

    state = state.copyWith(
      userNameError: uError,
      passwordError: pError,
      userTypeError: utError,
      leaveConfigError: lcError,
    );

    return uError.isEmpty && pError.isEmpty && utError.isEmpty && lcError.isEmpty;
  }

  bool validatePage2() {
    final fError = firstNameController.text.isEmpty ? "first name is required" : "";
    final lError = lastNameController.text.isEmpty ? "last name is required" : "";
    final gError = state.selectedGender.value == null ? "gender is required" : "";
    final dError = state.dateOfBirth.isEmpty ? "please select date of birth" : "";
    final phError = phoneController.text.isEmpty ? "phone is required" : "";
    final eError = emailController.text.isEmpty ? "email id is required" : "";

    state = state.copyWith(
      firstNameError: fError,
      lastNameError: lError,
      genderError: gError,
      dateOfBirthError: dError,
      phoneError: phError,
      emailError: eError,
    );

    return fError.isEmpty && lError.isEmpty && gError.isEmpty && dError.isEmpty && phError.isEmpty && eError.isEmpty;
  }

  Future<bool> createUser() async {
    state = state.copyWith(isLoading: true);
    try {
      final user = User(
        id: state.editingUser?.id,
        userName: userNameController.text,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneController.text,
        gender: state.selectedGender.value ?? 'unspecified',
        dateOfBirth: state.dateOfBirth.isNotEmpty ? DateTime.parse(state.dateOfBirth) : null,
        bloodGroup: state.selectedBloodGroup.value,
        salary: salaryController.text,
        experience: experienceController.text,
        punchId: punchIdController.text,
        userTypeId: state.selectedUserType!.id!,
        leaveConfigId: state.selectedLeaveConfig!.id!,
        colorId: state.selectedColor!.id!,
        organizationId: state.editingUser?.organizationId ?? UuidValue.fromString('00000000-0000-4000-8000-000000000000'),
        performance: state.editingUser?.performance ?? 0,
        online: state.editingUser?.online ?? false,
        onsite: state.editingUser?.onsite ?? false,
        deleted: state.editingUser?.deleted ?? false,
      );

      if (state.editingUser != null) {
        await client.admin.updateUser(user);
        return true;
      }

      final response = await client.admin.createUser(user, passwordController.text);
      if (response.success) {
        return true;
      } else {
        debugPrint("Error creating user: ${response.message}");
        return false;
      }
    } catch (e) {
      debugPrint("Error creating user: $e");
      return false;
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void reset() {
    userNameController.clear();
    passwordController.clear();
    punchIdController.clear();
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    emailController.clear();
    salaryController.clear();
    experienceController.clear();
    state = AddUserState(
      userTypesList: state.userTypesList,
      leaveConfigsList: state.leaveConfigsList,
      colorsList: state.colorsList,
    );
    loadColors();
  }
}
