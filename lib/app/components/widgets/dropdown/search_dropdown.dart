import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Widget searchDropdown({
  required String hint,
  required ColorPicker colors,
  required FutureOr<List<Map<String, dynamic>>> Function(String)
      suggestionsCallback,
  required Function(Map<String, dynamic>?) onSelected,
  required TextEditingController textEditingController,
  ScrollController? scrollController,
}) {
  return TypeAheadField<Map<String, dynamic>>(
    scrollController: scrollController,
    suggestionsCallback: suggestionsCallback,
    controller: textEditingController,
    debounceDuration: 500.ms,
    loadingBuilder: (context) {
      return Column(
        children: [
          const Gap(150),
          Center(
            child: CircularProgressIndicator(
              backgroundColor: colors.cyanDark,
              color: colors.cyan,
            ),
          ),
        ],
      );
    },
    builder: (context, controller, focusNode) {
      return Container(
          width: Get.width,
          alignment: Alignment.center,
          padding: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.whiteSmoke,
            border: Border.all(color: colors.primaryBlack, width: 1),
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(left: 10),
              border: InputBorder.none,
              hintText: hint,
              hintStyle: TextStyle(
                color: colors.primaryBlack,
                fontSize: 16,
              ),
            ),
            onTapOutside: (event) => focusNode.unfocus(),
          ));
    },
    itemBuilder: (context, suggestion) {
      return ListTile(
        title: Text(suggestion['name'].toString()),
      );
    },
    onSelected: onSelected,
    decorationBuilder: (context, child) {
      return Material(
        type: MaterialType.card,
        elevation: 4,
        borderRadius: BorderRadius.circular(8),
        child: child,
      );
    },
    offset: const Offset(0, 12),
    constraints: const BoxConstraints(maxHeight: 500),
  );
}
