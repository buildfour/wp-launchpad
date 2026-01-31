import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:serverpod_flutter/serverpod_flutter.dart';

import 'screens/sign_in_screen.dart';
import 'screens/app_shell.dart';
import 'providers/auth_provider.dart';
import 'theme/app_theme.dart';

late final Client client;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String configJson = await rootBundle.loadString('assets/config.json');
  Map<String, dynamic> config = jsonDecode(configJson);

  // No authenticationKeyManager - we handle auth in-memory only
  client = Client(config['apiUrl'])
    ..connectivityMonitor = FlutterConnectivityMonitor();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WP Launchpad',
      theme: AppTheme.light,
      home: const AuthGate(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AuthGate extends ConsumerWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    
    if (!authState.isAuthenticated) {
      return const SignInScreen(child: SizedBox());
    }
    
    // Always go to AppShell - onboarding happens inside the app
    return const AppShell();
  }
}