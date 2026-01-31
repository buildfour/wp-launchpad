import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:web/web.dart' as web;
import 'dart:async';
import 'dart:js_interop';
import '../providers/auth_provider.dart';
import '../theme/app_theme.dart';
import 'admin_screen.dart';

class SignInScreen extends ConsumerStatefulWidget {
  final Widget child;
  const SignInScreen({super.key, required this.child});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _tokenController = TextEditingController();

  @override
  void dispose() {
    _tokenController.dispose();
    super.dispose();
  }

  Future<void> _pickAndLoginWithFile() async {
    final input = web.document.createElement('input') as web.HTMLInputElement;
    input.type = 'file';
    input.accept = '.wplp';
    final completer = Completer<String?>();
    input.onChange.listen((_) {
      final files = input.files;
      if (files != null && files.length > 0) {
        final file = files.item(0)!;
        final reader = web.FileReader();
        reader.onloadend = (web.Event e) {
          completer.complete(reader.result as String?);
        }.toJS;
        reader.readAsText(file);
      } else {
        completer.complete(null);
      }
    });
    input.click();
    final content = await completer.future;
    if (content != null && content.trim().isNotEmpty) {
      ref.read(authProvider.notifier).login(content.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    if (authState.isAuthenticated) return widget.child;
    return _buildLogin(authState);
  }

  Widget _buildLogin(AuthState authState) {
    return Scaffold(
      backgroundColor: AppTheme.bgLight,
      body: Stack(
        children: [
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 56, height: 56,
                    decoration: BoxDecoration(color: AppTheme.accentOrange, borderRadius: BorderRadius.circular(12)),
                    child: const Center(child: FaIcon(FontAwesomeIcons.rocket, color: Colors.white, size: 24)),
                  ),
                  const SizedBox(height: 24),
                  const Text('WP Launchpad', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textMain)),
                  const SizedBox(height: 8),
                  const Text('Enter your access token', style: TextStyle(color: AppTheme.textMuted)),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.cardShadow, blurRadius: 12, offset: const Offset(0, 4))]),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          controller: _tokenController,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Access Token', hintText: 'Enter your token', prefixIcon: const Padding(padding: EdgeInsets.all(12), child: FaIcon(FontAwesomeIcons.key, size: 16, color: AppTheme.textMuted)), border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppTheme.borderGray))),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: authState.isLoading ? null : () => ref.read(authProvider.notifier).login(_tokenController.text.trim()),
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy, foregroundColor: Colors.white, padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                          child: authState.isLoading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        const SizedBox(height: 20),
                        Row(children: [const Expanded(child: Divider()), Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Text('or', style: TextStyle(color: AppTheme.textMuted))), const Expanded(child: Divider())]),
                        const SizedBox(height: 20),
                        OutlinedButton.icon(
                          onPressed: authState.isLoading ? null : () => _pickAndLoginWithFile(),
                          icon: const FaIcon(FontAwesomeIcons.fileArrowUp, size: 16),
                          label: const Text('Upload .wplp File'),
                          style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        ),
                        if (authState.error != null) Padding(padding: const EdgeInsets.only(top: 16), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.error.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(authState.error!, style: const TextStyle(color: AppTheme.error, fontSize: 13), textAlign: TextAlign.center))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(right: 16, bottom: 16, child: TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminScreen())), child: const Text('Admin', style: TextStyle(color: AppTheme.textMuted)))),
        ],
      ),
    );
  }
}
