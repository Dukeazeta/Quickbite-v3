import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class DefaultProfileIcon extends StatelessWidget {
  final double width;
  final double height;
  
  const DefaultProfileIcon({
    Key? key,
    this.width = 24,
    this.height = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Try to load the SVG, but fall back to a Material icon if it fails
    return FutureBuilder<bool>(
      future: _assetExists('assets/svg/default_profile.svg'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && 
            snapshot.data == true) {
          return SvgPicture.asset(
            'assets/svg/default_profile.svg',
            width: width,
            height: height,
          );
        } else {
          // Fallback to a Material icon
          return Icon(
            Icons.account_circle,
            size: width,
            color: Colors.grey,
          );
        }
      },
    );
  }
  
  Future<bool> _assetExists(String assetPath) async {
    try {
      await rootBundle.load(assetPath);
      return true;
    } catch (e) {
      return false;
    }
  }
}