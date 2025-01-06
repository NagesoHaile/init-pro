import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomHero() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_hero.dart', '''
import 'package:flutter/material.dart';

class CustomHero extends StatelessWidget {
  final String tag;
  final Widget child;

  const CustomHero({
    required this.tag,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: child,
    );
  }
}
''');
}
