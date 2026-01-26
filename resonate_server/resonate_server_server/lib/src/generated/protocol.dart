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
import 'daily_mood_data.dart' as _i8;
import 'entry_tag.dart' as _i9;
import 'favorite_contact.dart' as _i10;
import 'gratitude_entry.dart' as _i11;
import 'greetings/greeting.dart' as _i12;
import 'insight.dart' as _i13;
import 'journal_entry.dart' as _i14;
import 'mood_distribution.dart' as _i15;
import 'mood_pattern.dart' as _i16;
import 'tag.dart' as _i17;
import 'time_of_day_analysis.dart' as _i18;
import 'user_profile.dart' as _i19;
import 'user_settings.dart' as _i20;
import 'user_stats.dart' as _i21;
import 'voice_entry.dart' as _i22;
import 'voice_entry_with_tags.dart' as _i23;
import 'weekly_analytics.dart' as _i24;
import 'wellness_goal.dart' as _i25;
import 'package:resonate_server_server/src/generated/mood_pattern.dart' as _i26;
import 'package:resonate_server_server/src/generated/insight.dart' as _i27;
import 'package:resonate_server_server/src/generated/tag.dart' as _i28;
import 'package:resonate_server_server/src/generated/voice_entry_with_tags.dart'
    as _i29;
import 'package:resonate_server_server/src/generated/journal_entry.dart'
    as _i30;
import 'package:resonate_server_server/src/generated/gratitude_entry.dart'
    as _i31;
import 'package:resonate_server_server/src/generated/wellness_goal.dart'
    as _i32;
import 'package:resonate_server_server/src/generated/favorite_contact.dart'
    as _i33;
export 'analysis_result.dart';
export 'calendar_day_entry.dart';
export 'calendar_month.dart';
export 'daily_mood_data.dart';
export 'entry_tag.dart';
export 'favorite_contact.dart';
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
        _i2.IndexDefinition(
          indexName: 'gratitude_user_idx',
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
        _i2.IndexDefinition(
          indexName: 'journal_user_idx',
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
    if (t == _i8.DailyMoodData) {
      return _i8.DailyMoodData.fromJson(data) as T;
    }
    if (t == _i9.EntryTag) {
      return _i9.EntryTag.fromJson(data) as T;
    }
    if (t == _i10.FavoriteContact) {
      return _i10.FavoriteContact.fromJson(data) as T;
    }
    if (t == _i11.GratitudeEntry) {
      return _i11.GratitudeEntry.fromJson(data) as T;
    }
    if (t == _i12.Greeting) {
      return _i12.Greeting.fromJson(data) as T;
    }
    if (t == _i13.Insight) {
      return _i13.Insight.fromJson(data) as T;
    }
    if (t == _i14.JournalEntry) {
      return _i14.JournalEntry.fromJson(data) as T;
    }
    if (t == _i15.MoodDistribution) {
      return _i15.MoodDistribution.fromJson(data) as T;
    }
    if (t == _i16.MoodPattern) {
      return _i16.MoodPattern.fromJson(data) as T;
    }
    if (t == _i17.Tag) {
      return _i17.Tag.fromJson(data) as T;
    }
    if (t == _i18.TimeOfDayAnalysis) {
      return _i18.TimeOfDayAnalysis.fromJson(data) as T;
    }
    if (t == _i19.UserProfile) {
      return _i19.UserProfile.fromJson(data) as T;
    }
    if (t == _i20.UserSettings) {
      return _i20.UserSettings.fromJson(data) as T;
    }
    if (t == _i21.UserStats) {
      return _i21.UserStats.fromJson(data) as T;
    }
    if (t == _i22.VoiceEntry) {
      return _i22.VoiceEntry.fromJson(data) as T;
    }
    if (t == _i23.VoiceEntryWithTags) {
      return _i23.VoiceEntryWithTags.fromJson(data) as T;
    }
    if (t == _i24.WeeklyAnalytics) {
      return _i24.WeeklyAnalytics.fromJson(data) as T;
    }
    if (t == _i25.WellnessGoal) {
      return _i25.WellnessGoal.fromJson(data) as T;
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
    if (t == _i1.getType<_i8.DailyMoodData?>()) {
      return (data != null ? _i8.DailyMoodData.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.EntryTag?>()) {
      return (data != null ? _i9.EntryTag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.FavoriteContact?>()) {
      return (data != null ? _i10.FavoriteContact.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.GratitudeEntry?>()) {
      return (data != null ? _i11.GratitudeEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.Greeting?>()) {
      return (data != null ? _i12.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.Insight?>()) {
      return (data != null ? _i13.Insight.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.JournalEntry?>()) {
      return (data != null ? _i14.JournalEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.MoodDistribution?>()) {
      return (data != null ? _i15.MoodDistribution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.MoodPattern?>()) {
      return (data != null ? _i16.MoodPattern.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.Tag?>()) {
      return (data != null ? _i17.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.TimeOfDayAnalysis?>()) {
      return (data != null ? _i18.TimeOfDayAnalysis.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.UserProfile?>()) {
      return (data != null ? _i19.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.UserSettings?>()) {
      return (data != null ? _i20.UserSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.UserStats?>()) {
      return (data != null ? _i21.UserStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i22.VoiceEntry?>()) {
      return (data != null ? _i22.VoiceEntry.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.VoiceEntryWithTags?>()) {
      return (data != null ? _i23.VoiceEntryWithTags.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i24.WeeklyAnalytics?>()) {
      return (data != null ? _i24.WeeklyAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.WellnessGoal?>()) {
      return (data != null ? _i25.WellnessGoal.fromJson(data) : null) as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
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
    if (t == List<_i17.Tag>) {
      return (data as List).map((e) => deserialize<_i17.Tag>(e)).toList() as T;
    }
    if (t == List<_i8.DailyMoodData>) {
      return (data as List)
              .map((e) => deserialize<_i8.DailyMoodData>(e))
              .toList()
          as T;
    }
    if (t == List<_i26.MoodPattern>) {
      return (data as List)
              .map((e) => deserialize<_i26.MoodPattern>(e))
              .toList()
          as T;
    }
    if (t == List<_i27.Insight>) {
      return (data as List).map((e) => deserialize<_i27.Insight>(e)).toList()
          as T;
    }
    if (t == List<_i28.Tag>) {
      return (data as List).map((e) => deserialize<_i28.Tag>(e)).toList() as T;
    }
    if (t == List<_i29.VoiceEntryWithTags>) {
      return (data as List)
              .map((e) => deserialize<_i29.VoiceEntryWithTags>(e))
              .toList()
          as T;
    }
    if (t == List<_i30.JournalEntry>) {
      return (data as List)
              .map((e) => deserialize<_i30.JournalEntry>(e))
              .toList()
          as T;
    }
    if (t == List<_i31.GratitudeEntry>) {
      return (data as List)
              .map((e) => deserialize<_i31.GratitudeEntry>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i32.WellnessGoal>) {
      return (data as List)
              .map((e) => deserialize<_i32.WellnessGoal>(e))
              .toList()
          as T;
    }
    if (t == List<_i33.FavoriteContact>) {
      return (data as List)
              .map((e) => deserialize<_i33.FavoriteContact>(e))
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
      _i8.DailyMoodData => 'DailyMoodData',
      _i9.EntryTag => 'EntryTag',
      _i10.FavoriteContact => 'FavoriteContact',
      _i11.GratitudeEntry => 'GratitudeEntry',
      _i12.Greeting => 'Greeting',
      _i13.Insight => 'Insight',
      _i14.JournalEntry => 'JournalEntry',
      _i15.MoodDistribution => 'MoodDistribution',
      _i16.MoodPattern => 'MoodPattern',
      _i17.Tag => 'Tag',
      _i18.TimeOfDayAnalysis => 'TimeOfDayAnalysis',
      _i19.UserProfile => 'UserProfile',
      _i20.UserSettings => 'UserSettings',
      _i21.UserStats => 'UserStats',
      _i22.VoiceEntry => 'VoiceEntry',
      _i23.VoiceEntryWithTags => 'VoiceEntryWithTags',
      _i24.WeeklyAnalytics => 'WeeklyAnalytics',
      _i25.WellnessGoal => 'WellnessGoal',
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
      case _i8.DailyMoodData():
        return 'DailyMoodData';
      case _i9.EntryTag():
        return 'EntryTag';
      case _i10.FavoriteContact():
        return 'FavoriteContact';
      case _i11.GratitudeEntry():
        return 'GratitudeEntry';
      case _i12.Greeting():
        return 'Greeting';
      case _i13.Insight():
        return 'Insight';
      case _i14.JournalEntry():
        return 'JournalEntry';
      case _i15.MoodDistribution():
        return 'MoodDistribution';
      case _i16.MoodPattern():
        return 'MoodPattern';
      case _i17.Tag():
        return 'Tag';
      case _i18.TimeOfDayAnalysis():
        return 'TimeOfDayAnalysis';
      case _i19.UserProfile():
        return 'UserProfile';
      case _i20.UserSettings():
        return 'UserSettings';
      case _i21.UserStats():
        return 'UserStats';
      case _i22.VoiceEntry():
        return 'VoiceEntry';
      case _i23.VoiceEntryWithTags():
        return 'VoiceEntryWithTags';
      case _i24.WeeklyAnalytics():
        return 'WeeklyAnalytics';
      case _i25.WellnessGoal():
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
    if (dataClassName == 'DailyMoodData') {
      return deserialize<_i8.DailyMoodData>(data['data']);
    }
    if (dataClassName == 'EntryTag') {
      return deserialize<_i9.EntryTag>(data['data']);
    }
    if (dataClassName == 'FavoriteContact') {
      return deserialize<_i10.FavoriteContact>(data['data']);
    }
    if (dataClassName == 'GratitudeEntry') {
      return deserialize<_i11.GratitudeEntry>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i12.Greeting>(data['data']);
    }
    if (dataClassName == 'Insight') {
      return deserialize<_i13.Insight>(data['data']);
    }
    if (dataClassName == 'JournalEntry') {
      return deserialize<_i14.JournalEntry>(data['data']);
    }
    if (dataClassName == 'MoodDistribution') {
      return deserialize<_i15.MoodDistribution>(data['data']);
    }
    if (dataClassName == 'MoodPattern') {
      return deserialize<_i16.MoodPattern>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i17.Tag>(data['data']);
    }
    if (dataClassName == 'TimeOfDayAnalysis') {
      return deserialize<_i18.TimeOfDayAnalysis>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i19.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserSettings') {
      return deserialize<_i20.UserSettings>(data['data']);
    }
    if (dataClassName == 'UserStats') {
      return deserialize<_i21.UserStats>(data['data']);
    }
    if (dataClassName == 'VoiceEntry') {
      return deserialize<_i22.VoiceEntry>(data['data']);
    }
    if (dataClassName == 'VoiceEntryWithTags') {
      return deserialize<_i23.VoiceEntryWithTags>(data['data']);
    }
    if (dataClassName == 'WeeklyAnalytics') {
      return deserialize<_i24.WeeklyAnalytics>(data['data']);
    }
    if (dataClassName == 'WellnessGoal') {
      return deserialize<_i25.WellnessGoal>(data['data']);
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
      case _i9.EntryTag:
        return _i9.EntryTag.t;
      case _i10.FavoriteContact:
        return _i10.FavoriteContact.t;
      case _i11.GratitudeEntry:
        return _i11.GratitudeEntry.t;
      case _i13.Insight:
        return _i13.Insight.t;
      case _i14.JournalEntry:
        return _i14.JournalEntry.t;
      case _i16.MoodPattern:
        return _i16.MoodPattern.t;
      case _i17.Tag:
        return _i17.Tag.t;
      case _i19.UserProfile:
        return _i19.UserProfile.t;
      case _i20.UserSettings:
        return _i20.UserSettings.t;
      case _i22.VoiceEntry:
        return _i22.VoiceEntry.t;
      case _i25.WellnessGoal:
        return _i25.WellnessGoal.t;
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
