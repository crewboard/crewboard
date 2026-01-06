/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../entities/organization.dart' as _i2;
import '../entities/system_color.dart' as _i3;
import '../entities/user_types.dart' as _i4;
import '../entities/leave_config.dart' as _i5;
import 'package:crewboard_server/src/generated/protocol.dart' as _i6;

abstract class User
    implements _i1.TableRow<_i1.UuidValue?>, _i1.ProtocolSerialization {
  User._({
    this.id,
    required this.userName,
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
  }) : _password = null;

  factory User({
    _i1.UuidValue? id,
    required String userName,
    String? image,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue colorId,
    _i3.SystemColor? color,
    required _i1.UuidValue userTypeId,
    _i4.UserTypes? userType,
    required _i1.UuidValue leaveConfigId,
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
    return UserImplicit._(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      userName: jsonSerialization['userName'] as String,
      image: jsonSerialization['image'] as String?,
      organizationId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['organizationId'],
      ),
      organization: jsonSerialization['organization'] == null
          ? null
          : _i6.Protocol().deserialize<_i2.Organization>(
              jsonSerialization['organization'],
            ),
      colorId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['colorId'],
      ),
      color: jsonSerialization['color'] == null
          ? null
          : _i6.Protocol().deserialize<_i3.SystemColor>(
              jsonSerialization['color'],
            ),
      userTypeId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['userTypeId'],
      ),
      userType: jsonSerialization['userType'] == null
          ? null
          : _i6.Protocol().deserialize<_i4.UserTypes>(
              jsonSerialization['userType'],
            ),
      leaveConfigId: _i1.UuidValueJsonExtension.fromJson(
        jsonSerialization['leaveConfigId'],
      ),
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
      $password: jsonSerialization['password'] as String?,
    );
  }

  static final t = UserTable();

  static const db = UserRepository._();

  @override
  _i1.UuidValue? id;

  String userName;

  final String? _password;

  String? image;

  _i1.UuidValue organizationId;

  _i2.Organization? organization;

  _i1.UuidValue colorId;

  _i3.SystemColor? color;

  _i1.UuidValue userTypeId;

  _i4.UserTypes? userType;

  _i1.UuidValue leaveConfigId;

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

  @override
  _i1.Table<_i1.UuidValue?> get table => t;

  /// Returns a shallow copy of this [User]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  User copyWith({
    _i1.UuidValue? id,
    String? userName,
    String? image,
    _i1.UuidValue? organizationId,
    _i2.Organization? organization,
    _i1.UuidValue? colorId,
    _i3.SystemColor? color,
    _i1.UuidValue? userTypeId,
    _i4.UserTypes? userType,
    _i1.UuidValue? leaveConfigId,
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
      if (id != null) 'id': id?.toJson(),
      'userName': userName,
      if (_password != null) 'password': _password,
      if (image != null) 'image': image,
      'organizationId': organizationId.toJson(),
      if (organization != null) 'organization': organization?.toJson(),
      'colorId': colorId.toJson(),
      if (color != null) 'color': color?.toJson(),
      'userTypeId': userTypeId.toJson(),
      if (userType != null) 'userType': userType?.toJson(),
      'leaveConfigId': leaveConfigId.toJson(),
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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'User',
      if (id != null) 'id': id?.toJson(),
      'userName': userName,
      if (image != null) 'image': image,
      'organizationId': organizationId.toJson(),
      if (organization != null)
        'organization': organization?.toJsonForProtocol(),
      'colorId': colorId.toJson(),
      if (color != null) 'color': color?.toJsonForProtocol(),
      'userTypeId': userTypeId.toJson(),
      if (userType != null) 'userType': userType?.toJsonForProtocol(),
      'leaveConfigId': leaveConfigId.toJson(),
      if (leaveConfig != null) 'leaveConfig': leaveConfig?.toJsonForProtocol(),
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

  static UserInclude include({
    _i2.OrganizationInclude? organization,
    _i3.SystemColorInclude? color,
    _i4.UserTypesInclude? userType,
    _i5.LeaveConfigInclude? leaveConfig,
  }) {
    return UserInclude._(
      organization: organization,
      color: color,
      userType: userType,
      leaveConfig: leaveConfig,
    );
  }

  static UserIncludeList includeList({
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    UserInclude? include,
  }) {
    return UserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(User.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserImpl extends User {
  _UserImpl({
    _i1.UuidValue? id,
    required String userName,
    String? image,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue colorId,
    _i3.SystemColor? color,
    required _i1.UuidValue userTypeId,
    _i4.UserTypes? userType,
    required _i1.UuidValue leaveConfigId,
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
    Object? image = _Undefined,
    _i1.UuidValue? organizationId,
    Object? organization = _Undefined,
    _i1.UuidValue? colorId,
    Object? color = _Undefined,
    _i1.UuidValue? userTypeId,
    Object? userType = _Undefined,
    _i1.UuidValue? leaveConfigId,
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
    return UserImplicit._(
      id: id is _i1.UuidValue? ? id : this.id,
      userName: userName ?? this.userName,
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
      $password: this._password,
    );
  }
}

class UserImplicit extends _UserImpl {
  UserImplicit._({
    _i1.UuidValue? id,
    required String userName,
    String? image,
    required _i1.UuidValue organizationId,
    _i2.Organization? organization,
    required _i1.UuidValue colorId,
    _i3.SystemColor? color,
    required _i1.UuidValue userTypeId,
    _i4.UserTypes? userType,
    required _i1.UuidValue leaveConfigId,
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
    String? $password,
  }) : _password = $password,
       super(
         id: id,
         userName: userName,
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

  factory UserImplicit(
    User user, {
    String? $password,
  }) {
    return UserImplicit._(
      id: user.id,
      userName: user.userName,
      image: user.image,
      organizationId: user.organizationId,
      organization: user.organization,
      colorId: user.colorId,
      color: user.color,
      userTypeId: user.userTypeId,
      userType: user.userType,
      leaveConfigId: user.leaveConfigId,
      leaveConfig: user.leaveConfig,
      performanceConfigId: user.performanceConfigId,
      firstName: user.firstName,
      lastName: user.lastName,
      gender: user.gender,
      dateOfBirth: user.dateOfBirth,
      phone: user.phone,
      email: user.email,
      bloodGroup: user.bloodGroup,
      salary: user.salary,
      experience: user.experience,
      punchId: user.punchId,
      attachments: user.attachments,
      performance: user.performance,
      plannerVariables: user.plannerVariables,
      online: user.online,
      onsite: user.onsite,
      deleted: user.deleted,
      $password: $password,
    );
  }

  @override
  final String? _password;
}

class UserUpdateTable extends _i1.UpdateTable<UserTable> {
  UserUpdateTable(super.table);

  _i1.ColumnValue<String, String> userName(String value) => _i1.ColumnValue(
    table.userName,
    value,
  );

  _i1.ColumnValue<String, String> $password(String? value) => _i1.ColumnValue(
    table.$password,
    value,
  );

  _i1.ColumnValue<String, String> image(String? value) => _i1.ColumnValue(
    table.image,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> organizationId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.organizationId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> colorId(_i1.UuidValue value) =>
      _i1.ColumnValue(
        table.colorId,
        value,
      );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> userTypeId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.userTypeId,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> leaveConfigId(
    _i1.UuidValue value,
  ) => _i1.ColumnValue(
    table.leaveConfigId,
    value,
  );

  _i1.ColumnValue<int, int> performanceConfigId(int? value) => _i1.ColumnValue(
    table.performanceConfigId,
    value,
  );

  _i1.ColumnValue<String, String> firstName(String value) => _i1.ColumnValue(
    table.firstName,
    value,
  );

  _i1.ColumnValue<String, String> lastName(String value) => _i1.ColumnValue(
    table.lastName,
    value,
  );

  _i1.ColumnValue<String, String> gender(String value) => _i1.ColumnValue(
    table.gender,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> dateOfBirth(DateTime? value) =>
      _i1.ColumnValue(
        table.dateOfBirth,
        value,
      );

  _i1.ColumnValue<String, String> phone(String value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> bloodGroup(String? value) => _i1.ColumnValue(
    table.bloodGroup,
    value,
  );

  _i1.ColumnValue<String, String> salary(String? value) => _i1.ColumnValue(
    table.salary,
    value,
  );

  _i1.ColumnValue<String, String> experience(String? value) => _i1.ColumnValue(
    table.experience,
    value,
  );

  _i1.ColumnValue<String, String> punchId(String? value) => _i1.ColumnValue(
    table.punchId,
    value,
  );

  _i1.ColumnValue<String, String> attachments(String? value) => _i1.ColumnValue(
    table.attachments,
    value,
  );

  _i1.ColumnValue<int, int> performance(int value) => _i1.ColumnValue(
    table.performance,
    value,
  );

  _i1.ColumnValue<String, String> plannerVariables(String? value) =>
      _i1.ColumnValue(
        table.plannerVariables,
        value,
      );

  _i1.ColumnValue<bool, bool> online(bool value) => _i1.ColumnValue(
    table.online,
    value,
  );

  _i1.ColumnValue<bool, bool> onsite(bool value) => _i1.ColumnValue(
    table.onsite,
    value,
  );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );
}

class UserTable extends _i1.Table<_i1.UuidValue?> {
  UserTable({super.tableRelation}) : super(tableName: 'users') {
    updateTable = UserUpdateTable(this);
    userName = _i1.ColumnString(
      'userName',
      this,
    );
    $password = _i1.ColumnString(
      'password',
      this,
    );
    image = _i1.ColumnString(
      'image',
      this,
    );
    organizationId = _i1.ColumnUuid(
      'organizationId',
      this,
    );
    colorId = _i1.ColumnUuid(
      'colorId',
      this,
    );
    userTypeId = _i1.ColumnUuid(
      'userTypeId',
      this,
    );
    leaveConfigId = _i1.ColumnUuid(
      'leaveConfigId',
      this,
    );
    performanceConfigId = _i1.ColumnInt(
      'performanceConfigId',
      this,
    );
    firstName = _i1.ColumnString(
      'firstName',
      this,
    );
    lastName = _i1.ColumnString(
      'lastName',
      this,
    );
    gender = _i1.ColumnString(
      'gender',
      this,
    );
    dateOfBirth = _i1.ColumnDateTime(
      'dateOfBirth',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    bloodGroup = _i1.ColumnString(
      'bloodGroup',
      this,
    );
    salary = _i1.ColumnString(
      'salary',
      this,
    );
    experience = _i1.ColumnString(
      'experience',
      this,
    );
    punchId = _i1.ColumnString(
      'punchId',
      this,
    );
    attachments = _i1.ColumnString(
      'attachments',
      this,
    );
    performance = _i1.ColumnInt(
      'performance',
      this,
    );
    plannerVariables = _i1.ColumnString(
      'plannerVariables',
      this,
    );
    online = _i1.ColumnBool(
      'online',
      this,
    );
    onsite = _i1.ColumnBool(
      'onsite',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final UserUpdateTable updateTable;

  late final _i1.ColumnString userName;

  late final _i1.ColumnString $password;

  late final _i1.ColumnString image;

  late final _i1.ColumnUuid organizationId;

  _i2.OrganizationTable? _organization;

  late final _i1.ColumnUuid colorId;

  _i3.SystemColorTable? _color;

  late final _i1.ColumnUuid userTypeId;

  _i4.UserTypesTable? _userType;

  late final _i1.ColumnUuid leaveConfigId;

  _i5.LeaveConfigTable? _leaveConfig;

  late final _i1.ColumnInt performanceConfigId;

  late final _i1.ColumnString firstName;

  late final _i1.ColumnString lastName;

  late final _i1.ColumnString gender;

  late final _i1.ColumnDateTime dateOfBirth;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString bloodGroup;

  late final _i1.ColumnString salary;

  late final _i1.ColumnString experience;

  late final _i1.ColumnString punchId;

  late final _i1.ColumnString attachments;

  late final _i1.ColumnInt performance;

  late final _i1.ColumnString plannerVariables;

  late final _i1.ColumnBool online;

  late final _i1.ColumnBool onsite;

  late final _i1.ColumnBool deleted;

  _i2.OrganizationTable get organization {
    if (_organization != null) return _organization!;
    _organization = _i1.createRelationTable(
      relationFieldName: 'organization',
      field: User.t.organizationId,
      foreignField: _i2.Organization.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.OrganizationTable(tableRelation: foreignTableRelation),
    );
    return _organization!;
  }

  _i3.SystemColorTable get color {
    if (_color != null) return _color!;
    _color = _i1.createRelationTable(
      relationFieldName: 'color',
      field: User.t.colorId,
      foreignField: _i3.SystemColor.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i3.SystemColorTable(tableRelation: foreignTableRelation),
    );
    return _color!;
  }

  _i4.UserTypesTable get userType {
    if (_userType != null) return _userType!;
    _userType = _i1.createRelationTable(
      relationFieldName: 'userType',
      field: User.t.userTypeId,
      foreignField: _i4.UserTypes.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i4.UserTypesTable(tableRelation: foreignTableRelation),
    );
    return _userType!;
  }

  _i5.LeaveConfigTable get leaveConfig {
    if (_leaveConfig != null) return _leaveConfig!;
    _leaveConfig = _i1.createRelationTable(
      relationFieldName: 'leaveConfig',
      field: User.t.leaveConfigId,
      foreignField: _i5.LeaveConfig.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i5.LeaveConfigTable(tableRelation: foreignTableRelation),
    );
    return _leaveConfig!;
  }

  @override
  List<_i1.Column> get columns => [
    id,
    userName,
    $password,
    image,
    organizationId,
    colorId,
    userTypeId,
    leaveConfigId,
    performanceConfigId,
    firstName,
    lastName,
    gender,
    dateOfBirth,
    phone,
    email,
    bloodGroup,
    salary,
    experience,
    punchId,
    attachments,
    performance,
    plannerVariables,
    online,
    onsite,
    deleted,
  ];

  @override
  List<_i1.Column> get managedColumns => [
    id,
    userName,
    image,
    organizationId,
    colorId,
    userTypeId,
    leaveConfigId,
    performanceConfigId,
    firstName,
    lastName,
    gender,
    dateOfBirth,
    phone,
    email,
    bloodGroup,
    salary,
    experience,
    punchId,
    attachments,
    performance,
    plannerVariables,
    online,
    onsite,
    deleted,
  ];

  @override
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'organization') {
      return organization;
    }
    if (relationField == 'color') {
      return color;
    }
    if (relationField == 'userType') {
      return userType;
    }
    if (relationField == 'leaveConfig') {
      return leaveConfig;
    }
    return null;
  }
}

class UserInclude extends _i1.IncludeObject {
  UserInclude._({
    _i2.OrganizationInclude? organization,
    _i3.SystemColorInclude? color,
    _i4.UserTypesInclude? userType,
    _i5.LeaveConfigInclude? leaveConfig,
  }) {
    _organization = organization;
    _color = color;
    _userType = userType;
    _leaveConfig = leaveConfig;
  }

  _i2.OrganizationInclude? _organization;

  _i3.SystemColorInclude? _color;

  _i4.UserTypesInclude? _userType;

  _i5.LeaveConfigInclude? _leaveConfig;

  @override
  Map<String, _i1.Include?> get includes => {
    'organization': _organization,
    'color': _color,
    'userType': _userType,
    'leaveConfig': _leaveConfig,
  };

  @override
  _i1.Table<_i1.UuidValue?> get table => User.t;
}

class UserIncludeList extends _i1.IncludeList {
  UserIncludeList._({
    _i1.WhereExpressionBuilder<UserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(User.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<_i1.UuidValue?> get table => User.t;
}

class UserRepository {
  const UserRepository._();

  final attachRow = const UserAttachRowRepository._();

  /// Returns a list of [User]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<User>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.find<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Returns the first matching [User] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<User?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findFirstRow<User>(
      where: where?.call(User.t),
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [User] by its [id] or null if no such row exists.
  Future<User?> findById(
    _i1.Session session,
    _i1.UuidValue id, {
    _i1.Transaction? transaction,
    UserInclude? include,
  }) async {
    return session.db.findById<User>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [User]s in the list and returns the inserted rows.
  ///
  /// The returned [User]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<User>> insert(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [User] and returns the inserted row.
  ///
  /// The returned [User] will have its `id` field set.
  Future<User> insertRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [User]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<User>> update(
    _i1.Session session,
    List<User> rows, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<User>(
      rows,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<User> updateRow(
    _i1.Session session,
    User row, {
    _i1.ColumnSelections<UserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<User>(
      row,
      columns: columns?.call(User.t),
      transaction: transaction,
    );
  }

  /// Updates a single [User] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<User?> updateById(
    _i1.Session session,
    _i1.UuidValue id, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<User>(
      id,
      columnValues: columnValues(User.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [User]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<User>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<UserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<UserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserTable>? orderBy,
    _i1.OrderByListBuilder<UserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<User>(
      columnValues: columnValues(User.t.updateTable),
      where: where(User.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(User.t),
      orderByList: orderByList?.call(User.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [User]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<User>> delete(
    _i1.Session session,
    List<User> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<User>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [User].
  Future<User> deleteRow(
    _i1.Session session,
    User row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<User>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<User>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<UserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<User>(
      where: where(User.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<UserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<User>(
      where: where?.call(User.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class UserAttachRowRepository {
  const UserAttachRowRepository._();

  /// Creates a relation between the given [User] and [Organization]
  /// by setting the [User]'s foreign key `organizationId` to refer to the [Organization].
  Future<void> organization(
    _i1.Session session,
    User user,
    _i2.Organization organization, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (organization.id == null) {
      throw ArgumentError.notNull('organization.id');
    }

    var $user = user.copyWith(organizationId: organization.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.organizationId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [User] and [SystemColor]
  /// by setting the [User]'s foreign key `colorId` to refer to the [SystemColor].
  Future<void> color(
    _i1.Session session,
    User user,
    _i3.SystemColor color, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (color.id == null) {
      throw ArgumentError.notNull('color.id');
    }

    var $user = user.copyWith(colorId: color.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.colorId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [User] and [UserTypes]
  /// by setting the [User]'s foreign key `userTypeId` to refer to the [UserTypes].
  Future<void> userType(
    _i1.Session session,
    User user,
    _i4.UserTypes userType, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (userType.id == null) {
      throw ArgumentError.notNull('userType.id');
    }

    var $user = user.copyWith(userTypeId: userType.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.userTypeId],
      transaction: transaction,
    );
  }

  /// Creates a relation between the given [User] and [LeaveConfig]
  /// by setting the [User]'s foreign key `leaveConfigId` to refer to the [LeaveConfig].
  Future<void> leaveConfig(
    _i1.Session session,
    User user,
    _i5.LeaveConfig leaveConfig, {
    _i1.Transaction? transaction,
  }) async {
    if (user.id == null) {
      throw ArgumentError.notNull('user.id');
    }
    if (leaveConfig.id == null) {
      throw ArgumentError.notNull('leaveConfig.id');
    }

    var $user = user.copyWith(leaveConfigId: leaveConfig.id);
    await session.db.updateRow<User>(
      $user,
      columns: [User.t.leaveConfigId],
      transaction: transaction,
    );
  }
}
