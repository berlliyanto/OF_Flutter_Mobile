import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/forklift_model.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

class ListForkliftSource extends DataTableSource {
  final List<ForkliftModel> data = [];

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<ForkliftModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<ForkliftModel> tasks) {
    final newData = tasks.map((item) {
      return ForkliftModel(
        id: item.id,
        codeId: item.codeId,
        codeNumber: item.codeNumber,
        locationId: item.locationId,
        picId: item.picId,
        unitCode: item.unitCode,
        image: item.image,
        location: item.location,
        hourMeter: item.hourMeter,
        pic: item.pic,
        lastCheckList: item.lastCheckList,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
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

    final currentRow = data[newIndex];

    return DataRow(
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(Get.context!).colorScheme.primary.withOpacity(0.08);
        }
        return data.indexOf(currentRow) % 2 == 0
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
          Text(currentRow.unitCode),
        ),
        DataCell(
          Text(currentRow.location.name),
        ),
        DataCell(
          Text(
            currentRow.hourMeter != null
                ? currentRow.hourMeter.toString()
                : "0",
          ),
        ),
        DataCell(
          Text(
            currentRow.pic.name,
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
  int get rowCount => totalRow;

  @override
  int get selectedRowCount => 0;
}
