import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class CheckHistorySource extends DataTableSource {
  final List<Map<String, dynamic>> data = [
    {
      'form_code': 'CL000000123',
      'created_at': '2023-01-01 00:00:00',
      'unit_code': "SOE 1902",
      'hour_meter': 8.9,
      'operator': "Agus",
      'shift': 1,
      'pallet_amount': 20,
      'verification_supervisor': "2023-01-01 00:00:00",
      'verification_user': "2023-01-01 00:00:00",
    },
    {
      'form_code': 'CL000000123',
      'created_at': '2023-01-01 00:00:00',
      'unit_code': "SOE 1902",
      'hour_meter': 8.9,
      'operator': "Agus",
      'shift': 1,
      'pallet_amount': 20,
      'verification_supervisor': "2023-01-01 00:00:00",
      'verification_user': "2023-01-01 00:00:00",
    },
    {
      'form_code': 'CL000000123',
      'created_at': '2023-01-01 00:00:00',
      'unit_code': "SOE 1902",
      'hour_meter': 8.9,
      'operator': "Agus",
      'shift': 1,
      'pallet_amount': 20,
      'verification_supervisor': "2023-01-01 00:00:00",
      'verification_user': "2023-01-01 00:00:00",
    },
  ];

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<Map<String, dynamic>> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  // void updateDataFromController(List<AssignmentModel> tasks) {
  //   final newData = tasks.map((item) {
  //     return AssignmentModel(
  //       id: item.id,
  //       assignBy: item.assignBy,
  //       codeCS: item.codeCS,
  //       area: item.area,
  //       location: item.location,
  //       tasks: item.tasks,
  //       tasksDetail: item.tasksDetail,
  //       status: item.status,
  //       duration: item.duration,
  //       supervisorId: item.supervisorId,
  //       checkedSupervisorAt: item.checkedSupervisorAt,
  //       verifiedDanoneAt: item.verifiedDanoneAt,
  //       createdAt: item.createdAt,
  //       startAt: item.startAt,
  //       finishAt: item.finishAt,
  //     );
  //   }).toList();

  //   updateData(newData);
  // }

  // void sort<T>(
  //   Comparable<T> Function(AssignmentModel) getField,
  //   String columnName,
  //   int columnIndex,
  //   bool sortAscending,
  // ) {
  //   //sortColumn.updateAll((key, value) => SortOrder.none);

  //   if (sortColumn[columnName] == SortOrder.ascending) {
  //     sortColumn[columnName] = SortOrder.descending;
  //   } else {
  //     sortColumn[columnName] = SortOrder.ascending;
  //   }

  //   data.sort((a, b) {
  //     final aValue = getField(a);
  //     final bValue = getField(b);
  //     return sortColumn[columnName] == SortOrder.ascending
  //         ? aValue.compareTo(bValue as T)
  //         : bValue.compareTo(aValue as T);
  //   });

  //   notifyListeners();
  // }

  void setRow(int total, int currentPagee, int perPagee) {
    totalRow = total;
    currentPage = currentPagee;
    perPage = perPagee;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    final dataRow = data[index];
    return DataRow(
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(Get.context!).colorScheme.primary.withOpacity(0.08);
        }
        return data.indexOf(dataRow) % 2 == 0
            ? colors.cyanDark.withOpacity(0.1)
            : colors.whiteSmoke;
      }),
      cells: [
        DataCell(
          Text(
            (index + 1).toString(),
          ),
        ),
        DataCell(
          Text(dataRow['form_code']),
        ),
        DataCell(
          Text(dataRow['created_at']),
        ),
        DataCell(
          Text(
            dataRow['unit_code'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['hour_meter'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['operator'],
          ),
        ),
        DataCell(
          Text(
            dataRow['shift'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['pallet_amount'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['verification_supervisor'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['verification_user'].toString(),
          ),
        ),
        DataCell(Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.remove_red_eye))
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}
