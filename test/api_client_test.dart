import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/models/award.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';

void main() {
  group('ApiClient Experience & Award endpoints', () {
    test('getExperiences parses snake_case JSON payload accurately', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'GET');
        expect(request.url.path, '/api/v1/experiences/');
        return http.Response(
          jsonEncode([
            {
              'id': 'exp-uuid-1',
              'title': 'Teaching Assistant - Fasilkom UI',
              'category': 'part-time',
              'category_display': 'Part-Time',
              'description': 'Assisted Calculus classes and graded exams.',
              'thumbnail': '',
              'started_at': '2026-09-01',
              'ended_at': null,
              'is_ongoing': true,
              'star_count': 4,
              'is_starred': false,
              'starred_by_names': 'alice, bob',
            },
          ]),
          200,
        );
      });

      final api = ApiClient(client: mockClient, baseUrl: 'http://example.test');
      final items = await api.getExperiences();

      expect(items, hasLength(1));
      expect(items.first.id, 'exp-uuid-1');
      expect(items.first.categoryDisplay, 'Part-Time');
      expect(items.first.isOngoing, isTrue);
      expect(items.first.starCount, 4);
      expect(items.first.starredByNames, 'alice, bob');
    });

    test('createExperience sends Token header and excludes read-only id', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/experiences/');
        expect(request.headers['Authorization'], 'Token secret-token');

        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body.containsKey('id'), isFalse);
        expect(body['title'], 'Backend Intern - Tech Corp');

        return http.Response(
          jsonEncode({
            'id': 'exp-uuid-2',
            'title': body['title'],
            'category': body['category'],
            'category_display': 'Internship',
            'description': body['description'],
            'thumbnail': '',
            'started_at': '2026-11-25',
            'ended_at': null,
            'is_ongoing': true,
            'star_count': 0,
            'is_starred': false,
            'starred_by_names': '',
          }),
          201,
        );
      });

      final api = ApiClient(client: mockClient, baseUrl: 'http://example.test');
      final created = await api.createExperience(
        const Experience(
          id: 'ignored-client-id',
          title: 'Backend Intern - Tech Corp',
          category: 'internship',
          description: 'Built REST APIs with Django REST Framework.',
        ),
        token: 'secret-token',
      );

      expect(created.id, 'exp-uuid-2');
      expect(created.categoryDisplay, 'Internship');
    });

    test('updateExperience sends PATCH and deleteExperience sends DELETE', () async {
      final mockClient = MockClient((request) async {
        expect(request.headers['Authorization'], 'Token secret-token');
        if (request.method == 'PATCH') {
          expect(request.url.path, '/api/v1/experiences/exp-1/');
          return http.Response(
            jsonEncode({
              'id': 'exp-1',
              'title': 'Updated Title',
              'category': 'research',
              'description': 'Updated description text.',
            }),
            200,
          );
        }
        if (request.method == 'DELETE') {
          expect(request.url.path, '/api/v1/experiences/exp-1/');
          return http.Response('', 204);
        }
        return http.Response('Unexpected', 400);
      });

      final api = ApiClient(client: mockClient, baseUrl: 'http://example.test');
      final updated = await api.updateExperience(
        'exp-1',
        const Experience(
          title: 'Updated Title',
          category: 'research',
          description: 'Updated description text.',
        ),
        token: 'secret-token',
      );
      expect(updated.title, 'Updated Title');

      await api.deleteExperience('exp-1', token: 'secret-token');
    });

    test('createAward sends snake_case fields and parses response', () async {
      final mockClient = MockClient((request) async {
        expect(request.method, 'POST');
        expect(request.url.path, '/api/v1/awards/');
        final body = jsonDecode(request.body) as Map<String, dynamic>;
        expect(body['certificate_url'], 'https://example.com/cert.pdf');
        expect(body['is_winner'], isTrue);

        return http.Response(
          jsonEncode({
            'id': 'award-1',
            'title': body['title'],
            'issuer': body['issuer'],
            'tier': body['tier'],
            'date': body['date'],
            'description': body['description'],
            'certificate_url': body['certificate_url'],
            'is_winner': true,
            'star_count': 1,
            'is_starred': false,
            'starred_by_names': '',
          }),
          201,
        );
      });

      final api = ApiClient(client: mockClient, baseUrl: 'http://example.test');
      final award = await api.createAward(
        const Award(
          title: '1st Place Hackathon',
          issuer: 'Fasilkom UI',
          tier: 'National',
          date: 'November 2026',
          description: 'Built an ambient clinical intelligence platform.',
          certificateUrl: 'https://example.com/cert.pdf',
          isWinner: true,
        ),
        token: 'secret-token',
      );

      expect(award.id, 'award-1');
      expect(award.isWinner, isTrue);
    });

    test('throws ApiException(401) and AuthState.clearSession resets login', () async {
      final mockClient = MockClient((request) async {
        return http.Response('{"detail": "Invalid token."}', 401);
      });

      final api = ApiClient(client: mockClient, baseUrl: 'http://example.test');
      final authState = AuthState(api, initialToken: 'expired-token');
      expect(authState.isLoggedIn, isTrue);

      await expectLater(
        () => api.createExperience(
          const Experience(
            title: 'Test',
            category: 'internship',
            description: 'Testing 401 handling',
          ),
          token: authState.token!,
        ),
        throwsA(
          isA<ApiException>().having((e) => e.statusCode, 'statusCode', 401),
        ),
      );

      authState.clearSession();
      expect(authState.isLoggedIn, isFalse);
      expect(authState.token, isNull);
    });
  });
}