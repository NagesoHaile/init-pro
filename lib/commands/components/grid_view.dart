import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createGridView() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_grid_view.dart', '''
import 'package:flutter/material.dart';

class CustomGridView extends StatelessWidget {
  final List<Widget> items;
  final int crossAxisCount;

  const CustomGridView({
    required this.items,
    required this.crossAxisCount,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      children: items,
    );
  }
}

''');
}
