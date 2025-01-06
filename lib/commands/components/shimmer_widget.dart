import 'package:init_pro/utils/dirs_repository.dart';

import '../../utils/file_creator.dart';

void createShimmerWidget() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'shimmer_widget.dart', '''

/// if you haven't added the shimmer package to
/// your pubspec.yaml file yet. please add it by 
/// running `flutter pub add shimmer` in 
/// your terminal ( cmd )

import 'package:flutter/material.dart';
import 'package:centy/core/colors/app_colors.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final double borderRadius;

  const ShimmerWidget.rectangular(
      {super.key,
      this.width = double.infinity,
      this.borderRadius = 10,
      required this.height})
      : shape = BoxShape.rectangle;

  const ShimmerWidget.circular(
      {super.key,
      this.width = double.infinity,
      required this.height,
      this.borderRadius = 0,
      this.shape = BoxShape.circle});

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: AppColors.lightGrey,
        highlightColor: Colors.grey.shade400,
        period: const Duration(seconds: 2),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: shape == BoxShape.rectangle
                ? BorderRadius.circular(borderRadius)
                : null,
            shape: shape,
            color: Colors.grey[400]!,
          ),
        ),
      );
}
''');
}
