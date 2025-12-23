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
import 'user.dart' as _i2;
import 'device_type.dart' as _i3;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i4;

abstract class UserDevice implements _i1.SerializableModel {
  UserDevice._({
    this.id,
    required this.userId,
    this.user,
    required this.deviceType,
    required this.hardwareId,
    this.socketId,
  });

  factory UserDevice({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.DeviceType deviceType,
    required String hardwareId,
    String? socketId,
  }) = _UserDeviceImpl;

  factory UserDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserDevice(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      user: jsonSerialization['user'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.User>(jsonSerialization['user']),
      deviceType: _i3.DeviceType.fromJson(
        (jsonSerialization['deviceType'] as String),
      ),
      hardwareId: jsonSerialization['hardwareId'] as String,
      socketId: jsonSerialization['socketId'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.User? user;

  _i3.DeviceType deviceType;

  String hardwareId;

  String? socketId;

  /// Returns a shallow copy of this [UserDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserDevice copyWith({
    int? id,
    int? userId,
    _i2.User? user,
    _i3.DeviceType? deviceType,
    String? hardwareId,
    String? socketId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserDevice',
      if (id != null) 'id': id,
      'userId': userId,
      if (user != null) 'user': user?.toJson(),
      'deviceType': deviceType.toJson(),
      'hardwareId': hardwareId,
      if (socketId != null) 'socketId': socketId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserDeviceImpl extends UserDevice {
  _UserDeviceImpl({
    int? id,
    required int userId,
    _i2.User? user,
    required _i3.DeviceType deviceType,
    required String hardwareId,
    String? socketId,
  }) : super._(
         id: id,
         userId: userId,
         user: user,
         deviceType: deviceType,
         hardwareId: hardwareId,
         socketId: socketId,
       );

  /// Returns a shallow copy of this [UserDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserDevice copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? user = _Undefined,
    _i3.DeviceType? deviceType,
    String? hardwareId,
    Object? socketId = _Undefined,
  }) {
    return UserDevice(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      user: user is _i2.User? ? user : this.user?.copyWith(),
      deviceType: deviceType ?? this.deviceType,
      hardwareId: hardwareId ?? this.hardwareId,
      socketId: socketId is String? ? socketId : this.socketId,
    );
  }
}
