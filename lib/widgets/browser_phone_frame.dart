import 'package:flutter/material.dart';

class BrowserPhoneFrame extends StatelessWidget {
  const BrowserPhoneFrame({super.key, required this.child});

  final Widget child;

  static const _screenSize = Size(390, 844);
  static const _frameSize = Size(414, 868);
  static const _safeInsets = EdgeInsets.only(top: 59, bottom: 34);

  @override
  Widget build(BuildContext context) {
    final hostMediaQuery = MediaQuery.of(context);
    final phoneMediaQuery = hostMediaQuery.copyWith(
      size: _screenSize,
      devicePixelRatio: 3,
      padding: _safeInsets,
      viewPadding: _safeInsets,
      viewInsets: EdgeInsets.zero,
    );

    return ColoredBox(
      color: const Color(0xFF202027),
      child: Center(
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Container(
            width: BrowserPhoneFrame._frameSize.width,
            height: BrowserPhoneFrame._frameSize.height,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF08080A),
              borderRadius: BorderRadius.circular(48),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99000000),
                  blurRadius: 32,
                  offset: Offset(0, 16),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(36),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MediaQuery(data: phoneMediaQuery, child: child),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: 108,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xFF08080A),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      width: 108,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
