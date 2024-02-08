import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';

class CheckHistorySource extends DataTableSource {
  final List<ChecklistModel> data = [];

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<ChecklistModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<ChecklistModel> tasks) {
    final newData = tasks.map((item) {
      return ChecklistModel(
        id: item.id,
        formCode: item.formCode,
        unitCode: item.unitCode,
        palletAmount: item.palletAmount,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
        operator: item.operator,
        forklift: item.forklift,
        forkliftHourMeter: item.forkliftHourMeter,
        docs: item.docs,
        items: item.items,
        shift: item.shift,
        verificationSupervisor: item.verificationSupervisor,
        verificationUser: item.verificationUser,
      );
    }).toList();

    updateData(newData);
  }

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
    if (index >= totalRow || data.isEmpty) {
      return null;
    }

    int newIndex = (index + (currentPage - 1) * perPage) % perPage;
    if (newIndex >= data.length) {
      return null;
    }

    final dataRow = data[newIndex];
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
          Text(dataRow.formCode.toString()),
        ),
        DataCell(
          Text(formatDate(dataRow.createdAt)),
        ),
        DataCell(
          Text(
            dataRow.unitCode.toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow.forkliftHourMeter != null
                ? dataRow.forkliftHourMeter.toString()
                : "-",
          ),
        ),
        DataCell(
          Text(
            dataRow.operator!.name,
          ),
        ),
        DataCell(
          Text(
            dataRow.shift!.id.toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow.forklift!.location!.name.toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow.palletAmount.toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow.verificationSupervisor != null
                ? dataRow.verificationSupervisor.toString()
                : "-",
          ),
        ),
        DataCell(
          Text(
            dataRow.verificationUser != null
                ? dataRow.verificationUser.toString()
                : "-",
          ),
        ),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.CHECKREPORT,
                    arguments: {'id': dataRow.id},
                  );
                },
                icon: const Icon(Icons.remove_red_eye))
          ],
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => totalRow;

  @override
  int get selectedRowCount => 0;
}
