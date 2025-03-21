import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class SvgIcons {
  static Widget add({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/add.svg',
      colorFilter: ColorFilter.mode(color ?? Colors.white, BlendMode.srcIn),
      height: size ?? 20,
      width: size ?? 20,
    );
  }

  static Widget star({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/star.svg',
      colorFilter: ColorFilter.mode(color ?? Colors.amber, BlendMode.srcIn),
      height: size ?? 16,
      width: size ?? 16,
    );
  }

  static Widget person({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/person.svg',
      colorFilter: ColorFilter.mode(color ?? Colors.grey[700]!, BlendMode.srcIn),
      height: size ?? 24,
      width: size ?? 24,
    );
  }

  static Widget notification({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/notification.svg',
      colorFilter: ColorFilter.mode(color ?? Colors.grey[700]!, BlendMode.srcIn),
      height: size ?? 24,
      width: size ?? 24,
    );
  }

  static Widget fastFood({Color? color, double? size}) {
    return SvgPicture.asset(
      'assets/icons/fast-food.svg',
      colorFilter: ColorFilter.mode(color ?? Colors.red[700]!, BlendMode.srcIn),
      height: size ?? 40,
      width: size ?? 40,
    );
  }
}