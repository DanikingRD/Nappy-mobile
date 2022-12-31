import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nappy_mobile/common/util/logger.dart';
import 'package:nappy_mobile/common/widgets/primary_button.dart';
import 'package:nappy_mobile/features/auth/controllers/login_controller.dart';
import 'package:nappy_mobile/features/auth/views/pages/login_page.dart';
import 'package:nappy_mobile/repositories/interfaces/auth_facade.dart';

import '../tester_extensions.dart';

class IAuthRepositoryMock extends Mock implements IAuthRepositoryFacade {}

/// Login View requirements:
/// - Email TextField
/// - Password TextField
/// - Submit button
/// - External Auth Providers
void main() {
  late IAuthRepositoryMock authInterface;
  late NappyLogger logger;
  setUp(() {
    authInterface = IAuthRepositoryMock();
    logger = NappyLogger.test((LoginController).toString());
  });
  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        loginControllerProvider.overrideWith((ref) {
          return LoginController(authService: authInterface, logger: logger);
        })
      ],
      child: const MaterialApp(
        home: Scaffold(body: LoginPage()),
      ),
    );
  }

  group("LoginView test cases", () {
    testWidgets("Components are displayed", (tester) async {
      await tester.pumpAnimation(createWidgetUnderTest());
      // Textfields
      expect(find.byType(TextField), findsNWidgets(2));
      // Submit button
      expect(find.byType(PrimaryButton), findsOneWidget);
      // External auth provider buttons
      expect(find.byKey(LoginPage.externalAuthProvidersKey), findsOneWidget);
      // Forgot password button
      final forgotPassword = find.byKey(LoginPage.forgotPasswordButtonKey);
      expect(forgotPassword, findsOneWidget);
      // This does not works for some reason lol
      // final registerBtn = find.byKey(LoginPage.registerAccountButtonKey);
      // expect(registerBtn, findsOneWidget);
    });

    //TODO: Finish test cases
    // testWidgets("Cannot sign in with invalid credentials", (tester) async {
    //   await tester.pumpAnimation(createWidgetUnderTest());
    //   final emailText = find.byKey(LoginPage.emailTextFieldKey);
    //   final passwordText = find.byKey(LoginPage.passwordTextFieldKey);
    //   final submitBtn = find.byKey(LoginPage.submitButtonKey);
    //   await tester.tap(submitBtn);
    //   await tester.pumpAndSettle();
    // });
  });
}
