import 'dart:convert';
import 'dart:io';
import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import 'package:serverpod_client/serverpod_client.dart';

void main() async {
  // Initialize Serverpod Client for Production
  // Note: Using ServerpodClient directly as it's a CLI script, 
  // not requiring flutter-specific features like connectivity monitoring.
  final client = Client(
    'https://wplaunchpad.api.serverpod.space/',
    authenticationKeyManager: FlutterAuthenticationKeyManager(), // Placeholder or custom key manager if needed for auth
  );

  print('Targeting Production: https://wplaunchpad.api.serverpod.space/');
  print('Generating 10 Access Tokens...');
  
  final outputDir = Directory('generated_tokens');
  if (!outputDir.existsSync()) {
    outputDir.createSync();
  }

  for (int i = 1; i <= 10; i++) {
    try {
      // Call the endpoint to generate a token
      final accessSession = await client.auth.generateNewToken();
      final token = accessSession.token;

      // Print Text Token
      print('Token $i: $token');

      // Create .wplp File Content (JSON)
      final fileContent = jsonEncode({'token': token});
      final file = File('${outputDir.path}/token_$i.wplp');
      file.writeAsStringSync(fileContent);
      
      print('  -> Saved to ${file.path}');

    } catch (e) {
      print('Error generating token $i: $e');
    }
  }
  
  print('\nGeneration Complete. Check the "generated_tokens" directory.');
  exit(0);
}

// Minimal placeholder if FlutterAuthenticationKeyManager isn't available in pure Dart
class FlutterAuthenticationKeyManager extends AuthenticationKeyManager {
  String? _key;
  @override
  Future<String?> get() async => _key;
  @override
  Future<void> put(String key) async => _key = key;
  @override
  Future<void> remove() async => _key = null;
}
