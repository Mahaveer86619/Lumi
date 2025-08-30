import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:lumi/core/constants/app_constants.dart';
import 'package:lumi/core/user/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  final Logger _logger;
  final FlutterSecureStorage _secureStorage;
  final SharedPreferences _sharedPreferences;
  
  AppUserCubit({
    required Logger logger,
    required FlutterSecureStorage secureStorage,
    required SharedPreferences sharedPreferences,
  })  : _logger = logger,
        _secureStorage = secureStorage,
        _sharedPreferences = sharedPreferences,
        super(const AppUserInitial());

  /// Authenticates user and saves their data securely
  Future<void> authenticateUser(AppUser user) async {
    try {
      emit(const AppUserLoading());
      
      final userMap = user.toJson();
      await _saveUser(userMap);
      
      _logger.i('User authenticated successfully: ${user.id}');
      emit(AppUserAuthenticated(user));
    } catch (e, stackTrace) {
      _logger.e('Authentication failed', error: e, stackTrace: stackTrace);
      emit(AppUserError('Authentication failed: ${e.toString()}'));
    }
  }

  /// Loads user from storage and restores authentication state
  Future<void> loadUser() async {
    try {
      emit(const AppUserLoading());
      
      final userMap = await _getUser();
      if (userMap != null) {
        final user = AppUser.fromJson(userMap);
        
        // Verify token validity
        final token = await getToken();
        if (token != null && await _isTokenValid(token)) {
          _logger.i('User loaded successfully: ${user.id}');
          emit(AppUserAuthenticated(user));
        } else {
          _logger.w('Invalid or expired token, signing out');
          await signOut();
        }
      } else {
        _logger.i('No user found in storage');
        emit(const AppUserInitial());
      }
    } catch (e, stackTrace) {
      _logger.e('Failed to load user', error: e, stackTrace: stackTrace);
      emit(AppUserError('Failed to load user: ${e.toString()}'));
    }
  }

  /// Saves user data to SharedPreferences (non-sensitive data)
  Future<void> _saveUser(Map<String, dynamic> userMap) async {
    try {
      // Remove sensitive data before saving to SharedPreferences
      final safeuserMap = Map<String, dynamic>.from(userMap);
      safeuserMap.remove('password');
      safeuserMap.remove('token');
      safeuserMap.remove('refreshToken');
      
      await _sharedPreferences.setString(
        AppConstants.prefUserKey, 
        jsonEncode(safeuserMap),
      );
      _logger.d('User data saved to SharedPreferences');
    } catch (e) {
      _logger.e('Error saving user data: $e');
      rethrow;
    }
  }

  /// Retrieves user data from SharedPreferences
  Future<Map<String, dynamic>?> _getUser() async {
    try {
      final userString = _sharedPreferences.getString(AppConstants.prefUserKey);
      if (userString != null && userString.isNotEmpty) {
        return jsonDecode(userString) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      _logger.e('Error retrieving user data: $e');
      return null;
    }
  }

  /// Signs out user and clears all stored data
  Future<void> signOut() async {
    try {
      emit(const AppUserLoading());
      
      // Clear all user-related data
      await Future.wait([
        _sharedPreferences.remove(AppConstants.prefUserKey),
        _removeTokens(),
      ]);
      
      _logger.i('User signed out successfully');
      emit(const AppUserInitial());
    } catch (e, stackTrace) {
      _logger.e('Error during sign out', error: e, stackTrace: stackTrace);
      emit(AppUserError('Sign out failed: ${e.toString()}'));
    }
  }

  /// Saves authentication tokens securely
  Future<void> saveTokens({
    required String accessToken, 
    required String refreshToken,
  }) async {
    try {
      await Future.wait([
        _secureStorage.write(
          key: AppConstants.secureTokenKey, 
          value: accessToken,
        ),
        _secureStorage.write(
          key: AppConstants.secureRefreshTokenKey, 
          value: refreshToken,
        ),
      ]);
      
      _logger.d('Tokens saved securely');
      
      // Update state with current user if available
      if (state is AppUserAuthenticated) {
        final currentUser = (state as AppUserAuthenticated).user;
        emit(AppUserAuthenticated(currentUser));
      }
    } catch (e, stackTrace) {
      _logger.e('Error saving tokens', error: e, stackTrace: stackTrace);
      throw Exception('Failed to save authentication tokens');
    }
  }

  /// Retrieves access token from secure storage
  Future<String?> getToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.secureTokenKey);
    } catch (e) {
      _logger.e('Error retrieving access token: $e');
      return null;
    }
  }

  /// Retrieves refresh token from secure storage
  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: AppConstants.secureRefreshTokenKey);
    } catch (e) {
      _logger.e('Error retrieving refresh token: $e');
      return null;
    }
  }

  /// Updates both access and refresh tokens
  Future<void> updateTokens({
    required String accessToken, 
    required String refreshToken,
  }) async {
    try {
      await saveTokens(
        accessToken: accessToken, 
        refreshToken: refreshToken,
      );
      _logger.i('Tokens updated successfully');
    } catch (e, stackTrace) {
      _logger.e('Error updating tokens', error: e, stackTrace: stackTrace);
      throw Exception('Failed to update authentication tokens');
    }
  }

  /// Removes all authentication tokens
  Future<void> _removeTokens() async {
    try {
      await Future.wait([
        _secureStorage.delete(key: AppConstants.secureTokenKey),
        _secureStorage.delete(key: AppConstants.secureRefreshTokenKey),
      ]);
      _logger.d('Tokens removed from secure storage');
    } catch (e) {
      _logger.e('Error removing tokens: $e');
      // Don't rethrow as this is called during cleanup
    }
  }

  /// Checks if the current user is authenticated
  bool get isAuthenticated => state is AppUserAuthenticated;

  /// Gets the current authenticated user
  AppUser? get currentUser => state is AppUserAuthenticated 
      ? (state as AppUserAuthenticated).user 
      : null;

  /// Checks if token exists and is potentially valid
  Future<bool> hasValidToken() async {
    try {
      final token = await getToken();
      return token != null && await _isTokenValid(token);
    } catch (e) {
      _logger.e('Error checking token validity: $e');
      return false;
    }
  }

  /// Basic token validation (you should enhance this based on your JWT structure)
  Future<bool> _isTokenValid(String token) async {
    try {
      // Basic checks
      if (token.isEmpty) return false;
      
      // For JWT tokens, you might want to check expiration
      // This is a simplified example - implement proper JWT validation
      final parts = token.split('.');
      if (parts.length != 3) return false;
      
      // Decode payload and check expiration
      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final payloadMap = jsonDecode(decoded) as Map<String, dynamic>;
      
      final exp = payloadMap['exp'] as int?;
      if (exp != null) {
        final expirationDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
        final now = DateTime.now();
        
        // Add 5-minute buffer for token refresh
        return expirationDate.isAfter(now.add(const Duration(minutes: 5)));
      }
      
      return true; // If no expiration found, assume valid
    } catch (e) {
      _logger.e('Error validating token: $e');
      return false;
    }
  }

  /// Clears all authentication data (useful for debugging or complete reset)
  Future<void> clearAllData() async {
    try {
      emit(const AppUserLoading());
      
      await Future.wait([
        _sharedPreferences.clear(),
        _secureStorage.deleteAll(),
      ]);
      
      _logger.i('All user data cleared');
      emit(const AppUserInitial());
    } catch (e, stackTrace) {
      _logger.e('Error clearing all data', error: e, stackTrace: stackTrace);
      emit(AppUserError('Failed to clear data: ${e.toString()}'));
    }
  }

  /// Updates user profile information
  Future<void> updateUserProfile(AppUser updatedUser) async {
    try {
      emit(const AppUserLoading());
      
      final userMap = updatedUser.toJson();
      await _saveUser(userMap);
      
      _logger.i('User profile updated: ${updatedUser.id}');
      emit(AppUserAuthenticated(updatedUser));
    } catch (e, stackTrace) {
      _logger.e('Error updating user profile', error: e, stackTrace: stackTrace);
      emit(AppUserError('Failed to update profile: ${e.toString()}'));
    }
  }
}