import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Widget singleDropdownLess({
  required List<dynamic> data,
  required String hint,
  required double width,
  required ColorPicker colors,
  required dynamic value,
  required Function(dynamic value) onChanged,
}) {
  return Container(
    padding: const EdgeInsets.only(left: 10),
    height: 50,
    width: width,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors.whiteSmoke,
        border: Border.all(color: colors.primaryBlack)),
    child: DropdownButton(
      hint: Paragraph(
        text: hint,
        fontSize: 16,
      ),
      isExpanded: true,
      items: data.map((e) {
        String name = "";
        if (e['name'].contains("Shift")) {
          name = e['id'].toString();
        } else {
          name = e['name'];
        }
        return DropdownMenuItem(
          value: e['id'],
          child: Text(name),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
      underline: const SizedBox(),
    ),
  );
}

class SingleDropdownLess extends StatelessWidget {
  final String hint;
  final List<dynamic> data;
  final double width;
  final ColorPicker colors;
  final dynamic value;
  final Function(dynamic value) onChanged;
  const SingleDropdownLess(
      {required this.data,
      required this.hint,
      required this.width,
      required this.colors,
      required this.onChanged,
      required this.value,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 50,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.whiteSmoke,
          border: Border.all(color: colors.primaryBlack)),
      child: DropdownButton(
        hint: Paragraph(
          text: hint,
          fontSize: 16,
        ),
        isExpanded: true,
        items: data
            .map(
              (e) => DropdownMenuItem(
                value: e['id'],
                child: Text(e['name']),
              ),
            )
            .toList(),
        onChanged: onChanged,
        value: value,
        underline: const SizedBox(),
      ),
    );
  }
}
