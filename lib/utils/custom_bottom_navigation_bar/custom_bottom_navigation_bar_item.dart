import 'package:flutter/material.dart';
import 'package:gym_app/themes/app_theme.dart';

class CustomBottomNavigationBarItem extends StatelessWidget {
  final Icon icon;
  final bool selected;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: selected
              ? LinearGradient(
                  begin: AlignmentGeometry.bottomCenter,
                  end: AlignmentGeometry.topCenter,
                  colors: <Color>[
                    AppTheme.red.withAlpha(50),
                    Colors.transparent,
                  ],
                )
              : null,
        ),
        child: AnimatedScale(
          scale: selected ? 1 : 0.7,
          duration: const Duration(milliseconds: 200),
          child: TweenAnimationBuilder(
            tween: ColorTween(
              begin: AppTheme.secondary,
              end: selected ? AppTheme.red : AppTheme.secondary,
            ),
            duration: const Duration(milliseconds: 200),
            builder: (context, color, child) =>
                Icon(icon.icon, color: color, size: 30),
          ),
        ),
      ),
    );
  }
}
