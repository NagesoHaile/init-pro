import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createAlertDialog() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_alert_dialog.dart', '''
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final List<Widget> actions;

  const CustomAlertDialog({
    required this.title,
    required this.content,
    required this.actions,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: actions,
    );
  }
}

''');
}
