import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ImageHelper {
  static Widget networkImage({
    required String url,
    required double height,
    double? width,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Widget? errorWidget,
    Widget? loadingWidget,
  }) {
    // For web platform, use a more reliable approach
    if (kIsWeb) {
      return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: Container(
          height: height,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: borderRadius ?? BorderRadius.zero,
            image: DecorationImage(
              image: NetworkImage(url),
              fit: fit,
              onError: (exception, stackTrace) {
                debugPrint('Error loading image: $url');
              },
            ),
          ),
          child: errorWidget != null 
              ? Stack(
                  children: [
                    Center(child: errorWidget),
                  ],
                )
              : null,
        ),
      );
    }
    
    // For mobile platforms, use the standard approach
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Image.network(
        url,
        height: height,
        width: width ?? double.infinity,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return errorWidget ?? Container(
            height: height,
            width: width ?? double.infinity,
            color: Colors.grey[300],
            child: Center(
              child: Icon(Icons.image_not_supported, color: Colors.grey[500]),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ?? Container(
            height: height,
            width: width ?? double.infinity,
            color: Colors.grey[200],
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / 
                      loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
  
  // Add a method for local placeholder images as fallback
  static Widget placeholderImage({
    required double height,
    double? width,
    BoxFit fit = BoxFit.cover,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    IconData icon = Icons.restaurant,
    Color? iconColor,
  }) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        color: backgroundColor ?? Colors.grey[300],
        child: Center(
          child: Icon(
            icon,
            color: iconColor ?? Colors.grey[500],
            size: height * 0.3,
          ),
        ),
      ),
    );
  }
}