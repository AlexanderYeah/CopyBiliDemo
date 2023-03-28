import 'dart:ui';

import 'package:flutter/material.dart';

class SKBlur extends StatelessWidget {
  final Widget? child;
  final double sigma;
  const SKBlur({super.key, this.child, this.sigma = 10});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: sigma,
        sigmaY: sigma,
      ),
      child: Container(child: child == null ? Text("") : child),
    );
  }
}
