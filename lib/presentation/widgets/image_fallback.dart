import 'package:flutter/material.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final BoxFit fit;

  const NetworkImageWithFallback({
    Key? key,
    required this.imageUrl,
    this.fit = BoxFit.fitHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Image.network(
          imageUrl,
          fit: fit,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Center(
              child: SizedBox(
                width: constraints.maxWidth * 0.2,
                height: constraints.maxHeight * 0.2,
                child: Image.asset(
                  'assets/default_image.png',
                  fit: fit,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
