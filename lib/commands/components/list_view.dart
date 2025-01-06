import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createListView() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_list_view.dart', '''
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final List<Widget> items;

  const CustomListView({
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: items,
    );
  }
}
''');
}
