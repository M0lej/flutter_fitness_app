import 'package:flutter/material.dart';
import 'package:gym_app/utils/custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<Icon> icons;
  final List<Icon> selectedIcons;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.icons,
    required this.selectedIcons,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      CustomBottomNavigationBarState();
}

class CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(widget.icons.length, (index) {
            bool isSelected = widget.currentIndex == index;

            return GestureDetector(
              onTap: () => widget.onTap(index),
              child: CustomBottomNavigationBarItem(
                icon: isSelected
                    ? widget.selectedIcons[index]
                    : widget.icons[index],
                selected: isSelected,
              ),
            );
          }),
        ),
      ),
    );
  }
}
