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
import 'package:serverpod/serverpod.dart' as _i1;

abstract class UserModel
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserModel._({
    required this.userId,
    required this.userName,
    required this.color,
    required this.selected,
  });

  factory UserModel({
    required int userId,
    required String userName,
    required String color,
    required bool selected,
  }) = _UserModelImpl;

  factory UserModel.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserModel(
      userId: jsonSerialization['userId'] as int,
      userName: jsonSerialization['userName'] as String,
      color: jsonSerialization['color'] as String,
      selected: jsonSerialization['selected'] as bool,
    );
  }

  int userId;

  String userName;

  String color;

  bool selected;

  /// Returns a shallow copy of this [UserModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserModel copyWith({
    int? userId,
    String? userName,
    String? color,
    bool? selected,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserModel',
      'userId': userId,
      'userName': userName,
      'color': color,
      'selected': selected,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserModel',
      'userId': userId,
      'userName': userName,
      'color': color,
      'selected': selected,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _UserModelImpl extends UserModel {
  _UserModelImpl({
    required int userId,
    required String userName,
    required String color,
    required bool selected,
  }) : super._(
         userId: userId,
         userName: userName,
         color: color,
         selected: selected,
       );

  /// Returns a shallow copy of this [UserModel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserModel copyWith({
    int? userId,
    String? userName,
    String? color,
    bool? selected,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      color: color ?? this.color,
      selected: selected ?? this.selected,
    );
  }
}
