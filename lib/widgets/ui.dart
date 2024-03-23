import 'package:flutter/material.dart';

class PeanutContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  const PeanutContainer(
      {super.key,
      this.height = double.infinity,
      this.width = double.infinity,
      this.color = const Color(0xFF63d67a)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _PeanutPainter(color: color),
      ),
    );
  }
}

class _PeanutPainter extends CustomPainter {
  final Color color;

  _PeanutPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 3;
    paint.color = color;
    final path = Path();

    path.moveTo(size.width * 0.2, 0);
    path.quadraticBezierTo(size.width * -0.2, size.height * 0.3,
        size.width * 0.4, size.height * 0.5);
    path.quadraticBezierTo(size.width * 0.43, size.height * 0.51,
        size.width * 0.44, size.height * 0.54);

    path.quadraticBezierTo(size.width * 0.43, size.height * 0.7,
        size.width * 0.49, size.height * 0.8);
    path.quadraticBezierTo(
        size.width * 0.56, size.height, size.width, size.height * 0.97);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CircleContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;

  const CircleContainer(
      {super.key,
      this.height = double.infinity,
      this.width = double.infinity,
      this.color = const Color(0xFFb9f0c5)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _CirclePainter(color: color),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  final Color color;

  _CirclePainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 3;
    paint.color = color;
    final path = Path();

    path.moveTo(size.width * -0.05, 0);
    path.quadraticBezierTo(size.width - 200, size.height * 0.4,
        size.width * 0.5, size.height * .5);
    path.lineTo(size.width, 0);
    // path.quadraticBezierTo(size.width * -0.25, size.height * 0.3,
    //     size.width * 0.4, size.height * 0.5);
    // path.quadraticBezierTo(size.width * 0.43, size.height * 0.51,
    //     size.width * 0.44, size.height * 0.54);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
