import 'dart:io';

import 'package:flutter/material.dart';
import 'package:particulous/data/settings.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class PartImageWidget extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;
  const PartImageWidget({
    super.key,
    required this.image,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<Settings>(
      builder: (context, value, child) => Image.file(
        File(join(value.imageDir, image)),
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      ),
    );
  }
}
