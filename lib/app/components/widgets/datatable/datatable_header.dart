import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';

List<DataColumn> datatableHeader(List<String> dataColumns) {
  return dataColumns
      .map(
        (dataColumn) => DataColumn(
          label: Paragraph(
            text: dataColumn,
            fontWeight: FontWeight.bold,
          ),
        ),
      )
      .toList();
}
