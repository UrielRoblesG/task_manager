import 'package:flutter/material.dart';
import 'package:task_manager/widgets/widgets.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, this.child = const SizedBox()});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [..._backgroundElements(size), child],
      ),
    );
  }

  List<Widget> _backgroundElements(Size size) => [
        Positioned(
            right: 0,
            child: CircleContainer(
              height: size.height * .5,
              width: size.width * 0.4,
            )),
        Positioned(
            right: 0,
            child: PeanutContainer(
              height: size.height * 0.5,
              width: size.width * 0.4,
            )),
      ];
}