/*
Practice Question 2: CustomPaint Widget for Drawing Shapes

Task: Develop a Flutter application that includes a CustomPaint widget to draw a simple shape (e.g., a star or a circle). This widget should be reusable and customizable in terms of size and color.
 */

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: CustomPaintedShape(sideLength: 200.0, color: Colors.red),
        ),
      ),
    );
  }
}

class CustomPaintedShape extends StatelessWidget {
  const CustomPaintedShape(
      {super.key, required this.sideLength, required this.color});

  final double sideLength;
  //defines length of each side of the drawn custom shape
  final Color color;
  //defines side color

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Octagon(sideLength, color),
    );
  }
}

// This class extends CustomPainter, which is a base class for custom painting in Flutter.
class Octagon extends CustomPainter {
  // This method is called whenever the custom painter needs to paint (paint a custom shape). It gets a Canvas and a Size object.

  //class constructor
  Octagon(this.sideLength, this.color);
  double sideLength;
  //defines length of each side of the drawn octagon
  Color color;
  //defines octagon side color

  @override
  void paint(Canvas canvas, Size size) {
    // Create a new Paint object. This object describes the characteristics of the paint such as color, stroke width, and painting style.
    var paint = Paint()
      ..color = color // Set the color of the paint to blue.
      ..strokeWidth = 3 // Set the stroke width to 3.
      ..style = PaintingStyle
          .stroke; // Set the style to stroke, which means the octagon will be outlined rather than filled.

    // Create a new Path object. This object is used to create a series of lines and curves.
    var path = Path();

    // Calculate the radius of the circle inscribed in the octagon. This is used to calculate the points of the octagon.
    var r = sideLength / (1 + sqrt(2));

    // Calculate the points of the octagon.
    for (var i = 0; i < 8; i++) {
      // Calculate the x and y coordinates of the point.
      var x = r * cos(2 * pi * i / 8);
      var y = r * sin(2 * pi * i / 8);

      // Create an Offset object from the x and y coordinates and get the point on the canvas that corresponds to this offset.
      var point = size.center(Offset(x,
          y)); // An offset is basically a way for flutter to create a point at a set of coordinates (x and y in this example)
      //these generated points are connected (painted) below, they form the vertices of the octagon

      // If this is the first point, move the path to this point. Otherwise, draw a line from the current point to this point.
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }

    // Close the path to form the octagon.
    path.close();

    // Draw the path on the canvas with the paint.
    canvas.drawPath(path, paint);
  }

  // This method is called when the custom painter is rebuilt. It should return true if the new instance represents different information.
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
