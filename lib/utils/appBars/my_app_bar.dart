import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final Widget? leading;

  const MyAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.automaticallyImplyLeading = false,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return SliverSafeArea(
      sliver: SliverAppBar(
        leading: leading,
        actionsPadding: const EdgeInsets.only(right: 5),
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Padding(
          padding: const EdgeInsets.only(left: 5),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        floating: true,
        pinned: false,
        flexibleSpace: FlexibleSpaceBar(
          background: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
          ),
        ),
        actions: actions,
      ),
    );
  }
}
