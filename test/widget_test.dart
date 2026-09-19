import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:locate_lost/views/widgets/custom_app_bar.dart';

void main() {
  testWidgets('CustomAppBar displays its title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: CustomAppBar(text: 'My Cases'),
        ),
      ),
    );

    expect(find.text('My Cases'), findsOneWidget);
    expect(find.byIcon(Icons.arrow_circle_left_outlined), findsOneWidget);
  });
}
