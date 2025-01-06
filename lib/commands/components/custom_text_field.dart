import 'package:init_pro/utils/dirs_repository.dart';
import 'package:init_pro/utils/file_creator.dart';

void createCustomTextField() {
  final coreDir = DirsRepository.coreDir();
  createFile('${coreDir.path}/widgets', 'app_text_field.dart', '''
/// if you don't have app_colors.dart file
/// please add it by running this command
///  in your terminal or cmd
/// `dart pub run init_pro init`
/// it will automatically add app_colors.dart in 
/// core/colors/ directory.S

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/app_colors.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final Widget? prefix;
  final Widget? prefixIcon;
  final Widget? suffix;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final int? maxLength;
  final void Function()? onTap;
  final bool? enabled;
  final TextStyle? hintStyle;
  final String? hintText;
  final TextStyle? labelStyle;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final Color? focusColor;
  final Color? focusedBorderColor;
  final Color? textColor;
  const AppTextField({
    super.key,
    this.controller,
    required this.label,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.prefix,
    this.prefixIcon,
    this.suffix,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.maxLength,
    this.onTap,
    this.enabled,
    this.inputFormatters,
    this.hintStyle,
    this.hintText,
    this.labelStyle,
    this.borderColor,
    this.focusedBorderColor,
    this.focusColor,
    this.textColor
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      inputFormatters: inputFormatters,
      style:  TextStyle(color:textColor ?? Colors.white),
      onTap: onTap,
      enabled: enabled,
      decoration: InputDecoration(
        focusedBorder:  OutlineInputBorder(borderSide: BorderSide(color: focusedBorderColor ??  AppColors.whiteAppColor)),
        focusColor:focusColor ?? Colors.white,
        counterText: "",
        label: Text(label),
        hoverColor: Colors.black,
        prefix: prefix,
        prefixIcon: prefixIcon,
        suffix: suffix,
        suffixIcon: suffixIcon,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: hintStyle,
        border:  OutlineInputBorder(
          borderSide:  BorderSide(color:borderColor ?? AppColors.whiteAppColor)
        )
      ),
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      obscureText: obscureText,
      maxLength: maxLength,
    );
  }
}
''');
}
