import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:masteringlayoutandtamingthewidgettree51placingwidgetsoneafteranother_custompaintwidgetfordrawingshapes/main.dart';

void main() {
  testWidgets('CustomPaint Widget for Drawing Shapes',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomPaintedShape(
            sideLength: 100, color: Colors.red), // Your CustomPaint widget
      ),
    ));

    // Verify CustomPaint is used
    expect(
        find.byWidgetPredicate(
          (Widget widget) => widget is CustomPaint && widget.painter is CustomPainter,
          description: 'CustomPaint checking for a custom painter within',
        ),
        findsOneWidget);

    // Further tests can include checking if the shape parameters (like size and color) are correctly applied,
    // which may require additional methods or properties in your CustomShape widget for testability.
  });
}
