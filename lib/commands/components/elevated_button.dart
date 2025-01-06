import 'package:init_pro/utils/dirs_repository.dart';

import '../../utils/file_creator.dart';

void createElevatedButton() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_elevated_button.dart', '''
import 'package:flutter/material.dart';
import '../colors/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const CustomElevatedButton({
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        textStyle: textStyle,
      ),
      child: Text(label),
    );
  }
}

''');
}
