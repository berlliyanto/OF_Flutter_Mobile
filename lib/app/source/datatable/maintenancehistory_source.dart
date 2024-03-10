import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/workorder_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';

class MaintenanceHistorySource extends DataTableSource {
  final List<WorkorderModel> data = [];

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<WorkorderModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<WorkorderModel> tasks) {
    final newData = tasks.map((item) {
      return WorkorderModel(
        id: item.id,
        userModel: item.userModel,
        forkliftModel: item.forkliftModel,
        description: item.description,
        status: item.status,
        startTimeInspection: item.startTimeInspection,
        startInspectionNote: item.startInspectionNote,
        endTimeInspection: item.endTimeInspection,
        endInspectionNote: item.endInspectionNote,
        unitBreakdown: item.unitBreakdown,
        canceledNote: item.canceledNote,
        isCanceled: item.isCanceled,
        verificationSupervisor: item.verificationSupervisor,
        createdAt: item.createdAt,
        updatedAt: item.updatedAt,
      );
    }).toList();

    updateData(newData);
  }

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

        if (currentRow.status == 'proses') {
          return colors.yellow.withOpacity(0.2);
        }

        if (currentRow.isCanceled == 1) {
          return colors.red.withOpacity(0.2);
        }

        if (currentRow.status == 'done') {
          return colors.greenDark.withOpacity(0.2);
        }

        if (currentRow.status == 'approved') {
          return colors.green.withOpacity(0.2);
        }

        return colors.whiteSmoke.withOpacity(0.2);
      }),
      cells: [
        DataCell(
          Text(
            (index + 1).toString(),
          ),
        ),
        DataCell(
          Text(formatDate(currentRow.createdAt)),
        ),
        DataCell(
          Text(currentRow.userModel!.name!),
        ),
        DataCell(
          Text(currentRow.forkliftModel!.unitCode!),
        ),
        DataCell(
          Text(
            currentRow.description!,
          ),
        ),
        DataCell(
          Text(
            capitalizeFirstChar(currentRow.status!),
          ),
        ),
        DataCell(
          Text(
            formatDate(
                DateTime.tryParse(currentRow.verificationSupervisor ?? "")),
          ),
        ),
        DataCell(
          Text(formatDate(
              DateTime.tryParse(currentRow.startTimeInspection ?? ""))),
        ),
        DataCell(
          Text(
            currentRow.startInspectionNote ?? "-",
          ),
        ),
        DataCell(
          Text(formatDate(
              DateTime.tryParse(currentRow.endTimeInspection ?? ""))),
        ),
        DataCell(
          Text(
            currentRow.endInspectionNote ?? "-",
          ),
        ),
        DataCell(
          Text(
            currentRow.unitBreakdown ?? "0",
          ),
        ),
        DataCell(Row(
          children: [
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.WORKORDER, arguments: {"id": currentRow.id});
              },
              icon: const Icon(Icons.remove_red_eye),
            )
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
