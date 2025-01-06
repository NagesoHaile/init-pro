import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomGirdTile() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_grid_tile.dart', '''
import 'package:flutter/material.dart';

class CustomGridTile extends StatelessWidget {
  final Widget child;
  final Widget? footer;
  final Widget? header;

  const CustomGridTile({
    required this.child,
    this.footer,
    this.header,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: child,
      footer: footer,
      header: header,
    );
  }
}
''');
}
