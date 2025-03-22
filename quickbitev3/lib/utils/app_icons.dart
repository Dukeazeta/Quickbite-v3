import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcons {
  static Widget star({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/star.svg',
      height: size ?? 16,
      width: size ?? 16,
      colorFilter: ColorFilter.mode(color ?? Colors.amber, BlendMode.srcIn),
    );
  }

  static Widget thumbUp({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/thumb-up.svg',
      height: size ?? 16,
      width: size ?? 16,
      colorFilter: ColorFilter.mode(color ?? Colors.grey[600]!, BlendMode.srcIn),
    );
  }

  static Widget comment({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/comment.svg',
      height: size ?? 16,
      width: size ?? 16,
      colorFilter: ColorFilter.mode(color ?? Colors.grey[600]!, BlendMode.srcIn),
    );
  }
}