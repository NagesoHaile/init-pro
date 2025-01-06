import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomDropdownButton() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_dropdown_button.dart', '''
import 'package:flutter/material.dart';

class CustomDropdownButton<T> extends StatelessWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final String? hint;

  const CustomDropdownButton({
    required this.value,
    required this.items,
    required this.onChanged,
    this.hint,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      value: value,
      items: items,
      onChanged: onChanged,
      hint: hint != null ? Text(hint!) : null,
      isExpanded: true,
      underline: Container(
        height: 1,
        color: Theme.of(context).dividerColor,
      ),
    );
  }
}
''');
}
