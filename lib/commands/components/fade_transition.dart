import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomFadeTransition() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_fade_transition.dart', '''
import 'package:flutter/material.dart';

class CustomFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const CustomFadeTransition({
    required this.animation,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }
}
''');
}
