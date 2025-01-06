import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomScaleTransition() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_scale_transition.dart', '''
import 'package:flutter/material.dart';

class CustomScaleTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const CustomScaleTransition({
    required this.animation,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: animation,
      child: child,
    );
  }
}
''');
}
