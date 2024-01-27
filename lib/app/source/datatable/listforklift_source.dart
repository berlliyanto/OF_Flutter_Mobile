import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/constant/color.dart';

class ListForkliftSource extends DataTableSource {
  final List<Map<String, dynamic>> data = [
    {
      'unit_code': 'SOE 1902',
      'location': 'FGWH',
      'hour_mtr': 90,
      'pic': 'YULI',
    },
    {
      'unit_code': 'SOE 1902',
      'location': 'FGWH',
      'hour_mtr': 90,
      'pic': 'YULI',
    },
    {
      'unit_code': 'SOE 1902',
      'location': 'FGWH',
      'hour_mtr': 90,
      'pic': 'YULI',
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
          Text(dataRow['unit_code']),
        ),
        DataCell(
          Text(dataRow['location']),
        ),
        DataCell(
          Text(
            dataRow['hour_mtr'].toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow['pic'],
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
