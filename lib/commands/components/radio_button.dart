import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomRadioButton() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_radio_button.dart', '''
import 'package:flutter/material.dart';

class CustomRadioButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;

  const CustomRadioButton({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        if (label != null) Text(label!),
      ],
    );
  }
}
''');
}
