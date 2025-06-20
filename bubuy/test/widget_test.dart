import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:bubuy_lovers/main.dart'; // Corrected import path based on pubspec.yaml name
import 'package:bubuy_lovers/views/login_screen.dart'; // Import LoginScreen
import 'package:bubuy_lovers/views/splash_screen.dart'; // Import SplashScreen

void main() {
  // Test case for SplashScreen to ensure it navigates to LoginScreen
  testWidgets('SplashScreen navigates to LoginScreen after 3 seconds', (
    WidgetTester tester,
  ) async {
    // Build our app and trigger a frame.
    // The initialRoute in main.dart should direct to SplashScreen for this test
    await tester.pumpWidget(const MyApp());

    // Verify that SplashScreen is displayed
    expect(find.byType(SplashScreen), findsOneWidget);
    expect(find.byType(LoginScreen), findsNothing);

    // Advance time by more than the splash screen duration (e.g., 3 seconds + a little extra)
    await tester.pumpAndSettle(const Duration(seconds: 4));

    // Verify that LoginScreen is now displayed
    expect(find.byType(SplashScreen), findsNothing);
    expect(find.byType(LoginScreen), findsOneWidget);
  });

  // Example test for LoginScreen fields
  testWidgets('LoginScreen shows username and password fields', (
    WidgetTester tester,
  ) async {
    // Build the LoginScreen directly for this test
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that the username and password text fields are present
    expect(find.widgetWithText(TextFormField, 'USERNAME'), findsOneWidget);
    expect(find.widgetWithText(TextFormField, 'PASSWORD'), findsOneWidget);
  });

  // Example test for Login button text
  testWidgets('LoginScreen has a LOGIN button', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Verify that a button with the text 'LOGIN' is present
    expect(find.widgetWithText(ElevatedButton, 'LOGIN'), findsOneWidget);
  });

  // You can add more tests here for other screens and functionalities:
  // - Test registration flow
  // - Test article listing and search functionality
  // - Test profile editing
  // - Test favorite articles
}
