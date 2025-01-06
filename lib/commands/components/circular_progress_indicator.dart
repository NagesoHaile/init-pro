import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomCircularProgressIndicator() {
  final coreDir = DirsRepository.coreDir();
  createFile(
      '${coreDir.path}/widgets', 'custom_circular_progress_indicator.dart', '''
import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatelessWidget {
  final double? value;

  const CustomCircularProgressIndicator({
    this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
    );
  }
}
''');
}
