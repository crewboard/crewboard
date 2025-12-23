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

abstract class TicketAttachmentDTO
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  TicketAttachmentDTO._({
    required this.name,
    required this.size,
    required this.url,
    required this.type,
  });

  factory TicketAttachmentDTO({
    required String name,
    required double size,
    required String url,
    required String type,
  }) = _TicketAttachmentDTOImpl;

  factory TicketAttachmentDTO.fromJson(Map<String, dynamic> jsonSerialization) {
    return TicketAttachmentDTO(
      name: jsonSerialization['name'] as String,
      size: (jsonSerialization['size'] as num).toDouble(),
      url: jsonSerialization['url'] as String,
      type: jsonSerialization['type'] as String,
    );
  }

  String name;

  double size;

  String url;

  String type;

  /// Returns a shallow copy of this [TicketAttachmentDTO]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  TicketAttachmentDTO copyWith({
    String? name,
    double? size,
    String? url,
    String? type,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TicketAttachmentDTO',
      'name': name,
      'size': size,
      'url': url,
      'type': type,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TicketAttachmentDTO',
      'name': name,
      'size': size,
      'url': url,
      'type': type,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _TicketAttachmentDTOImpl extends TicketAttachmentDTO {
  _TicketAttachmentDTOImpl({
    required String name,
    required double size,
    required String url,
    required String type,
  }) : super._(
         name: name,
         size: size,
         url: url,
         type: type,
       );

  /// Returns a shallow copy of this [TicketAttachmentDTO]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  TicketAttachmentDTO copyWith({
    String? name,
    double? size,
    String? url,
    String? type,
  }) {
    return TicketAttachmentDTO(
      name: name ?? this.name,
      size: size ?? this.size,
      url: url ?? this.url,
      type: type ?? this.type,
    );
  }
}
