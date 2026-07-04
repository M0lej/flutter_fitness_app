import 'package:flutter/material.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/tabs/home_tab.dart';
import 'package:gym_app/tabs/plans_tab.dart';
import 'package:provider/provider.dart';

class AppTabsController extends StatefulWidget {
  const AppTabsController({super.key});

  @override
  State<AppTabsController> createState() => _AppTabsControllerState();
}

class _AppTabsControllerState extends State<AppTabsController> {
  int _currentIndex = 0;

  final _homeTab = GlobalKey<NavigatorState>();
  final _plansTab = GlobalKey<NavigatorState>();

  void _onTap(int index, BuildContext context) {
    if (_currentIndex == index) {
      switch (index) {
        case 0:
          _homeTab.currentState!.popUntil((route) => route.isFirst);
          break;
        case 1:
          _plansTab.currentState!.popUntil((route) => route.isFirst);
          break;
      }
    } else {
      if (mounted) {
        setState(() {
          _currentIndex = index;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Translations translations = context.watch<SettingsProvider>().translations;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          Navigator(
            key: _homeTab,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => HomeTab(),
            ),
          ),
          Navigator(
            key: _plansTab,
            onGenerateRoute: (route) => MaterialPageRoute(
              settings: route,
              builder: (context) => PlansTab(),
            ),
          ),
        ],
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => _onTap(index, context),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: translations.home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notes),
            label: translations.plans,
          ),
        ],
      ),
    );
  }
}
