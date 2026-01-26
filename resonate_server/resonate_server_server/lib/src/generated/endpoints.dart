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
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/analytics_endpoint.dart' as _i4;
import '../endpoints/insight_endpoint.dart' as _i5;
import '../endpoints/settings_endpoint.dart' as _i6;
import '../endpoints/tag_endpoint.dart' as _i7;
import '../endpoints/user_profile_endpoint.dart' as _i8;
import '../endpoints/voice_entry_endpoint.dart' as _i9;
import '../endpoints/wellness_endpoint.dart' as _i10;
import '../greetings/greeting_endpoint.dart' as _i11;
import 'package:resonate_server_server/src/generated/user_settings.dart'
    as _i12;
import 'dart:typed_data' as _i13;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i14;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i15;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'analytics': _i4.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'insight': _i5.InsightEndpoint()
        ..initialize(
          server,
          'insight',
          null,
        ),
      'settings': _i6.SettingsEndpoint()
        ..initialize(
          server,
          'settings',
          null,
        ),
      'tag': _i7.TagEndpoint()
        ..initialize(
          server,
          'tag',
          null,
        ),
      'userProfile': _i8.UserProfileEndpoint()
        ..initialize(
          server,
          'userProfile',
          null,
        ),
      'voiceEntry': _i9.VoiceEntryEndpoint()
        ..initialize(
          server,
          'voiceEntry',
          null,
        ),
      'wellness': _i10.WellnessEndpoint()
        ..initialize(
          server,
          'wellness',
          null,
        ),
      'greeting': _i11.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['analytics'] = _i1.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'getWeeklyAnalytics': _i1.MethodConnector(
          name: 'getWeeklyAnalytics',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i4.AnalyticsEndpoint)
                  .getWeeklyAnalytics(session),
        ),
        'getMoodDistribution': _i1.MethodConnector(
          name: 'getMoodDistribution',
          params: {
            'period': _i1.ParameterDescription(
              name: 'period',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i4.AnalyticsEndpoint)
                  .getMoodDistribution(
                    session,
                    params['period'],
                  ),
        ),
        'getTimeOfDayAnalysis': _i1.MethodConnector(
          name: 'getTimeOfDayAnalysis',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i4.AnalyticsEndpoint)
                  .getTimeOfDayAnalysis(session),
        ),
        'getPatterns': _i1.MethodConnector(
          name: 'getPatterns',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _i4.AnalyticsEndpoint)
                  .getPatterns(session),
        ),
      },
    );
    connectors['insight'] = _i1.EndpointConnector(
      name: 'insight',
      endpoint: endpoints['insight']!,
      methodConnectors: {
        'getInsights': _i1.MethodConnector(
          name: 'getInsights',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['insight'] as _i5.InsightEndpoint).getInsights(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getUnreadCount': _i1.MethodConnector(
          name: 'getUnreadCount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['insight'] as _i5.InsightEndpoint)
                  .getUnreadCount(session),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['insight'] as _i5.InsightEndpoint).markAsRead(
                    session,
                    params['id'],
                  ),
        ),
        'generateInsight': _i1.MethodConnector(
          name: 'generateInsight',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['insight'] as _i5.InsightEndpoint)
                  .generateInsight(session),
        ),
      },
    );
    connectors['settings'] = _i1.EndpointConnector(
      name: 'settings',
      endpoint: endpoints['settings']!,
      methodConnectors: {
        'getSettings': _i1.MethodConnector(
          name: 'getSettings',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i6.SettingsEndpoint)
                  .getSettings(session),
        ),
        'updateSettings': _i1.MethodConnector(
          name: 'updateSettings',
          params: {
            'settings': _i1.ParameterDescription(
              name: 'settings',
              type: _i1.getType<_i12.UserSettings>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i6.SettingsEndpoint)
                  .updateSettings(
                    session,
                    params['settings'],
                  ),
        ),
        'toggleDarkMode': _i1.MethodConnector(
          name: 'toggleDarkMode',
          params: {
            'enabled': _i1.ParameterDescription(
              name: 'enabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i6.SettingsEndpoint)
                  .toggleDarkMode(
                    session,
                    params['enabled'],
                  ),
        ),
        'toggleNotifications': _i1.MethodConnector(
          name: 'toggleNotifications',
          params: {
            'enabled': _i1.ParameterDescription(
              name: 'enabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['settings'] as _i6.SettingsEndpoint)
                  .toggleNotifications(
                    session,
                    params['enabled'],
                  ),
        ),
      },
    );
    connectors['tag'] = _i1.EndpointConnector(
      name: 'tag',
      endpoint: endpoints['tag']!,
      methodConnectors: {
        'getTags': _i1.MethodConnector(
          name: 'getTags',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tag'] as _i7.TagEndpoint).getTags(session),
        ),
        'createTag': _i1.MethodConnector(
          name: 'createTag',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'color': _i1.ParameterDescription(
              name: 'color',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tag'] as _i7.TagEndpoint).createTag(
                session,
                params['name'],
                params['color'],
              ),
        ),
        'deleteTag': _i1.MethodConnector(
          name: 'deleteTag',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tag'] as _i7.TagEndpoint).deleteTag(
                session,
                params['id'],
              ),
        ),
        'addTagToEntry': _i1.MethodConnector(
          name: 'addTagToEntry',
          params: {
            'entryId': _i1.ParameterDescription(
              name: 'entryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'tagId': _i1.ParameterDescription(
              name: 'tagId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['tag'] as _i7.TagEndpoint).addTagToEntry(
                session,
                params['entryId'],
                params['tagId'],
              ),
        ),
      },
    );
    connectors['userProfile'] = _i1.EndpointConnector(
      name: 'userProfile',
      endpoint: endpoints['userProfile']!,
      methodConnectors: {
        'getProfile': _i1.MethodConnector(
          name: 'getProfile',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i8.UserProfileEndpoint)
                  .getProfile(session),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'displayName': _i1.ParameterDescription(
              name: 'displayName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'avatarUrl': _i1.ParameterDescription(
              name: 'avatarUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i8.UserProfileEndpoint)
                  .updateProfile(
                    session,
                    displayName: params['displayName'],
                    avatarUrl: params['avatarUrl'],
                  ),
        ),
        'getStats': _i1.MethodConnector(
          name: 'getStats',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i8.UserProfileEndpoint)
                  .getStats(session),
        ),
        'deleteAccount': _i1.MethodConnector(
          name: 'deleteAccount',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['userProfile'] as _i8.UserProfileEndpoint)
                  .deleteAccount(session),
        ),
      },
    );
    connectors['voiceEntry'] = _i1.EndpointConnector(
      name: 'voiceEntry',
      endpoint: endpoints['voiceEntry']!,
      methodConnectors: {
        'uploadAndAnalyze': _i1.MethodConnector(
          name: 'uploadAndAnalyze',
          params: {
            'audioData': _i1.ParameterDescription(
              name: 'audioData',
              type: _i1.getType<_i13.ByteData>(),
              nullable: false,
            ),
            'language': _i1.ParameterDescription(
              name: 'language',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'privacyLevel': _i1.ParameterDescription(
              name: 'privacyLevel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint)
                  .uploadAndAnalyze(
                    session,
                    params['audioData'],
                    params['language'],
                    params['privacyLevel'],
                  ),
        ),
        'getEntries': _i1.MethodConnector(
          name: 'getEntries',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint)
                  .getEntries(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'getEntry': _i1.MethodConnector(
          name: 'getEntry',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint).getEntry(
                    session,
                    params['id'],
                  ),
        ),
        'getTodayEntry': _i1.MethodConnector(
          name: 'getTodayEntry',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint)
                  .getTodayEntry(session),
        ),
        'getCalendarMonth': _i1.MethodConnector(
          name: 'getCalendarMonth',
          params: {
            'year': _i1.ParameterDescription(
              name: 'year',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'month': _i1.ParameterDescription(
              name: 'month',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint)
                  .getCalendarMonth(
                    session,
                    params['year'],
                    params['month'],
                  ),
        ),
        'deleteEntry': _i1.MethodConnector(
          name: 'deleteEntry',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['voiceEntry'] as _i9.VoiceEntryEndpoint)
                  .deleteEntry(
                    session,
                    params['id'],
                  ),
        ),
      },
    );
    connectors['wellness'] = _i1.EndpointConnector(
      name: 'wellness',
      endpoint: endpoints['wellness']!,
      methodConnectors: {
        'getJournals': _i1.MethodConnector(
          name: 'getJournals',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['wellness'] as _i10.WellnessEndpoint).getJournals(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'createJournal': _i1.MethodConnector(
          name: 'createJournal',
          params: {
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'prompt': _i1.ParameterDescription(
              name: 'prompt',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'moodAtTime': _i1.ParameterDescription(
              name: 'moodAtTime',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .createJournal(
                    session,
                    params['content'],
                    params['prompt'],
                    moodAtTime: params['moodAtTime'],
                  ),
        ),
        'getGratitudes': _i1.MethodConnector(
          name: 'getGratitudes',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .getGratitudes(
                    session,
                    limit: params['limit'],
                  ),
        ),
        'createGratitude': _i1.MethodConnector(
          name: 'createGratitude',
          params: {
            'items': _i1.ParameterDescription(
              name: 'items',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .createGratitude(
                    session,
                    params['items'],
                  ),
        ),
        'getGoals': _i1.MethodConnector(
          name: 'getGoals',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .getGoals(session),
        ),
        'createGoal': _i1.MethodConnector(
          name: 'createGoal',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'emoji': _i1.ParameterDescription(
              name: 'emoji',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['wellness'] as _i10.WellnessEndpoint).createGoal(
                    session,
                    params['title'],
                    params['emoji'],
                  ),
        ),
        'toggleGoal': _i1.MethodConnector(
          name: 'toggleGoal',
          params: {
            'id': _i1.ParameterDescription(
              name: 'id',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['wellness'] as _i10.WellnessEndpoint).toggleGoal(
                    session,
                    params['id'],
                  ),
        ),
        'getContacts': _i1.MethodConnector(
          name: 'getContacts',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .getContacts(session),
        ),
        'createContact': _i1.MethodConnector(
          name: 'createContact',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'emoji': _i1.ParameterDescription(
              name: 'emoji',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'phone': _i1.ParameterDescription(
              name: 'phone',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['wellness'] as _i10.WellnessEndpoint)
                  .createContact(
                    session,
                    params['name'],
                    params['emoji'],
                    params['type'],
                    phone: params['phone'],
                  ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i11.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i14.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i15.Endpoints()
      ..initializeEndpoints(server);
  }
}
