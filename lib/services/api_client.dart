import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/award.dart';
import 'package:myportofolio_mobile/models/experience.dart';

/// Exception thrown when an API request returns a non-2xx status code.
class ApiException implements Exception {
  const ApiException(this.statusCode, this.message);

  final int statusCode;
  final String message;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// HTTP client for the MyPortfolio Django REST Framework backend.
class ApiClient {
  ApiClient({http.Client? client, this.baseUrl = apiBaseUrl})
    : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Uri _uri(String path) => Uri.parse('$baseUrl$path');

  Map<String, String> _authJsonHeaders(String token) => {
    'Accept': 'application/json',
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Token $token',
  };

  // -------------------- EXPERIENCES --------------------

  Future<List<Experience>> getExperiences() async {
    final response = await _client.get(
      _uri('/api/v1/experiences/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map((item) => Experience.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Experience> getExperienceDetail(String id) async {
    final response = await _client.get(
      _uri('/api/v1/experiences/$id/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Experience.fromJson(decoded);
  }

  Future<Experience> createExperience(
    Experience experience, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/experiences/'),
      headers: _authJsonHeaders(token),
      body: jsonEncode(experience.toJson()),
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Experience.fromJson(decoded);
  }

  Future<Experience> updateExperience(
    String id,
    Experience experience, {
    required String token,
  }) async {
    final response = await _client.patch(
      _uri('/api/v1/experiences/$id/'),
      headers: _authJsonHeaders(token),
      body: jsonEncode(experience.toJson()),
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Experience.fromJson(decoded);
  }

  Future<void> deleteExperience(String id, {required String token}) async {
    final response = await _client.delete(
      _uri('/api/v1/experiences/$id/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  Future<Experience> toggleExperienceStar(
    String id, {
    required String token,
  }) async {
    final response = await _client.post(
      _uri('/api/v1/experiences/$id/star/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Experience.fromJson(decoded);
  }

  // -------------------- AWARDS --------------------

  Future<List<Award>> getAwards() async {
    final response = await _client.get(
      _uri('/api/v1/awards/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map((item) => Award.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<Award> getAwardDetail(String id) async {
    final response = await _client.get(
      _uri('/api/v1/awards/$id/'),
      headers: const {'Accept': 'application/json'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Award.fromJson(decoded);
  }

  Future<Award> createAward(Award award, {required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/awards/'),
      headers: _authJsonHeaders(token),
      body: jsonEncode(award.toJson()),
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Award.fromJson(decoded);
  }

  Future<Award> updateAward(
    String id,
    Award award, {
    required String token,
  }) async {
    final response = await _client.patch(
      _uri('/api/v1/awards/$id/'),
      headers: _authJsonHeaders(token),
      body: jsonEncode(award.toJson()),
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Award.fromJson(decoded);
  }

  Future<void> deleteAward(String id, {required String token}) async {
    final response = await _client.delete(
      _uri('/api/v1/awards/$id/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  Future<Award> toggleAwardStar(String id, {required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/awards/$id/star/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return Award.fromJson(decoded);
  }

  // -------------------- AUTH --------------------

  Future<String> obtainToken(String username, String password) async {
    final response = await _client.post(
      _uri('/api/v1/auth/token/'),
      headers: const {
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'username': username, 'password': password}),
    );
    _ensureSuccess(response);

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    return decoded['token'] as String;
  }

  Future<void> logout({required String token}) async {
    final response = await _client.post(
      _uri('/api/v1/auth/logout/'),
      headers: {'Accept': 'application/json', 'Authorization': 'Token $token'},
    );
    _ensureSuccess(response);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    throw ApiException(response.statusCode, response.body);
  }
}
