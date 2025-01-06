import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomScrollViewWidget() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_scroll_view_widget.dart', '''
import 'package:flutter/material.dart';

class CustomScrollViewWidget extends StatelessWidget {
  final List<Widget> slivers;

  const CustomScrollViewWidget({
    required this.slivers,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: slivers,
    );
  }
}
''');
}
