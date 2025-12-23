/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'organization.dart' as _i2;
import 'system_color.dart' as _i3;
import 'user_types.dart' as _i4;
import 'leave_config.dart' as _i5;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i6;

abstract class User implements _i1.SerializableModel {
  User._({
    this.id,
    required this.userName,
    required this.password,
    this.image,
    required this.organizationId,
    this.organization,
    required this.colorId,
    this.color,
    required this.userTypeId,
    this.userType,
    required this.leaveConfigId,
    this.leaveConfig,
    this.performanceConfigId,
    required this.firstName,
    required this.lastName,
    required this.gender,
    this.dateOfBirth,
    required this.phone,
    required this.email,
    this.bloodGroup,
    this.salary,
    this.experience,
    this.punchId,
    this.attachments,
    required this.performance,
    this.plannerVariables,
    required this.online,
    required this.onsite,
    required this.deleted,
  });

  factory User({
    int? id,
    required String userName,
    required String password,
    String? image,
    required int organizationId,
    _i2.Organization? organization,
    required int colorId,
    _i3.SystemColor? color,
    required int userTypeId,
    _i4.UserTypes? userType,
    required int leaveConfigId,
    _i5.LeaveConfig? leaveConfig,
    int? performanceConfigId,
    required String firstName,
    required String lastName,
    required String gender,
    DateTime? dateOfBirth,
    required String phone,
    required String email,
    String? bloodGroup,
    String? salary,
    String? experience,
    String? punchId,
    String? attachments,
    required int performance,
    String? plannerVariables,
    required bool online,
    required bool onsite,
    required bool deleted,
  }) = _UserImpl;

  factory User.fromJson(Map<String, dynamic> jsonSerialization) {
    return User(
      id: jsonSerialization['id'] as int?,
      userName: jsonSerialization['userName'] as String,
      password: jsonSerialization['password'] as String,
      image: jsonSerialization['image'] as String?,
      organizationId: jsonSerialization['organizationId'] as int,
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      colorId: jsonSerialization['colorId'] as int,
      color: jsonSerialization['color'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.SystemColor>(
              jsonSerialization['color'],
            ),
      userTypeId: jsonSerialization['userTypeId'] as int,
      userType: jsonSerialization['userType'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.UserTypes>(
              jsonSerialization['userType'],
            ),
      leaveConfigId: jsonSerialization['leaveConfigId'] as int,
      leaveConfig: jsonSerialization['leaveConfig'] == null
          ? null
          : _i6.Protocol().deserialize<_i5.LeaveConfig>(
              jsonSerialization['leaveConfig'],
            ),
      performanceConfigId: jsonSerialization['performanceConfigId'] as int?,
      firstName: jsonSerialization['firstName'] as String,
      lastName: jsonSerialization['lastName'] as String,
      gender: jsonSerialization['gender'] as String,
      dateOfBirth: jsonSerialization['dateOfBirth'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateOfBirth'],
            ),
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      bloodGroup: jsonSerialization['bloodGroup'] as String?,
      salary: jsonSerialization['salary'] as String?,
      experience: jsonSerialization['experience'] as String?,
      punchId: jsonSerialization['punchId'] as String?,
      attachments: jsonSerialization['attachments'] as String?,
      performance: jsonSerialization['performance'] as int,
      plannerVariables: jsonSerialization['plannerVariables'] as String?,
      online: jsonSerialization['online'] as bool,
      onsite: jsonSerialization['onsite'] as bool,
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String userName;

  String password;

  String? image;

  int organizationId;

  _i2.Organization? organization;

  int colorId;

  _i3.SystemColor? color;

  int userTypeId;

  _i4.UserTypes? userType;

  int leaveConfigId;

  _i5.LeaveConfig? leaveConfig;

  int? performanceConfigId;

  String firstName;

  String lastName;

  String gender;

  DateTime? dateOfBirth;

  String phone;

  String email;

  String? bloodGroup;

  String? salary;

  String? experience;

  String? punchId;

  String? attachments;

  int performance;

  String? plannerVariables;

  bool online;

  bool onsite;

  bool deleted;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    int? id,
    String? userName,
    String? password,
    String? image,
    int? organizationId,
    _i2.Organization? organization,
    int? colorId,
    _i3.SystemColor? color,
    int? userTypeId,
    _i4.UserTypes? userType,
    int? leaveConfigId,
    _i5.LeaveConfig? leaveConfig,
    int? performanceConfigId,
    String? firstName,
    String? lastName,
    String? gender,
    DateTime? dateOfBirth,
    String? phone,
    String? email,
    String? bloodGroup,
    String? salary,
    String? experience,
    String? punchId,
    String? attachments,
    int? performance,
    String? plannerVariables,
    bool? online,
    bool? onsite,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id,
      'userName': userName,
      'password': password,
      if (image != null) 'image': image,
      'organizationId': organizationId,
      if (organization != null) 'organization': organization?.toJson(),
      'colorId': colorId,
      if (color != null) 'color': color?.toJson(),
      'userTypeId': userTypeId,
      if (userType != null) 'userType': userType?.toJson(),
      'leaveConfigId': leaveConfigId,
      if (leaveConfig != null) 'leaveConfig': leaveConfig?.toJson(),
      if (performanceConfigId != null)
        'performanceConfigId': performanceConfigId,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      'phone': phone,
      'email': email,
      if (bloodGroup != null) 'bloodGroup': bloodGroup,
      if (salary != null) 'salary': salary,
      if (experience != null) 'experience': experience,
      if (punchId != null) 'punchId': punchId,
      if (attachments != null) 'attachments': attachments,
      'performance': performance,
      if (plannerVariables != null) 'plannerVariables': plannerVariables,
      'online': online,
      'onsite': onsite,
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    int? id,
    required String userName,
    required String password,
    String? image,
    required int organizationId,
    _i2.Organization? organization,
    required int colorId,
    _i3.SystemColor? color,
    required int userTypeId,
    _i4.UserTypes? userType,
    required int leaveConfigId,
    _i5.LeaveConfig? leaveConfig,
    int? performanceConfigId,
    required String firstName,
    required String lastName,
    required String gender,
    DateTime? dateOfBirth,
    required String phone,
    required String email,
    String? bloodGroup,
    String? salary,
    String? experience,
    String? punchId,
    String? attachments,
    required int performance,
    String? plannerVariables,
    required bool online,
    required bool onsite,
    required bool deleted,
  }) : super._(
         id: id,
         userName: userName,
         password: password,
         image: image,
         organizationId: organizationId,
         organization: organization,
         colorId: colorId,
         color: color,
         userTypeId: userTypeId,
         userType: userType,
         leaveConfigId: leaveConfigId,
         leaveConfig: leaveConfig,
         performanceConfigId: performanceConfigId,
         firstName: firstName,
         lastName: lastName,
         gender: gender,
         dateOfBirth: dateOfBirth,
         phone: phone,
         email: email,
         bloodGroup: bloodGroup,
         salary: salary,
         experience: experience,
         punchId: punchId,
         attachments: attachments,
         performance: performance,
         plannerVariables: plannerVariables,
         online: online,
         onsite: onsite,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  User copyWith({
    Object? id = _Undefined,
    String? userName,
    String? password,
    Object? image = _Undefined,
    int? organizationId,
    Object? organization = _Undefined,
    int? colorId,
    Object? color = _Undefined,
    int? userTypeId,
    Object? userType = _Undefined,
    int? leaveConfigId,
    Object? leaveConfig = _Undefined,
    Object? performanceConfigId = _Undefined,
    String? firstName,
    String? lastName,
    String? gender,
    Object? dateOfBirth = _Undefined,
    String? phone,
    String? email,
    Object? bloodGroup = _Undefined,
    Object? salary = _Undefined,
    Object? experience = _Undefined,
    Object? punchId = _Undefined,
    Object? attachments = _Undefined,
    int? performance,
    Object? plannerVariables = _Undefined,
    bool? online,
    bool? onsite,
    bool? deleted,
  }) {
    return User(
      id: id is int? ? id : this.id,
      userName: userName ?? this.userName,
      password: password ?? this.password,
      image: image is String? ? image : this.image,
      organizationId: organizationId ?? this.organizationId,
      organization: organization is _i2.Organization?
          ? organization
          : this.organization?.copyWith(),
      colorId: colorId ?? this.colorId,
      color: color is _i3.SystemColor? ? color : this.color?.copyWith(),
      userTypeId: userTypeId ?? this.userTypeId,
      userType: userType is _i4.UserTypes?
          ? userType
          : this.userType?.copyWith(),
      leaveConfigId: leaveConfigId ?? this.leaveConfigId,
      leaveConfig: leaveConfig is _i5.LeaveConfig?
          ? leaveConfig
          : this.leaveConfig?.copyWith(),
      performanceConfigId: performanceConfigId is int?
          ? performanceConfigId
          : this.performanceConfigId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth is DateTime? ? dateOfBirth : this.dateOfBirth,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      bloodGroup: bloodGroup is String? ? bloodGroup : this.bloodGroup,
      salary: salary is String? ? salary : this.salary,
      experience: experience is String? ? experience : this.experience,
      punchId: punchId is String? ? punchId : this.punchId,
      attachments: attachments is String? ? attachments : this.attachments,
      performance: performance ?? this.performance,
      plannerVariables: plannerVariables is String?
          ? plannerVariables
          : this.plannerVariables,
      online: online ?? this.online,
      onsite: onsite ?? this.onsite,
      deleted: deleted ?? this.deleted,
    );
  }
}
