import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../utils/screen_utils.dart';
import '../utils/text_theme.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;
  final int maxLines;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final double padding;
  const CustomTextField(
      {super.key,
        required this.controller,
        required this.hintText,
        this.obscureText = false,
        this.maxLines = 1,
        this.suffixIcon,
        this.prefixIcon,
        this.padding = 15
      });

  @override
  Widget build(BuildContext context) {
    double height = ScreenUtils.height(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: blackColor.withOpacity(0.25),
                offset: const Offset(0, 1),
                blurRadius: 10,
                spreadRadius: 1)
          ]),
      child: TextFormField(
        maxLines: maxLines,
        style: TextStyle(fontSize: height * 0.0176, color: textColor),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
                fontSize: CustomTextTheme.extraSmallFontSize(context),
                color: textColor.withOpacity(0.5)),
            border: InputBorder.none,
            contentPadding: EdgeInsets.all(padding),
            suffixIcon: (suffixIcon != null) ? suffixIcon : null,
            prefixIcon: prefixIcon,
            // enabledBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: darkBlueColor),
            //   borderRadius: BorderRadius.circular(20),
            // ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            )),
      ),
    );
  }
}
