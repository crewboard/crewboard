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
import '../protocols/comment_model.dart' as _i2;
import 'package:crewboard_client/src/protocol/protocol.dart' as _i3;

abstract class GetTicketCommentsResponse implements _i1.SerializableModel {
  GetTicketCommentsResponse._({required this.comments});

  factory GetTicketCommentsResponse({
    required List<_i2.CommentModel> comments,
  }) = _GetTicketCommentsResponseImpl;

  factory GetTicketCommentsResponse.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return GetTicketCommentsResponse(
      comments: _i3.Protocol().deserialize<List<_i2.CommentModel>>(
        jsonSerialization['comments'],
      ),
    );
  }

  List<_i2.CommentModel> comments;

  /// Returns a shallow copy of this [GetTicketCommentsResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  GetTicketCommentsResponse copyWith({List<_i2.CommentModel>? comments});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'GetTicketCommentsResponse',
      'comments': comments.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _GetTicketCommentsResponseImpl extends GetTicketCommentsResponse {
  _GetTicketCommentsResponseImpl({required List<_i2.CommentModel> comments})
    : super._(comments: comments);

  /// Returns a shallow copy of this [GetTicketCommentsResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  GetTicketCommentsResponse copyWith({List<_i2.CommentModel>? comments}) {
    return GetTicketCommentsResponse(
      comments: comments ?? this.comments.map((e0) => e0.copyWith()).toList(),
    );
  }
}
