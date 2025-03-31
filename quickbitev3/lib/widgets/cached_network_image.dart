import 'package:flutter/material.dart';

class SafeNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const SafeNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final Widget image = imageUrl.isNotEmpty
        ? Image.network(
            imageUrl,
            width: width,
            height: height,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return errorWidget ??
                  Container(
                    width: width,
                    height: height,
                    color: Colors.grey[300],
                    child: Icon(
                      Icons.image_not_supported_outlined,
                      color: Colors.grey[500],
                      size: (width ?? 100) * 0.4,
                    ),
                  );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return placeholder ??
                  Container(
                    width: width,
                    height: height,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                (loadingProgress.expectedTotalBytes ?? 1)
                            : null,
                        strokeWidth: 2,
                        color: Colors.red[300],
                      ),
                    ),
                  );
            },
          )
        : errorWidget ??
            Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: Icon(
                Icons.image_not_supported_outlined,
                color: Colors.grey[500],
                size: (width ?? 100) * 0.4,
              ),
            );

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }

    return image;
  }
}