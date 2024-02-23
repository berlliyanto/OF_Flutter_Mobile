import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/paid_leave_model.dart';
import 'package:of_flutter_mobile/app/routes/app_pages.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';

class PaidLeaveDatatable extends DataTableSource {
  final List<PaidLeaveModel> data = [];

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<PaidLeaveModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<PaidLeaveModel> tasks) {
    final newData = tasks.map((item) {
      return PaidLeaveModel(
        id: item.id,
        employee: item.employee,
        paidLeaveTypeModel: item.paidLeaveTypeModel,
        from: item.from,
        to: item.to,
        status: item.status,
        reason: item.reason,
        totalDays: item.totalDays,
        supervisorApprovalDate: item.supervisorApprovalDate,
        managementApprovalDate: item.managementApprovalDate,
        userApprovalDate: item.userApprovalDate,
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

        if (currentRow.status == "rejected") {
          return colors.redDark.withOpacity(0.3);
        }

        if (currentRow.status == "approved") {
          return colors.greenDark.withOpacity(0.3);
        }

        if (currentRow.status == "on process") {
          return colors.yellowDark.withOpacity(0.3);
        }

        return colors.cyanDark.withOpacity(0.3);
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
          Text(currentRow.employee!.name!),
        ),
        DataCell(
          Text(currentRow.paidLeaveTypeModel!.name!),
        ),
        DataCell(
          Text(
            formatDateNoTime(currentRow.from),
          ),
        ),
        DataCell(
          Text(formatDateNoTime(currentRow.to)),
        ),
        DataCell(
          Text(currentRow.totalDays.toString()),
        ),
        DataCell(
          Text(currentRow.reason.toString()),
        ),
        DataCell(
          Text(capitalizeFirstChar(currentRow.status!)),
        ),
        DataCell(
          Text(formatDate(currentRow.supervisorApprovalDate)),
        ),
        DataCell(
          Text(formatDate(currentRow.userApprovalDate)),
        ),
        DataCell(
          Text(formatDate(currentRow.managementApprovalDate)),
        ),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  Get.toNamed(
                    Routes.ABSENCEREQUEST,
                    arguments: {'id': currentRow.id},
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
