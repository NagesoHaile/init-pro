import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createBottomNavigationBar() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_bottom_navigation_bar.dart', '''
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final List<BottomNavigationBarItem> items;

  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
    );
  }
}
''');
}
