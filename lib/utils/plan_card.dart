import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/hive/plan.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/themes/app_theme.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/delete_plan_dialog.dart';
import 'package:provider/provider.dart';

class PlanCard extends StatefulWidget {
  final Plan plan;
  const PlanCard({super.key, required this.plan});

  @override
  State<PlanCard> createState() => _PlanCardState();
}

class _PlanCardState extends State<PlanCard> {
  bool _propertiesExpanded = false;

  void _switchPropertiesPanel() {
    setState(() {
      _propertiesExpanded = !_propertiesExpanded;
    });
  }

  void _showDeletionPopup() {
    showDialog(
      context: context,
      builder: (context) =>
          DeletePlanDialog(deletePlan: _deletePlan, planName: widget.plan.name),
    );
  }

  void _deletePlan() {
    context.read<DataProvider>().removePlan(widget.plan);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settingsModelValues, dataModelValues, child) => CustomCard(
        children: [
          Row(
            spacing: 20,
            children: [
              // plan icon

              // plan name and number of exercises
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(
                    widget.plan.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    '${widget.plan.exercises.length} ${settingsModelValues.translations.exercises}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              // properties button
              Transform.translate(
                offset: const Offset(210, -15),
                child: IconButton(
                  onPressed: () => _switchPropertiesPanel(),
                  icon: const Icon(Icons.more_horiz),
                ),
              ),
            ],
          ),

          // horizontal divider
          Divider(
            thickness: .5,
            height: 3,
            color: Theme.of(context).focusColor,
          ),

          // plan creation date with calendar icon
          Row(
            spacing: 5,
            children: [
              Icon(Icons.calendar_month_outlined, size: 20),
              Text(
                '${settingsModelValues.translations.created} ${settingsModelValues.translations.formattedDate(widget.plan.creationDate)} ${widget.plan.creationDate.year}',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),

          // show plan properties if the properties button was pressed
          if (_propertiesExpanded)
            Row(
              spacing: 10,
              children: [
                TextButton.icon(
                  onPressed: _showDeletionPopup,
                  label: Text(
                    settingsModelValues.translations.delete,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  icon: Icon(Icons.delete_forever, color: Colors.white),
                ),
                TextButton.icon(
                  onPressed: null,
                  label: Text(
                    "Edit",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  icon: Icon(Icons.edit, color: Colors.white),

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
        ],
      ),
    );
  }
}
