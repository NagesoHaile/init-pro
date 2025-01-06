import 'package:args/command_runner.dart';
import 'package:init_pro/commands/components/alert_dialog.dart';
import 'package:init_pro/commands/components/animated_container.dart';
import 'package:init_pro/commands/components/badge.dart';
import 'package:init_pro/commands/components/bottom_navigation_bar.dart';
import 'package:init_pro/commands/components/bottom_sheet.dart';
import 'package:init_pro/commands/components/card.dart';
import 'package:init_pro/commands/components/checkbox.dart';
import 'package:init_pro/commands/components/chip.dart';
import 'package:init_pro/commands/components/circle_avatar.dart';
import 'package:init_pro/commands/components/circular_progress_indicator.dart';
import 'package:init_pro/commands/components/custom_app_bar.dart';
import 'package:init_pro/commands/components/custom_outline_button.dart';
import 'package:init_pro/commands/components/custom_scroll_view.dart';
import 'package:init_pro/commands/components/custom_text_field.dart';
import 'package:init_pro/commands/components/custom_toast.dart';
import 'package:init_pro/commands/components/dropdown_button.dart';
import 'package:init_pro/commands/components/elevated_button.dart';
import 'package:init_pro/commands/components/fade_transition.dart';
import 'package:init_pro/commands/components/grid_tile.dart';
import 'package:init_pro/commands/components/grid_view.dart';
import 'package:init_pro/commands/components/hero.dart';
import 'package:init_pro/commands/components/linear_progress_indicator.dart';
import 'package:init_pro/commands/components/list_tile.dart';
import 'package:init_pro/commands/components/list_view.dart';
import 'package:init_pro/commands/components/popup_menu_button.dart';
import 'package:init_pro/commands/components/radio_button.dart';
import 'package:init_pro/commands/components/scale_transition.dart';
import 'package:init_pro/commands/components/search_field.dart';
import 'package:init_pro/commands/components/shimmer_widget.dart';
import 'package:init_pro/commands/components/slider.dart';
import 'package:init_pro/commands/components/tab_bar.dart';
import 'package:init_pro/commands/components/text_button.dart';

class AddComponentCommand extends Command {
  @override
  String get description =>
      'Adds reusable boilerplate code of a component[Widgets]';

  @override
  String get name => 'add-component';

  @override
  String get usage => '''
Usage: init_pro add-component <component-name>
Generate boilerplate for:
  - Adds a component to lib/core/widgets directory
Example:
  init_pro add-component elevated-button
  ''';

  @override
  Future<void> run() async {
    if (argResults == null || argResults!.rest.isEmpty) {
      print('Error: Component name is required.');
      print(usage);
      return;
    }
    final componentName = argResults!.rest[0];
    print('Generating component: $componentName...');
    createComponent(componentName);
  }
}

void createComponent(String componentName) {
  switch (componentName.toLowerCase()) {
    case 'app-bar':
      createCustomAppBar();
      break;
    case 'alert-dialog':
      createAlertDialog();
      break;
    case 'animated-container':
      createCustomAnimatedContainer();
      break;
    case 'badge':
      createCustomBadge();
      break;
    case 'bottom-navigation-bar':
      createBottomNavigationBar();
      break;
    case 'bottom-sheet':
      createBottomSheet();
      break;
    case 'card':
      createCustomCard();
      break;
    case 'checkbox':
      createCustomCheckbox();
      break;
    case 'chip':
      createCustomChip();
      break;
    case 'circle-avatar':
      createCustomAvatar();
      break;
    case 'circular-progress-indicator':
      createCustomCircularProgressIndicator();
      break;
    case 'linear-progress-indicator':
      createCustomLinearProgressIndicator();
      break;
    case 'outline-button':
      createCustomOutlineButton();
      break;
    case 'custom-scroll-view':
      createCustomScrollViewWidget();
      break;
    case 'text-field':
      createCustomTextField();
      break;
    case 'toast':
      createCustomToast();
      break;
    case 'dropdown-button':
      createCustomDropdownButton();
      break;
    case 'elevated-button':
      createElevatedButton();
      break;
    case 'fade-transition':
      createCustomFadeTransition();
      break;
    case 'scale-transition':
      createCustomScaleTransition();
      break;
    case 'hero':
      createCustomHero();
      break;
    case 'grid-tile':
      createCustomGirdTile();
      break;
    case 'grid-view':
      createGridView();
      break;
    case 'list-tile':
      createCustomListTile();
      break;
    case 'list-view':
      createListView();
      break;
    case 'popup-menu-button':
      createCustomPopupMenuButton();
      break;
    case 'radio-button':
      createCustomRadioButton();
      break;
    case 'search-field':
      createCustomSearchField();
      break;
    case 'shimmer':
      createShimmerWidget();
      break;
    case 'slider':
      createCustomSlider();
      break;
    case 'tab-bar':
      createCustomTabBar();
      break;
    case 'text-button':
      createTextButton();
      break;
    default:
      print('Component $componentName is not supported yet.');
  }
}
