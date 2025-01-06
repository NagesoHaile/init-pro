import 'package:init_pro/utils/dirs_repository.dart';

import '../../utils/file_creator.dart';

void createCustomAppBar() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'custom_app_bar.dart', '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../colors/app_colors.dart';



class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize(this.toolbarHeight, this.bottomHeight)
      : super.fromHeight(
            (toolbarHeight ?? kToolbarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({
    super.key,
    required this.title,
    required this.actions,
    this.leadingRequired = true,
    this.bottom,
    this.toolbarHeight,
    this.textTabBars,
  }) : preferredSize = _PreferredAppBarSize(
          toolbarHeight,
          textTabBars != null
              ? kTextTabBarHeight
              : bottom?.preferredSize.height,
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leadingRequired!
          ? IconButton(
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.chevron_left,
                size: 30,
                color: AppColors.primaryLight,
              ),
            )
          : null,
      actions: actions,
      bottom: textTabBars != null ? _buildTextTabBar() : null,
    );
  }

  final String title;
  final List<Widget> actions;
  final bool? leadingRequired;
  final PreferredSizeWidget? bottom;
  final double? toolbarHeight;
  final List<String>? textTabBars;

  @override
  final Size preferredSize;

  PreferredSizeWidget _buildTextTabBar() {
    assert(textTabBars != null);
    return PreferredSize(
        preferredSize: const Size.fromHeight(kTextTabBarHeight),
        child: Material(
          color: AppColors.whiteAppColor,
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: ShapeDecoration(
                color: AppColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              indicatorColor: AppColors.primaryColor,
              labelColor: AppColors.secondaryColor,
              indicatorPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              overlayColor: WidgetStateProperty.all(AppColors.whiteAppColor),
              tabs: textTabBars!
                  .map(
                    (e) => Tab(text: e),
                  )
                  .toList()),
        ));
  }
}

''');
}
