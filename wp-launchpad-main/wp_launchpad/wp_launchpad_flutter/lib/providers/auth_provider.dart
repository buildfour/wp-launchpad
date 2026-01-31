import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wp_launchpad_client/wp_launchpad_client.dart';
import '../main.dart';

String? _sessionToken;
String? _sessionUserId;

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final String? error;
  final String? userId;

  const AuthState({this.isAuthenticated = false, this.isLoading = false, this.error, this.userId});

  AuthState copyWith({bool? isAuthenticated, bool? isLoading, String? error, String? userId}) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      userId: userId ?? this.userId,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState());

  Future<bool> login(String token) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final session = await client.auth.validateTokenAndGetSession(token);
      if (session != null) {
        _sessionToken = token;
        _sessionUserId = session.userEmail; // WPL-XXXXXXXX userId
        state = AuthState(isAuthenticated: true, userId: _sessionUserId);
        return true;
      }
      state = state.copyWith(isLoading: false, error: 'Invalid token');
      return false;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: 'Login failed: $e');
      return false;
    }
  }

  void logout() {
    _sessionToken = null;
    _sessionUserId = null;
    state = const AuthState();
  }

  String? get token => _sessionToken;
}

String? getCurrentUserId() => _sessionUserId;

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) => AuthNotifier());
final userIdProvider = Provider<String?>((ref) => ref.watch(authProvider).userId);
