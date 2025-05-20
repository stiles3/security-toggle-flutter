import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../core/constants.dart';

class AssetRemoteDataSource {
  final http.Client client;
  static const _timeoutDuration = Duration(seconds: 10);

  AssetRemoteDataSource({required this.client});

  Future<bool> getAssetStatus() async {
    try {
      final uri = Uri.parse(ApiEndpoints.status);
      print('🔍 Fetching asset status from: $uri');

      final response = await client.get(uri).timeout(_timeoutDuration);

      _logResponse(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('secured')) {
          return data['secured'] as bool;
        }
        throw const FormatException('Missing "secured" field in response');
      } else {
        throw _handleErrorResponse(response);
      }
    } on TimeoutException {
      print('⏰ Timeout while fetching asset status');
      throw Exception('Request timed out');
    } on FormatException catch (e) {
      print('📄 Response format error: $e');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error in getAssetStatus: $e');
      throw Exception('Failed to load asset status: $e');
    }
  }

  Future<bool> toggleAsset() async {
    try {
      final uri = Uri.parse(ApiEndpoints.toggle);
      print('🔄 Toggling asset status at: $uri');

      final response = await client
          .post(
            uri,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              // 'current_status': currentStatus,
              // Add other required parameters here
            }),
          )
          .timeout(_timeoutDuration);

      _logResponse(response);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('secured')) {
          return data['secured'] as bool;
        }
        throw const FormatException('Missing "secured" field in response');
      } else {
        throw _handleErrorResponse(response);
      }
    } on TimeoutException {
      print('⏰ Timeout while toggling asset status');
      throw Exception('Request timed out');
    } on FormatException catch (e) {
      print('📄 Response format error: $e');
      rethrow;
    } catch (e) {
      print('❌ Unexpected error in toggleAsset: $e');
      throw Exception('Failed to toggle asset: $e');
    }
  }

  // Helper method to log response details
  void _logResponse(http.Response response) {
    print('📡 Response: ${response.statusCode}');
    print('📦 Body: ${response.body}');
    print('📋 Headers: ${response.headers}');
  }

  // Helper method to handle error responses
  Exception _handleErrorResponse(http.Response response) {
    try {
      final errorData = jsonDecode(response.body);
      if (errorData.containsKey('message')) {
        return Exception(errorData['message']);
      }
    } catch (_) {
      // If we can't parse the error body, fall through
    }
    return Exception(
      'Request failed with status: ${response.statusCode}',
    );
  }
}
