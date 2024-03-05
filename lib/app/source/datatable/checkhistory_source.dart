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
        diffHourMeter: item.diffHourMeter,
        docs: item.docs,
        items: item.items,
        shift: item.shift,
        manHour: item.manHour,
        isFinish: item.isFinish,
        ratio: item.ratio,
        verificationManagement: item.verificationManagement,
        verificationSupervisor: item.verificationSupervisor,
        verificationUser: item.verificationUser,
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

    final dataRow = data[newIndex];
    return DataRow(
      color: MaterialStateColor.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Theme.of(Get.context!).colorScheme.primary.withOpacity(0.08);
        }
        if (dataRow.isFinish == 0) {
          return colors.red.withOpacity(0.5);
        }
        return data.indexOf(dataRow) % 2 == 0
            ? colors.soekimanPallet1.withOpacity(0.1)
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
            dataRow.diffHourMeter != null
                ? dataRow.diffHourMeter.toString()
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
            dataRow.shift != null ? dataRow.shift!.id.toString() : "-",
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
            dataRow.manHour.toString(),
          ),
        ),
        DataCell(
          Text(
            dataRow.ratio.toString(),
          ),
        ),
        DataCell(
          Text(
            formatDate(dataRow.verificationSupervisor),
          ),
        ),
        DataCell(
          Text(
            formatDate(dataRow.verificationManagement),
          ),
        ),
        DataCell(
          Text(
            formatDate(dataRow.verificationUser),
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
