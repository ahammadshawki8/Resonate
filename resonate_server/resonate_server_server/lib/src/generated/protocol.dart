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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'analysis_result.dart' as _i5;
import 'calendar_day_entry.dart' as _i6;
import 'calendar_month.dart' as _i7;
import 'contact.dart' as _i8;
import 'daily_mood_data.dart' as _i9;
import 'entry_tag.dart' as _i10;
import 'favorite_contact.dart' as _i11;
import 'goal.dart' as _i12;
import 'gratitude_entry.dart' as _i13;
import 'greetings/greeting.dart' as _i14;
import 'insight.dart' as _i15;
import 'journal_entry.dart' as _i16;
import 'mood_distribution.dart' as _i17;
import 'mood_pattern.dart' as _i18;
import 'tag.dart' as _i19;
import 'time_of_day_analysis.dart' as _i20;
import 'user_profile.dart' as _i21;
import 'user_settings.dart' as _i22;
import 'user_stats.dart' as _i23;
import 'voice_entry.dart' as _i24;
import 'voice_entry_with_tags.dart' as _i25;
import 'weekly_analytics.dart' as _i26;
import 'wellness_goal.dart' as _i27;
import 'package:resonate_server_server/src/generated/mood_pattern.dart' as _i28;
import 'package:resonate_server_server/src/generated/insight.dart' as _i29;
import 'package:resonate_server_server/src/generated/tag.dart' as _i30;
import 'package:resonate_server_server/src/generated/voice_entry_with_tags.dart'
    as _i31;
import 'package:resonate_server_server/src/generated/journal_entry.dart'
    as _i32;
import 'package:resonate_server_server/src/generated/gratitude_entry.dart'
    as _i33;
import 'package:resonate_server_server/src/generated/wellness_goal.dart'
    as _i34;
import 'package:resonate_server_server/src/generated/favorite_contact.dart'
    as _i35;
export 'analysis_result.dart';
export 'calendar_day_entry.dart';
export 'calendar_month.dart';
export 'contact.dart';
export 'daily_mood_data.dart';
export 'entry_tag.dart';
export 'favorite_contact.dart';
export 'goal.dart';
export 'gratitude_entry.dart';
export 'greetings/greeting.dart';
export 'insight.dart';
export 'journal_entry.dart';
export 'mood_distribution.dart';
export 'mood_pattern.dart';
export 'tag.dart';
export 'time_of_day_analysis.dart';
export 'user_profile.dart';
export 'user_settings.dart';
export 'user_stats.dart';
export 'voice_entry.dart';
export 'voice_entry_with_tags.dart';
export 'weekly_analytics.dart';
export 'wellness_goal.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'contacts',
      dartName: 'Contact',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'contacts_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'relationship',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'emoji',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'isPrimary',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'contacts_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'entry_tags',
      dartName: 'EntryTag',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'entry_tags_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'voiceEntryId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'tagId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'entry_tags_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'entry_tag_entry_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'voiceEntryId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'entry_tag_tag_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'tagId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'favorite_contacts',
      dartName: 'FavoriteContact',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'favorite_contacts_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'emoji',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'phone',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'favorite_contacts_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'contact_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'goals',
      dartName: 'Goal',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'goals_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'category',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'targetDate',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'isCompleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: true,
          dartType: 'bool?',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'goals_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'gratitude_entries',
      dartName: 'GratitudeEntry',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'gratitude_entries_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'items',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'gratitude_entries_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'insights',
      dartName: 'Insight',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'insights_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'insightText',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'insightType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'generatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntryIds',
          columnType: _i2.ColumnType.json,
          isNullable: true,
          dartType: 'List<int>?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'insights_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'insight_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'journal_entries',
      dartName: 'JournalEntry',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'journal_entries_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'content',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'prompt',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'moodAtTime',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'journal_entries_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'mood_patterns',
      dartName: 'MoodPattern',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'mood_patterns_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'patternType',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'description',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'confidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'detectedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'mood_patterns_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'pattern_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'tags',
      dartName: 'Tag',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'tags_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'color',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'usageCount',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'tags_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'tag_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_profiles',
      dartName: 'UserProfile',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_profiles_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'authUserId',
          columnType: _i2.ColumnType.uuid,
          isNullable: false,
          dartType: 'UuidValue',
        ),
        _i2.ColumnDefinition(
          name: 'displayName',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'avatarUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastLoginAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'totalCheckins',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'currentStreak',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'longestStreak',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'averageMood',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_profiles_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_profile_auth_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'authUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_settings',
      dartName: 'UserSettings',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reminderHour',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reminderMinute',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'reminderEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'darkMode',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'uiLanguage',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'voiceLanguage',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'privacyLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'notificationsEnabled',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'settings_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'voice_entries',
      dartName: 'VoiceEntry',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'voice_entries_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'recordedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'language',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'audioUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'durationSeconds',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'pitchMean',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'pitchStd',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'energyMean',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'tempo',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'silenceRatio',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'transcript',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'emotionKeywords',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'sentimentScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'detectedEmotions',
          columnType: _i2.ColumnType.json,
          isNullable: false,
          dartType: 'List<String>',
        ),
        _i2.ColumnDefinition(
          name: 'topicContext',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'acousticMoodScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'semanticMoodScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'finalMoodScore',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'moodLabel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'confidence',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'signalAlignment',
          columnType: _i2.ColumnType.doublePrecision,
          isNullable: false,
          dartType: 'double',
        ),
        _i2.ColumnDefinition(
          name: 'note',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'privacyLevel',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'voice_entries_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'voice_entry_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'voice_entry_recorded_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recordedAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'wellness_goals',
      dartName: 'WellnessGoal',
      schema: 'public',
      module: 'resonate_server',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'wellness_goals_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userProfileId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'emoji',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isCompleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
        ),
        _i2.ColumnDefinition(
          name: 'completedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'wellness_goals_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'goal_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userProfileId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.AnalysisResult) {
      return _i5.AnalysisResult.fromJson(data) as T;
    }
    if (t == _i6.CalendarDayEntry) {
      return _i6.CalendarDayEntry.fromJson(data) as T;
    }
    if (t == _i7.CalendarMonth) {
      return _i7.CalendarMonth.fromJson(data) as T;
    }
    if (t == _i8.Contact) {
      return _i8.Contact.fromJson(data) as T;
    }
    if (t == _i9.DailyMoodData) {
      return _i9.DailyMoodData.fromJson(data) as T;
    }
    if (t == _i10.EntryTag) {
      return _i10.EntryTag.fromJson(data) as T;
    }
    if (t == _i11.FavoriteContact) {
      return _i11.FavoriteContact.fromJson(data) as T;
    }
    if (t == _i12.Goal) {
      return _i12.Goal.fromJson(data) as T;
    }
    if (t == _i13.GratitudeEntry) {
      return _i13.GratitudeEntry.fromJson(data) as T;
    }
    if (t == _i14.Greeting) {
      return _i14.Greeting.fromJson(data) as T;
    }
    if (t == _i15.Insight) {
      return _i15.Insight.fromJson(data) as T;
    }
    if (t == _i16.JournalEntry) {
      return _i16.JournalEntry.fromJson(data) as T;
    }
    if (t == _i17.MoodDistribution) {
      return _i17.MoodDistribution.fromJson(data) as T;
    }
    if (t == _i18.MoodPattern) {
      return _i18.MoodPattern.fromJson(data) as T;
    }
    if (t == _i19.Tag) {
      return _i19.Tag.fromJson(data) as T;
    }
    if (t == _i20.TimeOfDayAnalysis) {
      return _i20.TimeOfDayAnalysis.fromJson(data) as T;
    }
    if (t == _i21.UserProfile) {
      return _i21.UserProfile.fromJson(data) as T;
    }
    if (t == _i22.UserSettings) {
      return _i22.UserSettings.fromJson(data) as T;
    }
    if (t == _i23.UserStats) {
      return _i23.UserStats.fromJson(data) as T;
    }
    if (t == _i24.VoiceEntry) {
      return _i24.VoiceEntry.fromJson(data) as T;
    }
    if (t == _i25.VoiceEntryWithTags) {
      return _i25.VoiceEntryWithTags.fromJson(data) as T;
    }
    if (t == _i26.WeeklyAnalytics) {
      return _i26.WeeklyAnalytics.fromJson(data) as T;
    }
    if (t == _i27.WellnessGoal) {
      return _i27.WellnessGoal.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.AnalysisResult?>()) {
      return (data != null ? _i5.AnalysisResult.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.CalendarDayEntry?>()) {
      return (data != null ? _i6.CalendarDayEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.CalendarMonth?>()) {
      return (data != null ? _i7.CalendarMonth.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Contact?>()) {
      return (data != null ? _i8.Contact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.DailyMoodData?>()) {
      return (data != null ? _i9.DailyMoodData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.EntryTag?>()) {
      return (data != null ? _i10.EntryTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.FavoriteContact?>()) {
      return (data != null ? _i11.FavoriteContact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Goal?>()) {
      return (data != null ? _i12.Goal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.GratitudeEntry?>()) {
      return (data != null ? _i13.GratitudeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.Greeting?>()) {
      return (data != null ? _i14.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.Insight?>()) {
      return (data != null ? _i15.Insight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.JournalEntry?>()) {
      return (data != null ? _i16.JournalEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.MoodDistribution?>()) {
      return (data != null ? _i17.MoodDistribution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.MoodPattern?>()) {
      return (data != null ? _i18.MoodPattern.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Tag?>()) {
      return (data != null ? _i19.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.TimeOfDayAnalysis?>()) {
      return (data != null ? _i20.TimeOfDayAnalysis.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.UserProfile?>()) {
      return (data != null ? _i21.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.UserSettings?>()) {
      return (data != null ? _i22.UserSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.UserStats?>()) {
      return (data != null ? _i23.UserStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.VoiceEntry?>()) {
      return (data != null ? _i24.VoiceEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.VoiceEntryWithTags?>()) {
      return (data != null ? _i25.VoiceEntryWithTags.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.WeeklyAnalytics?>()) {
      return (data != null ? _i26.WeeklyAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.WellnessGoal?>()) {
      return (data != null ? _i27.WellnessGoal.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<String>(e)).toList()
              : null)
          as T;
    }
    if (t == Map<int, _i6.CalendarDayEntry>) {
      return Map.fromEntries(
            (data as List).map(
              (e) => MapEntry(
                deserialize<int>(e['k']),
                deserialize<_i6.CalendarDayEntry>(e['v']),
              ),
            ),
          )
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == _i1.getType<List<int>?>()) {
      return (data != null
              ? (data as List).map((e) => deserialize<int>(e)).toList()
              : null)
          as T;
    }
    if (t == List<_i19.Tag>) {
      return (data as List).map((e) => deserialize<_i19.Tag>(e)).toList() as T;
    }
    if (t == List<_i9.DailyMoodData>) {
      return (data as List)
              .map((e) => deserialize<_i9.DailyMoodData>(e))
              .toList()
          as T;
    }
    if (t == List<_i28.MoodPattern>) {
      return (data as List)
              .map((e) => deserialize<_i28.MoodPattern>(e))
              .toList()
          as T;
    }
    if (t == List<_i29.Insight>) {
      return (data as List).map((e) => deserialize<_i29.Insight>(e)).toList()
          as T;
    }
    if (t == List<_i30.Tag>) {
      return (data as List).map((e) => deserialize<_i30.Tag>(e)).toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
            (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
          )
          as T;
    }
    if (t == List<_i31.VoiceEntryWithTags>) {
      return (data as List)
              .map((e) => deserialize<_i31.VoiceEntryWithTags>(e))
              .toList()
          as T;
    }
    if (t == List<_i32.JournalEntry>) {
      return (data as List)
              .map((e) => deserialize<_i32.JournalEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.GratitudeEntry>) {
      return (data as List)
              .map((e) => deserialize<_i33.GratitudeEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i34.WellnessGoal>) {
      return (data as List)
              .map((e) => deserialize<_i34.WellnessGoal>(e))
              .toList()
          as T;
    }
    if (t == List<_i35.FavoriteContact>) {
      return (data as List)
              .map((e) => deserialize<_i35.FavoriteContact>(e))
              .toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.AnalysisResult => 'AnalysisResult',
      _i6.CalendarDayEntry => 'CalendarDayEntry',
      _i7.CalendarMonth => 'CalendarMonth',
      _i8.Contact => 'Contact',
      _i9.DailyMoodData => 'DailyMoodData',
      _i10.EntryTag => 'EntryTag',
      _i11.FavoriteContact => 'FavoriteContact',
      _i12.Goal => 'Goal',
      _i13.GratitudeEntry => 'GratitudeEntry',
      _i14.Greeting => 'Greeting',
      _i15.Insight => 'Insight',
      _i16.JournalEntry => 'JournalEntry',
      _i17.MoodDistribution => 'MoodDistribution',
      _i18.MoodPattern => 'MoodPattern',
      _i19.Tag => 'Tag',
      _i20.TimeOfDayAnalysis => 'TimeOfDayAnalysis',
      _i21.UserProfile => 'UserProfile',
      _i22.UserSettings => 'UserSettings',
      _i23.UserStats => 'UserStats',
      _i24.VoiceEntry => 'VoiceEntry',
      _i25.VoiceEntryWithTags => 'VoiceEntryWithTags',
      _i26.WeeklyAnalytics => 'WeeklyAnalytics',
      _i27.WellnessGoal => 'WellnessGoal',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'resonate_server.',
        '',
      );
    }

    switch (data) {
      case _i5.AnalysisResult():
        return 'AnalysisResult';
      case _i6.CalendarDayEntry():
        return 'CalendarDayEntry';
      case _i7.CalendarMonth():
        return 'CalendarMonth';
      case _i8.Contact():
        return 'Contact';
      case _i9.DailyMoodData():
        return 'DailyMoodData';
      case _i10.EntryTag():
        return 'EntryTag';
      case _i11.FavoriteContact():
        return 'FavoriteContact';
      case _i12.Goal():
        return 'Goal';
      case _i13.GratitudeEntry():
        return 'GratitudeEntry';
      case _i14.Greeting():
        return 'Greeting';
      case _i15.Insight():
        return 'Insight';
      case _i16.JournalEntry():
        return 'JournalEntry';
      case _i17.MoodDistribution():
        return 'MoodDistribution';
      case _i18.MoodPattern():
        return 'MoodPattern';
      case _i19.Tag():
        return 'Tag';
      case _i20.TimeOfDayAnalysis():
        return 'TimeOfDayAnalysis';
      case _i21.UserProfile():
        return 'UserProfile';
      case _i22.UserSettings():
        return 'UserSettings';
      case _i23.UserStats():
        return 'UserStats';
      case _i24.VoiceEntry():
        return 'VoiceEntry';
      case _i25.VoiceEntryWithTags():
        return 'VoiceEntryWithTags';
      case _i26.WeeklyAnalytics():
        return 'WeeklyAnalytics';
      case _i27.WellnessGoal():
        return 'WellnessGoal';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AnalysisResult') {
      return deserialize<_i5.AnalysisResult>(data['data']);
    }
    if (dataClassName == 'CalendarDayEntry') {
      return deserialize<_i6.CalendarDayEntry>(data['data']);
    }
    if (dataClassName == 'CalendarMonth') {
      return deserialize<_i7.CalendarMonth>(data['data']);
    }
    if (dataClassName == 'Contact') {
      return deserialize<_i8.Contact>(data['data']);
    }
    if (dataClassName == 'DailyMoodData') {
      return deserialize<_i9.DailyMoodData>(data['data']);
    }
    if (dataClassName == 'EntryTag') {
      return deserialize<_i10.EntryTag>(data['data']);
    }
    if (dataClassName == 'FavoriteContact') {
      return deserialize<_i11.FavoriteContact>(data['data']);
    }
    if (dataClassName == 'Goal') {
      return deserialize<_i12.Goal>(data['data']);
    }
    if (dataClassName == 'GratitudeEntry') {
      return deserialize<_i13.GratitudeEntry>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i14.Greeting>(data['data']);
    }
    if (dataClassName == 'Insight') {
      return deserialize<_i15.Insight>(data['data']);
    }
    if (dataClassName == 'JournalEntry') {
      return deserialize<_i16.JournalEntry>(data['data']);
    }
    if (dataClassName == 'MoodDistribution') {
      return deserialize<_i17.MoodDistribution>(data['data']);
    }
    if (dataClassName == 'MoodPattern') {
      return deserialize<_i18.MoodPattern>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i19.Tag>(data['data']);
    }
    if (dataClassName == 'TimeOfDayAnalysis') {
      return deserialize<_i20.TimeOfDayAnalysis>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i21.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserSettings') {
      return deserialize<_i22.UserSettings>(data['data']);
    }
    if (dataClassName == 'UserStats') {
      return deserialize<_i23.UserStats>(data['data']);
    }
    if (dataClassName == 'VoiceEntry') {
      return deserialize<_i24.VoiceEntry>(data['data']);
    }
    if (dataClassName == 'VoiceEntryWithTags') {
      return deserialize<_i25.VoiceEntryWithTags>(data['data']);
    }
    if (dataClassName == 'WeeklyAnalytics') {
      return deserialize<_i26.WeeklyAnalytics>(data['data']);
    }
    if (dataClassName == 'WellnessGoal') {
      return deserialize<_i27.WellnessGoal>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i8.Contact:
        return _i8.Contact.t;
      case _i10.EntryTag:
        return _i10.EntryTag.t;
      case _i11.FavoriteContact:
        return _i11.FavoriteContact.t;
      case _i12.Goal:
        return _i12.Goal.t;
      case _i13.GratitudeEntry:
        return _i13.GratitudeEntry.t;
      case _i15.Insight:
        return _i15.Insight.t;
      case _i16.JournalEntry:
        return _i16.JournalEntry.t;
      case _i18.MoodPattern:
        return _i18.MoodPattern.t;
      case _i19.Tag:
        return _i19.Tag.t;
      case _i21.UserProfile:
        return _i21.UserProfile.t;
      case _i22.UserSettings:
        return _i22.UserSettings.t;
      case _i24.VoiceEntry:
        return _i24.VoiceEntry.t;
      case _i27.WellnessGoal:
        return _i27.WellnessGoal.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'resonate_server';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
