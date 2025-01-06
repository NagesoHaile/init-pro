import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomAnimatedContainer() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_animated_container.dart', '''
import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Duration duration;
  final Curve curve;

  const CustomAnimatedContainer({
    required this.width,
    required this.height,
    required this.color,
    required this.duration,
    required this.curve,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      height: height,
      color: color,
      duration: duration,
      curve: curve,
    );
  }
}
''');
}
