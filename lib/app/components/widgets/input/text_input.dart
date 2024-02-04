import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

// Widget textInput({
//   required double width,
//   required ColorPicker colors,
//   required Function(String value) onChanged,
//   required String hint,
//   required Function(PointerDownEvent pointer)? onTapOutside,
//   VoidCallback? onTap,
//   String? errorText,
//   TextInputType keyboardType = TextInputType.text,
//   int? maxLength,
//   bool withSuffix = false,
//   bool isFocus = false,
//   IconData? suffixIcon,
//   FocusNode? focusNode,
//   int? maxLines,
//   String? label,
// }) {
//   Widget showErrorText() {
//     if (errorText == null || errorText == "") {
//       return const SizedBox();
//     }

//     return Padding(
//       padding: const EdgeInsets.only(left: 5, top: 3),
//       child: Paragraph(
//         text: errorText,
//         color: const Color(0xFFE62E00),
//         fontSize: 12,
//         textAlign: TextAlign.start,
//       ),
//     );
//   }

//   Color setBorderColor() {
//     if (errorText == null || errorText == "") {
//       return colors.primaryBlack;
//     }

//     if (isFocus) {
//       return colors.cyanDark;
//     }

//     return const Color(0xFFE62E00);
//   }

//   dynamic showSuffix() {
//     if (withSuffix) {
//       return Icon(
//         suffixIcon,
//         color: colors.primaryBlack,
//       );
//     }

//     return null;
//   }

//   return Column(
//     mainAxisAlignment: MainAxisAlignment.start,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       if (label != null)
//         Padding(
//           padding: const EdgeInsets.only(bottom: 5),
//           child: Paragraph(text: label, color: colors.primaryBlack),
//         ),
//       Container(
//           width: width,
//           alignment: Alignment.center,
//           padding: const EdgeInsets.only(right: 10),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             color: colors.whiteSmoke,
//             border: Border.all(color: setBorderColor(), width: 1),
//           ),
//           child: TextField(
//             focusNode: focusNode,
//             maxLength: maxLength,
//             maxLines: maxLines,
//             keyboardType: keyboardType,
//             onChanged: onChanged,
//             onTap: onTap,
//             onTapOutside: onTapOutside,
//             decoration: InputDecoration(
//               counterText: "",
//               contentPadding: const EdgeInsets.only(left: 10),
//               border: InputBorder.none,
//               hintText: hint,
//               hintStyle: TextStyle(
//                 color: colors.primaryBlack,
//                 fontSize: 16,
//               ),
//               suffixIcon: showSuffix(),
//               suffixIconConstraints: const BoxConstraints(
//                 minWidth: 0,
//                 minHeight: 0,
//               ),
//             ),
//           )),
//       showErrorText()
//     ],
//   );
// }

class TextInput extends StatelessWidget {
  final double width;
  final ColorPicker colors;
  final Function(String value) onChanged;
  final VoidCallback? onTap;
  final Function(PointerDownEvent pointer)? onTapOutside;
  final String hint;
  final dynamic errorText;
  final TextInputType keyboardType;
  final int? maxLength;
  final bool withSuffix, isFocus, isEnabled;
  final IconData? suffixIcon;
  final FocusNode? focusNode;
  final int? maxLines;
  final String? label;
  final TextEditingController? controller;
  const TextInput(
      {required this.width,
      required this.colors,
      required this.onChanged,
      required this.hint,
      this.controller,
      this.onTapOutside,
      this.onTap,
      this.focusNode,
      this.errorText,
      this.keyboardType = TextInputType.text,
      this.maxLength,
      this.withSuffix = false,
      this.isFocus = false,
      this.suffixIcon,
      this.maxLines = 1,
      this.label,
      this.isEnabled = true,
      super.key});

  Widget showErrorText() {
    if (errorText == null || errorText == "") {
      return const SizedBox();
    }

    return Padding(
      padding: const EdgeInsets.only(left: 5, top: 3),
      child: Paragraph(
        text: errorText,
        color: const Color(0xFFE62E00),
        fontSize: 12,
        textAlign: TextAlign.start,
      ),
    );
  }

  Color setBorderColor() {
    if (errorText == null || errorText == "") {
      return colors.primaryBlack;
    }

    if (isFocus) {
      return colors.cyanDark;
    }

    return const Color(0xFFE62E00);
  }

  dynamic showSuffix() {
    if (withSuffix) {
      return Icon(
        suffixIcon,
        color: colors.primaryBlack,
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Paragraph(text: label!, color: colors.primaryBlack),
          ),
        Container(
            width: width,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.whiteSmoke,
              border: Border.all(color: setBorderColor(), width: 1),
            ),
            child: TextField(
              enabled: isEnabled,
              controller: controller,
              focusNode: focusNode,
              maxLength: maxLength,
              maxLines: maxLines,
              keyboardType: keyboardType,
              onChanged: onChanged,
              onTap: onTap,
              onTapOutside: onTapOutside,
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.only(left: 10),
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  color: colors.primaryBlack,
                  fontSize: 16,
                ),
                suffixIcon: showSuffix(),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
            )),
        showErrorText()
      ],
    );
  }
}
