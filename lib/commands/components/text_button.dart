import 'package:init_pro/utils/dirs_repository.dart';

import '../../utils/file_creator.dart';

void createTextButton() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_text_button.dart', '''
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;

  const CustomTextButton({
    required this.label,
    required this.onPressed,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        textStyle: textStyle ?? Theme.of(context).textTheme.button,
      ),
      child: Text(label),
    );
  }
}
''');
}
