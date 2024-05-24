import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:login_register/main.dart';

void main() {
  testWidgets('Login page has a title and a login button', (WidgetTester tester) async {
    // Build the LoginPage widget.
    await tester.pumpWidget(MyApp());

    // Verify that the title is displayed.
    expect(find.text('Login'), findsOneWidget);

    // Verify that the email and password text fields are displayed.
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that the login button is displayed.
    expect(find.widgetWithText(ElevatedButton, 'Login'), findsOneWidget);
  });

  testWidgets('Login button triggers login process', (WidgetTester tester) async {
    // Build the LoginPage widget.
    await tester.pumpWidget(MyApp());

    // Enter text into the email and password fields.
    await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // Tap the login button.
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pump();

    // Verify that the login process is triggered.
    // This part of the test can be expanded to check for specific actions,
    // such as API calls or navigation to another screen.
  });
}
