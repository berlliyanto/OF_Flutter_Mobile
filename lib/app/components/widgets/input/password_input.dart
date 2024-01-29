import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class TextInputPassword extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? label;
  final VoidCallback? onTap, onEditingComplete, toggleObscure;
  final Function(PointerDownEvent pointer)? onTapOutside;
  final bool isObscure;
  final IconData prefixIcon;
  final FocusNode focusNode;

  TextInputPassword(
      {required this.controller,
      this.validator,
      required this.label,
      required this.focusNode,
      this.onTap,
      this.onTapOutside,
      this.toggleObscure,
      this.onEditingComplete,
      required this.isObscure,
      required this.prefixIcon,
      super.key});

  final colors = ColorPicker();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      keyboardType: TextInputType.visiblePassword,
      obscureText: isObscure,
      onTapOutside: onTapOutside,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 12),
        focusColor: colors.cyanDark,
        focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: colors.cyanDark, width: 2)),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFE62E00),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        labelText: label,
        suffixIcon: IconButton(
          onPressed: toggleObscure,
          icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
        ),
        prefixIcon: Icon(prefixIcon),
      ),
    );
  }
}
