import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconTest extends StatelessWidget {
  const IconTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Icon Test')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Test direct SVG loading
            SvgPicture.asset(
              'assets/icons/star.svg',
              height: 50,
              width: 50,
              colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
            ),
            const SizedBox(height: 20),
            // Show error message if any
            Builder(
              builder: (context) {
                try {
                  return SvgPicture.asset(
                    'assets/icons/add.svg',
                    height: 50,
                    width: 50,
                  );
                } catch (e) {
                  return Text('Error: $e', style: const TextStyle(color: Colors.red));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}