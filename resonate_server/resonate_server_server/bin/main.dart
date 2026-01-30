import 'package:resonate_server_server/server.dart';

/// This is the starting point for your Serverpod server. Typically, there is
/// no need to modify this file.
import 'dart:io';

void main(List<String> args) {
  print('SERVERPOD_CONFIG env: [32m[1m[4m[7m' + (Platform.environment['SERVERPOD_CONFIG'] ?? 'NOT SET') + '\u001b[0m');
  print('Args: $args');
  run(args);
}
