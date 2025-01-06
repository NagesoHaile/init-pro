import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomBadge() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_badge.dart', '''
import 'package:flutter/material.dart';

class CustomBadge extends StatelessWidget {
  final String label;
  final Color? color;
  final TextStyle? textStyle;

  const CustomBadge({
    required this.label,
    this.color,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: textStyle ??
            const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}
''');
}
