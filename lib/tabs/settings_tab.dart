import 'package:flutter/material.dart';
import 'package:gym_app/data/data_provider.dart';
import 'package:gym_app/extensions/string_extensions.dart';
import 'package:gym_app/hive/language.dart';
import 'package:gym_app/hive/weight_unit.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/custom_card.dart';
import 'package:gym_app/utils/my_divider.dart';
import 'package:gym_app/utils/my_segmented_button.dart';
import 'package:provider/provider.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saving...")));

      SettingsProvider settings = context.read<SettingsProvider>();

      if (_language != null) {
        settings.changeLanguage(language: _language!);
      }

      if (_weightUnit != null) {
        settings.changeWeightUnit(weightUnit: _weightUnit!);
      }

      settings.setWeekWorkoutsGoal(int.parse(_controller.text));
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
    return Consumer2<SettingsProvider, DataProvider>(
      builder: (context, settings, appData, child) => CustomScrollView(
        slivers: [
          MyAppBar(title: settings.translations.settings, actions: []),
          SliverPadding(
            padding: const EdgeInsets.all(15),
            sliver: SliverToBoxAdapter(
              child: Form(
                key: _formKey,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    CustomCard(
                      title: settings.translations.language,
                      children: [
                        MySegmentedButton(
                          segments: {"English", "Polski"},
                          multiSelection: false,
                          minSelection: 1,
                          initialValues: {
                            settings.getLanguageNameString(settings.language),
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
                      title: settings.translations.weightUnit.toUpperCase(),
                      children: [
                        MySegmentedButton(
                          segments: {"Kg", "Lbs"},
                          multiSelection: false,
                          minSelection: 1,
                          initialValues: {
                            settings.weightUnit.name.firstToUpperRestToLower(),
                          },
                          onChanged: (_, value, _) => setState(
                            () =>
                                value == "Kg" ? WeightUnit.kg : WeightUnit.lbs,
                          ),
                        ),
                      ],
                    ),

                    const MyDivider(),

                    CustomCard(
                      title: settings.translations.weeklyTrainingGoal,
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
                                return settings
                                    .translations
                                    .pleaseEnterACorrectNumber;
                              }
                              int intValue = int.parse(value);
                              if (intValue < 0 || intValue > 7) {
                                return settings
                                    .translations
                                    .weeklyGoalNumberMustBe;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: settings.weekWorkoutsGoal.toString(),
                              suffixIcon: const Icon(Icons.onetwothree),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const MyDivider(),

                    TextButton.icon(
                      onPressed: _save,
                      label: Text(
                        settings.translations.save,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      icon: const Icon(Icons.save),
                      iconAlignment: IconAlignment.end,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
