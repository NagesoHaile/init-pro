import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomLinearProgressIndicator() {
  final coreDir = DirsRepository.coreDir();
  createFile(
      '${coreDir.path}/widgets', 'custom_linear_progress_indicator.dart', '''
import 'package:flutter/material.dart';

class CustomLinearProgressIndicator extends StatelessWidget {
  final double? value;

  const CustomLinearProgressIndicator({
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
    );
  }
}

''');
}
