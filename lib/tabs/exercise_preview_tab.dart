import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:gym_app/hive/exercise.dart';
import 'package:gym_app/settings/settings_provider.dart';
import 'package:gym_app/utils/appBars/my_app_bar.dart';
import 'package:gym_app/utils/my_divider.dart';

class ExercisePreviewTab extends StatefulWidget {
  final Exercise exercise;
  final SettingsProvider settings;
  const ExercisePreviewTab({
    super.key,
    required this.exercise,
    required this.settings,
  });

  @override
  State<ExercisePreviewTab> createState() => _ExercisePreviewTabState();
}

class _ExercisePreviewTabState extends State<ExercisePreviewTab> {
  Timer? _timer;

  final String _defaultPath = './assets/exercises';
  String _path = "./assets/question-mark.png";

  int _imageIndex = 1;

  @override
  void initState() {
    super.initState();

    if (widget.exercise.images.isNotEmpty) {
      _path = '$_defaultPath/${widget.exercise.images[0]}';

      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _imageIndex = _imageIndex == 0 ? 1 : 0;
          _path = _imageIndex == 0
              ? '$_defaultPath/${widget.exercise.images[1]}'
              : '$_defaultPath/${widget.exercise.images[0]}';
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        // app bar
        MyAppBar(
          title: widget.exercise.name,
          automaticallyImplyLeading: true,
          actions: [],
        ),

        SliverPadding(
          padding: const EdgeInsets.all(15),
          sliver: SliverList.list(
            children: [
              if (widget.exercise.images.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(_path),
                ),

              const MyDivider(),

              if (widget.exercise.instructions != null)
                Text(
                  widget.settings.translations.instructions,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

              if (widget.exercise.instructions != null)
                AutoSizeText(
                  widget.exercise.instructions?.join('\n') ?? '',
                  style: const TextStyle(fontSize: 13),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
