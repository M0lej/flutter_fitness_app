import 'package:flutter/material.dart';
import 'package:gym_app/themes/app_theme.dart';

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

void closeWithoutSaving(BuildContext appContext) {
  showDialog(
    context: appContext,
    builder: (context) => MyAlertDialog(
      title: "Are you sure you want to finish this workout without saving?",
      buttons: [
        TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(appContext);
          },
          label: Text(
            "Yes",
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          icon: const Icon(Icons.check, color: Colors.white),
        ),
        TextButton.icon(
          onPressed: () => Navigator.pop(context),
          label: Text(
            "No",
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
