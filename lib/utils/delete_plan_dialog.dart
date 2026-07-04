import 'package:flutter/material.dart';
import 'package:gym_app/settings/languages/translations.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:provider/provider.dart';

class DeletePlanDialog extends StatelessWidget {
  final VoidCallback deletePlan;
  final String planName;
  const DeletePlanDialog({
    super.key,
    required this.deletePlan,
    required this.planName,
  });

  @override
  Widget build(BuildContext context) {
    Translations translations = context.read<SettingsProvider>().translations;

    return AlertDialog(
      title: Text(
        '${translations.areYouSureYouWantToDelete} "$planName" ?\n\n${translations.thisActionCannotBeUndone}',
        style: TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: () {
              deletePlan();
              Navigator.pop(context);
            },
            label: Text(
              translations.delete,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.delete_forever, color: Colors.white),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context),
            label: Text(
              translations.cancel,
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            icon: const Icon(Icons.cancel, color: Colors.white),
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
}
