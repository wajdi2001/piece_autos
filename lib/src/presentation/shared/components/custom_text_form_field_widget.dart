import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/app_colors.dart';


class CustomTextFormField extends StatelessWidget {
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final TextEditingController myController;
  final Widget? suffixIcon;
  final bool obsecureText;
  final String? Function(String?)? validator;
  final TextInputType inputType;
  final int? maxLines;
  final bool? enabled;
  final void Function(String)? onFieldSubmitted;
  final void Function(String)? onChange;
  final List<TextInputFormatter>? inputFormatter;
  final double? verticalPadding;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final void Function()? onTap;
  final Color? filledColor;
  final Color? borderColor;
  final TextAlign? textAlign;

  final FocusNode? node;
  const CustomTextFormField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.labelText,
    required this.myController,
    this.validator,
    this.inputType = TextInputType.text,
    this.obsecureText = false,
    this.maxLines,
    this.enabled,
    this.onFieldSubmitted,
    this.node,
    this.onTap,
    this.borderColor,
    this.filledColor,
    this.onChange,
    this.textAlign,
    this.inputFormatter,
    this.verticalPadding,
    this.prefixWidget,
    this.suffixWidget,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatter,
      focusNode: node,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      enabled: enabled,
      validator: validator,
      obscureText: obsecureText,
      keyboardType: inputType,
      cursorHeight: 15,
      autofocus: false,
      controller: myController,
      maxLines: maxLines ?? 1,
      textAlign: textAlign ?? TextAlign.start,
      onChanged: onChange,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: Colors.black,
        fontFamily: "Montserrat",
      ),
      decoration: buildTextFieldDecoration(
          borderColor: borderColor,
          filledColor: filledColor,
          hintText: hintText,
          labelText: labelText,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          verticalPadding: verticalPadding,
          prefix: prefixWidget,
          suffixWidget: suffixWidget),
    );
  }
}

buildTextFieldDecoration({
  Color? filledColor,
  Widget? suffixIcon,
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? prefix,
  Color? borderColor,
  double? verticalPadding,
  Widget? suffixWidget,
}) =>
    InputDecoration(
      isDense: true,
      labelStyle: TextStyle(
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      hintStyle: TextStyle(
        fontSize: 11,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w300,
      ),
      errorStyle: TextStyle(
        color: Colors.red,
        fontSize: 12,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
      ),
      labelText: labelText,
      hintText: hintText,
      prefix: prefix,
      suffix: suffixWidget,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      focusColor: Colors.white,
      filled: filledColor != null,
      fillColor: filledColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: (1.8) , vertical: verticalPadding ?? (2)),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
            color: borderColor ?? AppColors.primaryRedColor, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
            color: borderColor ?? AppColors.primaryRedColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        gapPadding: 0.0,
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
            color: borderColor ?? AppColors.primaryRedColor, width: 1),
      ),
    );
