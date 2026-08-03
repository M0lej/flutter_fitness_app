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
        leading: leading != null
            ? Padding(padding: const EdgeInsets.only(top: 12), child: leading)
            : null,
        expandedHeight: 85,
        toolbarHeight: 85,
        collapsedHeight: 85,
        actionsPadding: const EdgeInsets.only(right: 5, top: 12),
        automaticallyImplyLeading: automaticallyImplyLeading,
        title: Padding(
          padding: const EdgeInsets.only(top: 12, left: 5),
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
