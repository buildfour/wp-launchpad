import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main.dart';
import '../theme/app_theme.dart';

class AdminScreen extends ConsumerStatefulWidget {
  const AdminScreen({super.key});

  @override
  ConsumerState<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends ConsumerState<AdminScreen> {
  final _passwordController = TextEditingController();
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _error;
  String? _generatedToken;
  String? _generatedUserId;

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _authenticate() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final valid = await client.auth.validateAdminPassword(_passwordController.text);
      setState(() { _isAuthenticated = valid; _error = valid ? null : 'Invalid password'; });
    } catch (e) {
      setState(() { _error = 'Connection error'; });
    }
    setState(() { _isLoading = false; });
  }

  Future<void> _generateToken() async {
    setState(() { _isLoading = true; _error = null; });
    try {
      final result = await client.auth.generateTokenWithUserId(_passwordController.text);
      if (result != null) {
        setState(() { _generatedToken = result['token']; _generatedUserId = result['userId']; });
      } else {
        setState(() { _error = 'Failed to generate token'; });
      }
    } catch (e) {
      setState(() { _error = 'Connection error'; });
    }
    setState(() { _isLoading = false; });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin'), leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context))),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 450),
          padding: const EdgeInsets.all(24),
          child: _isAuthenticated ? _buildTokenPanel() : _buildLoginPanel(),
        ),
      ),
    );
  }

  Widget _buildLoginPanel() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(Icons.admin_panel_settings, size: 64, color: AppTheme.primaryNavy),
        const SizedBox(height: 24),
        const Text('Admin Access', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
        const SizedBox(height: 32),
        TextField(controller: _passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Admin Password', border: OutlineInputBorder()), onSubmitted: (_) => _authenticate()),
        const SizedBox(height: 16),
        ElevatedButton(onPressed: _isLoading ? null : _authenticate, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primaryNavy, padding: const EdgeInsets.all(14)), child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Enter')),
        if (_error != null) Padding(padding: const EdgeInsets.only(top: 16), child: Text(_error!, style: const TextStyle(color: AppTheme.error), textAlign: TextAlign.center)),
      ],
    );
  }

  Widget _buildTokenPanel() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Generate Access Token', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
          const SizedBox(height: 8),
          const Text('Create a new token with auto-generated User ID', style: TextStyle(color: AppTheme.textMuted), textAlign: TextAlign.center),
          const SizedBox(height: 32),
          ElevatedButton(onPressed: _isLoading ? null : _generateToken, style: ElevatedButton.styleFrom(backgroundColor: AppTheme.accentOrange, padding: const EdgeInsets.all(16)), child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('Generate Token & User ID', style: TextStyle(fontSize: 16))),
          if (_error != null) Padding(padding: const EdgeInsets.only(top: 16), child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppTheme.error.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(_error!, style: const TextStyle(color: AppTheme.error), textAlign: TextAlign.center))),
          if (_generatedToken != null && _generatedUserId != null) ...[
            const SizedBox(height: 24),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: AppTheme.success.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.success)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Row(children: [Icon(Icons.check_circle, color: AppTheme.success), SizedBox(width: 8), Text('Credentials Generated!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
                const SizedBox(height: 20),
                const Text('User ID', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMuted, fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    Expanded(child: SelectableText(_generatedUserId!, style: const TextStyle(fontFamily: 'monospace', fontSize: 16, fontWeight: FontWeight.bold))),
                    IconButton(icon: const Icon(Icons.copy, size: 20), onPressed: () { Clipboard.setData(ClipboardData(text: _generatedUserId!)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User ID copied!'))); }),
                  ]),
                ),
                const SizedBox(height: 16),
                const Text('Access Token', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textMuted, fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                  child: Row(children: [
                    Expanded(child: SelectableText(_generatedToken!, style: const TextStyle(fontFamily: 'monospace', fontSize: 11))),
                    IconButton(icon: const Icon(Icons.copy, size: 20), onPressed: () { Clipboard.setData(ClipboardData(text: _generatedToken!)); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Token copied!'))); }),
                  ]),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: AppTheme.warning.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                  child: const Row(children: [
                    Icon(Icons.info_outline, size: 18, color: AppTheme.warning),
                    SizedBox(width: 8),
                    Expanded(child: Text('Give both the User ID and Token to the user. They will need the token to login.', style: TextStyle(fontSize: 12))),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 16),
            OutlinedButton(onPressed: () => setState(() { _generatedToken = null; _generatedUserId = null; }), child: const Text('Generate Another')),
          ],
        ],
      ),
    );
  }
}
