import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class TextInput extends StatelessWidget {
  final double width;
  final ColorPicker colors;
  final Function(String value) onChanged;
  final VoidCallback onTap;
  final String hint;
  final dynamic errorText;
  final TextInputType keyboardType;
  final int? maxLength;
  const TextInput(
      {required this.width,
      required this.colors,
      required this.onChanged,
      required this.hint,
      required this.onTap,
      this.errorText,
      this.keyboardType = TextInputType.text,
      this.maxLength,
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

    return const Color(0xFFE62E00);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteSmoke,
            border: Border.all(color: setBorderColor(), width: 1),
          ),
          child: TextField(
            maxLength: maxLength,
            keyboardType: keyboardType,
            onChanged: onChanged,
            onTap: onTap,
            decoration: InputDecoration(
              counterText: "",
              contentPadding: const EdgeInsets.only(left: 10),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: colors.primaryBlack,
                fontSize: 16,
              ),
            ),
          ),
        ),
        showErrorText()
      ],
    );
  }
}
