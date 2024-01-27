import 'package:flutter/material.dart';

List<DataColumn> datatableHeader(List<String> dataColumns) {
  return dataColumns
      .map(
        (dataColumn) => DataColumn(
          label: Text(
            dataColumn.toString(),
          ),
        ),
      )
      .toList();
}
