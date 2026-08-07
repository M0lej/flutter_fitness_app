import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/home_tab.dart';
import 'package:gym_app/tabs/plans_tab.dart';
import 'package:gym_app/tabs/settings_tab.dart';
import 'package:gym_app/utils/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart';
import 'package:gym_app/utils/custom_bottom_navigation_bar/custom_bottom_navigation_bar_item.dart';
import 'package:provider/provider.dart';

class AppTabsController extends StatefulWidget {
  const AppTabsController({super.key});

  @override
  State<AppTabsController> createState() => _AppTabsControllerState();
}

void changeTab(int index, BuildContext context) {
  final state = context.findAncestorStateOfType<_AppTabsControllerState>();

  if (state != null) {
    state._onTap(index, context);
  }
}

class _AppTabsControllerState extends State<AppTabsController> {
  int _currentIndex = 0;
  final PageController _controller = PageController();

  void _onTap(int index, BuildContext context) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          Navigator(
            onGenerateRoute: (route) => MaterialPageRoute(
              builder: (_) => Consumer2<SettingsProvider, DataProvider>(
                builder: (context, settings, appData, child) =>
                    HomeTab(appData: appData, settings: settings),
              ),
            ),
          ),
          Navigator(
            onGenerateRoute: (route) =>
                MaterialPageRoute(builder: (_) =>  Consumer2<SettingsProvider, DataProvider>(
                builder: (context, settings, appData, child) =>
                    PlansTab(appData: appData, settings: settings),
              ),),
          ),
          Navigator(
            onGenerateRoute: (route) =>
                MaterialPageRoute(builder: (_) =>  Consumer<SettingsProvider>(
                builder: (context, settings, child) =>
                    SettingsTab(settings: settings),
              ),),
          ),
        ],
      ),

      // Bottom navigation bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => _onTap(index, context),
        icons: [
          const Icon(Icons.home_outlined),
          const Icon(Icons.article_outlined),
          const Icon(Icons.settings_outlined),
        ],
        selectedIcons: [
          const Icon(Icons.home),
          const Icon(Icons.article),
          const Icon(Icons.settings),
        ],
      ),
    );
  }
}
// BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (int index) => _onTap(index, context),
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.home),
//             label: translations.home,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.article),
//             label: translations.plans,
//           ),
//           BottomNavigationBarItem(
//             icon: const Icon(Icons.settings),
//             label: translations.settings,
//           ),
//         ],
//       ),