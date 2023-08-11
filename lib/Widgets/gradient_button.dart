import 'package:flutter/material.dart';
import '../Styles/colors.dart';

Widget gradientButton({
  VoidCallback? tap,
  bool? status = false,
  String? text = 'Save',
  BuildContext? context,
}) {
  return GestureDetector(
    onTap: status == true ? null : tap,
    child: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Pallete.gradient1,
            Pallete.gradient2,
            Pallete.gradient3,
          ],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Container(
        width: 395,
        height: 55,
        alignment: Alignment.center,
        child: Text(
          status == false ? text! : 'Please wait...',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    ),
  );
}
