import 'package:flutter/material.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

Future<T?> showAppDialog<T>({required WidgetBuilder builder}) async {
  final context = appNavigatorKey.currentContext;

  if (context == null) {
    return null;
  }

  return showDialog<T>(context: context, builder: builder);
}

class MyAlertDialog extends StatelessWidget {
  final String title;
  final String? description;
  final List<Widget> buttons;

  const MyAlertDialog({
    super.key,
    required this.title,
    this.description = "",
    required this.buttons,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        '$title${description!.isNotEmpty ? "\n" : ''}$description',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons,
      ),
    );
  }
}

void closeWithoutSaving({required BuildContext appContext, Function? onYes}) {
  showDialog(
    context: appContext,
    builder: (context) => Consumer<SettingsProvider>(
      builder: (context, settingsModelValues, child) => MyAlertDialog(
        title:
            settingsModelValues.translations.areSureYouWantToExitWithoutSaving,
        buttons: [
          TextButton.icon(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(appContext);
              onYes?.call();
            },
            label: Text(
              settingsModelValues.translations.yes,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.check, color: Colors.white),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            label: Text(
              settingsModelValues.translations.no,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.close, color: Colors.white),
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Theme.of(context).cardTheme.color,
              ),
              side: WidgetStateProperty.all(
                BorderSide(color: AppTheme.borderColor),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

void showYesNoDialog({
  required String title,
  String? description,
  required Function onYes,
  required BuildContext appContext,
  required Translations translations,
}) {
  showDialog(
    context: appContext,
    builder: (context) => MyAlertDialog(
      title: title,
      buttons: [
        TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
            onYes();
          },
          label: Text(
            translations.yes,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: const Icon(Icons.check, color: Colors.white),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pop(context),
          label: Text(
            translations.no,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: const Icon(Icons.close, color: Colors.white),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Theme.of(context).cardTheme.color,
            ),
            side: WidgetStateProperty.all(
              BorderSide(color: AppTheme.borderColor),
            ),
          ),
        ),
      ],
    ),
  );
}
