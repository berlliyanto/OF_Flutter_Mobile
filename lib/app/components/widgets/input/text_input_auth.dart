import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class TextInputAuth extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String? label;
  final VoidCallback? onTap, onEditingComplete;
  final Function(String value) onSubmit;
  final Function(PointerDownEvent pointer)? onTapOutside;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool withPrefix;

  TextInputAuth(
      {required this.controller,
      this.textInputAction = TextInputAction.next,
      this.validator,
      required this.label,
      required this.onSubmit,
      this.onTap,
      this.onTapOutside,
      this.onEditingComplete,
      this.prefixIcon,
      required this.focusNode,
      this.withPrefix = true,
      this.keyboardType = TextInputType.text,
      super.key});

  final colors = ColorPicker();

  dynamic showIcon() {
    if (!withPrefix) {
      return null;
    }

    return Icon(prefixIcon);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      onTapOutside: onTapOutside,
      onTap: onTap,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: (value) => onSubmit(value),
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
        prefixIcon: showIcon(),
      ),
    );
  }
}
