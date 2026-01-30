import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:resonate_server_client/resonate_server_client.dart';

/// API service for connecting to the Serverpod backend.
/// 
/// This service provides a singleton instance of the Serverpod client
/// and handles all communication with the backend server.
/// 
/// Uses Serverpod 3 FlutterAuthSessionManager for authentication.
class ApiService {
  static ApiService? _instance;
  static Client? _client;
  static late String _serverUrl;

  ApiService._();

  /// Initialize the API service with the server URL.
  /// Also initializes the auth session manager.
  static Future<void> initialize({String? serverUrl}) async {
    _serverUrl = serverUrl ?? 'https://resonate-vucn.onrender.com/';
    
    // Create client with FlutterConnectivityMonitor and longer timeout
    _client = Client(
      _serverUrl,
      // Increase timeout for AI processing (5 minutes)
      connectionTimeout: const Duration(minutes: 5),
    )..connectivityMonitor = FlutterConnectivityMonitor();
    
    // Set up the auth session manager for Serverpod 3
    _client!.authSessionManager = FlutterAuthSessionManager();
    
    // Restore any existing session (don't await as it returns bool)
    _client!.auth.initialize();
    
    _instance = ApiService._();
  }

  /// Get the singleton instance.
  static ApiService get instance {
    if (_instance == null) {
      throw StateError('ApiService not initialized. Call initialize() first.');
    }
    return _instance!;
  }

  /// Get the Serverpod client.
  static Client get client {
    if (_client == null) {
      throw StateError('ApiService not initialized. Call initialize() first.');
    }
    return _client!;
  }

  /// Check if the service is initialized.
  static bool get isInitialized => _client != null;

  /// Get the auth session manager.
  static FlutterAuthSessionManager get auth => client.auth;

  /// Check if user is authenticated.
  static bool get isAuthenticated => auth.isAuthenticated;

  /// Get the current auth info (tokens and user info).
  static AuthSuccess? get authInfo => auth.authInfo;

  /// Get the current server URL.
  static String get serverUrl => _serverUrl;

  /// Close the client connection.
  static void close() {
    _client?.close();
    _client = null;
    _instance = null;
  }
}
