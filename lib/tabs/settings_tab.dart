import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/extensions/string_extensions.dart';
import 'package:gym_app/hive/language.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/animated_box.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_segmented_button.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  final SettingsProvider settings;
  const SettingsTab({super.key, required this.settings});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  final TextEditingController _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  Language? _language;
  WeightUnit? _weightUnit;

  void _save() {
    if (_formKey.currentState!.validate()) {
      SettingsProvider settings = context.read<SettingsProvider>();

      if (_language != null) {
        settings.changeLanguage(language: _language!);
      }

      if (_weightUnit != null) {
        settings.changeWeightUnit(weightUnit: _weightUnit!);
      }

      settings.setWeekWorkoutsGoal(int.parse(_controller.text));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            spacing: 15,
            children: [
              const Icon(Icons.check, color: Colors.white),
              Text(context.read<SettingsProvider>().translations.saved),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.text = context
        .read<SettingsProvider>()
        .weekWorkoutsGoal
        .toString();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        MyAppBar(title: widget.settings.translations.settings, actions: []),
        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverToBoxAdapter(
            child: Form(
              key: _formKey,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                children: [
                  CustomCard(
                    index: 0,
                    title: widget.settings.translations.language,
                    children: [
                      MySegmentedButton(
                        segments: {"English", "Polski"},
                        multiSelection: false,
                        minSelection: 1,
                        initialValues: {
                          widget.settings.getLanguageNameString(
                            widget.settings.language,
                          ),
                        },
                        onChanged: (_, value, _) => setState(
                          () => _language = value == "English"
                              ? Language.en
                              : Language.pl,
                        ),
                      ),
                    ],
                  ),

                  const MyDivider(),

                  CustomCard(
                    index: 1,
                    title: widget.settings.translations.weightUnit
                        .toUpperCase(),
                    children: [
                      MySegmentedButton(
                        segments: {"Kg", "Lbs"},
                        multiSelection: false,
                        minSelection: 1,
                        initialValues: {
                          widget.settings.weightUnit.name
                              .firstToUpperRestToLower(),
                        },
                        onChanged: (_, value, _) => setState(
                          () => value == "Kg" ? WeightUnit.kg : WeightUnit.lbs,
                        ),
                      ),
                    ],
                  ),

                  const MyDivider(),

                  CustomCard(
                    index: 2,
                    title: widget.settings.translations.weeklyTrainingGoal,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: TextFormField(
                          controller: _controller,
                          textAlignVertical: TextAlignVertical.center,
                          enableSuggestions: false,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null ||
                                int.tryParse(value) == null ||
                                value.isEmpty) {
                              return widget
                                  .settings
                                  .translations
                                  .pleaseEnterACorrectNumber;
                            }
                            int intValue = int.parse(value);
                            if (intValue < 0 || intValue > 7) {
                              return widget
                                  .settings
                                  .translations
                                  .weeklyGoalNumberMustBe;
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: widget.settings.weekWorkoutsGoal
                                .toString(),
                            suffixIcon: const Icon(Icons.onetwothree),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const MyDivider(),

                  AnimatedBox(
                    index: 3,
                    child: TextButton.icon(
                      onPressed: _save,
                      label: Text(
                        widget.settings.translations.save,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      icon: const Icon(Icons.save),
                      iconAlignment: IconAlignment.end,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
