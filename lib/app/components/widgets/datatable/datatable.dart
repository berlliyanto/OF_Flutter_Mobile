import 'package:flutter/material.dart';

PaginatedDataTable dataTable({
  required List<DataColumn> dataColumns,
  required DataTableSource source,
  required int rowsPerPage,
  void Function(int value)? onPageChanged,
  void Function(int? value)? onRowsPerPageChanged,
  List<int>? availableRowsPerPage,
}) {
  return PaginatedDataTable(
    columns: dataColumns,
    source: source,
    onPageChanged: onPageChanged,
    onRowsPerPageChanged: onRowsPerPageChanged,
    availableRowsPerPage: const [10, 25, 50, 100],
    showFirstLastButtons: true,
    columnSpacing: 100,
    horizontalMargin: 60,
    dataRowMinHeight: 50,
    dataRowMaxHeight: 70,
    rowsPerPage: rowsPerPage,
  );
}
