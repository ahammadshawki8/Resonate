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
import 'voice_entry.dart' as _i2;
import 'tag.dart' as _i3;
import 'package:resonate_server_server/src/generated/protocol.dart' as _i4;

/// Voice entry with tags (DTO).
abstract class VoiceEntryWithTags
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  VoiceEntryWithTags._({
    required this.entry,
    required this.tags,
  });

  factory VoiceEntryWithTags({
    required _i2.VoiceEntry entry,
    required List<_i3.Tag> tags,
  }) = _VoiceEntryWithTagsImpl;

  factory VoiceEntryWithTags.fromJson(Map<String, dynamic> jsonSerialization) {
    return VoiceEntryWithTags(
      entry: _i4.Protocol().deserialize<_i2.VoiceEntry>(
        jsonSerialization['entry'],
      ),
      tags: _i4.Protocol().deserialize<List<_i3.Tag>>(
        jsonSerialization['tags'],
      ),
    );
  }

  _i2.VoiceEntry entry;

  List<_i3.Tag> tags;

  /// Returns a shallow copy of this [VoiceEntryWithTags]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VoiceEntryWithTags copyWith({
    _i2.VoiceEntry? entry,
    List<_i3.Tag>? tags,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VoiceEntryWithTags',
      'entry': entry.toJson(),
      'tags': tags.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'VoiceEntryWithTags',
      'entry': entry.toJsonForProtocol(),
      'tags': tags.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _VoiceEntryWithTagsImpl extends VoiceEntryWithTags {
  _VoiceEntryWithTagsImpl({
    required _i2.VoiceEntry entry,
    required List<_i3.Tag> tags,
  }) : super._(
         entry: entry,
         tags: tags,
       );

  /// Returns a shallow copy of this [VoiceEntryWithTags]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VoiceEntryWithTags copyWith({
    _i2.VoiceEntry? entry,
    List<_i3.Tag>? tags,
  }) {
    return VoiceEntryWithTags(
      entry: entry ?? this.entry.copyWith(),
      tags: tags ?? this.tags.map((e0) => e0.copyWith()).toList(),
    );
  }
}
