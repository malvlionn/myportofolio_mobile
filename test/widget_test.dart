import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('App renders home screen and navigates to Experiences', (
    WidgetTester tester,
  ) async {
    final mockClient = MockClient((request) async {
      return http.Response(jsonEncode([]), 200);
    });

    await tester.pumpWidget(MyApp(apiClient: ApiClient(client: mockClient)));
    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('Lihat Pengalaman'), findsOneWidget);
    expect(find.text('Lihat Penghargaan'), findsOneWidget);

    await tester.tap(find.text('Lihat Pengalaman'));
    await tester.pumpAndSettle();

    expect(find.text('Experiences'), findsOneWidget);
    expect(find.text('No experiences found.'), findsOneWidget);
  });
}