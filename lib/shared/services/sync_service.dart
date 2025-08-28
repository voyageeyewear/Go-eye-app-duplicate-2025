import 'dart:convert';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';
import '../providers/header_customization_provider.dart';

class SyncService {
  // Connect to Vercel app for sync
  static const String _baseUrl = 'https://go-eye-app-duplicate-2025-nz2jzupv5-voyageeyewears-projects.vercel.app';
  static const String _syncEndpoint = '/public/customization-data.json';
  static const Duration _syncInterval = Duration(seconds: 5); // Sync every 5 seconds
  
  final Dio _dio = Dio();
  Timer? _syncTimer;
  bool _isSyncing = false;
  
  // Callback to notify when data is synced
  VoidCallback? _onDataSynced;
  
  void setOnDataSyncedCallback(VoidCallback callback) {
    _onDataSynced = callback;
  }

  // Start periodic synchronization
  void startSync() {
    print('🚀 Starting sync service...');
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(_syncInterval, (timer) {
      print('⏰ Sync timer triggered');
      _syncCustomizations();
    });
    print('✅ Sync service started with ${_syncInterval.inSeconds}s interval');
  }

  // Stop synchronization
  void stopSync() {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  // Sync customizations from web backend
  Future<void> _syncCustomizations() async {
    if (_isSyncing) return;
    
    try {
      _isSyncing = true;
      
      print('🔄 Attempting to sync from: $_baseUrl$_syncEndpoint');
      
      // Fetch customizations from web backend
      final response = await _dio.get('$_baseUrl$_syncEndpoint');
      
      print('📡 Response status: ${response.statusCode}');
      
      if (response.statusCode == 200 && response.data != null) {
        // Parse the customization data
        final customizationData = response.data;
        
        print('📊 Received ${customizationData.length} customization items');
        
        // Update local storage with the fetched data
        await _updateLocalStorage(customizationData);
        
        // Notify that data has been synced
        _onDataSynced?.call();
        
        print('✅ Customizations synced from web backend');
      } else {
        print('⚠️ Invalid response: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Sync failed: $e');
    } finally {
      _isSyncing = false;
    }
  }

  // Update local storage with fetched data
  Future<void> _updateLocalStorage(Map<String, dynamic> customizationData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      
      // Convert the data to JSON string
      final jsonString = jsonEncode(customizationData);
      
      // Save to local storage
      await prefs.setString('header_customization_data', jsonString);
      
      print('✅ Local storage updated with web backend data');
    } catch (e) {
      print('❌ Failed to update local storage: $e');
    }
  }

  // Upload local customizations to web backend
  Future<void> uploadCustomizations(Map<String, dynamic> customizationData) async {
    try {
      await _dio.post(
        '$_baseUrl$_syncEndpoint',
        data: customizationData,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      print('✅ Customizations uploaded to web backend');
    } catch (e) {
      print('❌ Failed to upload customizations: $e');
    }
  }

  // Manual sync trigger
  Future<void> manualSync() async {
    print('🔄 Manual sync triggered');
    await _syncCustomizations();
  }

  // Force immediate sync for testing
  Future<void> forceSync() async {
    print('🔄 Force sync triggered');
    _isSyncing = false; // Reset sync flag
    await _syncCustomizations();
  }

  // Check if web backend is available
  Future<bool> isBackendAvailable() async {
    try {
      final response = await _dio.get(
        '$_baseUrl$_syncEndpoint',
        options: Options(sendTimeout: Duration(seconds: 5), receiveTimeout: Duration(seconds: 5)),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('❌ Backend check failed: $e');
      return false;
    }
  }
}
