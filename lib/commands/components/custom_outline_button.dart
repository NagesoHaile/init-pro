import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomOutlineButton() {
  final coreDir = DirsRepository.coreDir();

  createFile('${coreDir.path}/widgets', 'custom_outline_button.dart', '''
import 'package:flutter/material.dart';

class CustomOutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;

  const CustomOutlineButton({
    required this.label,
    required this.onPressed,
    this.textStyle,
    this.borderColor,
    this.borderWidth = 2.0,
    this.padding,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: borderColor ?? Theme.of(context).colorScheme.primary,
          width: borderWidth,
        ),
        padding: padding,
        textStyle: textStyle ?? Theme.of(context).textTheme.button,
      ),
      child: Text(label),
    );
  }
}

''');
}
