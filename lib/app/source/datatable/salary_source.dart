import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/components/widgets/dialog/awesome_dialog.dart';
import 'package:of_flutter_mobile/app/dependency/global_state.dart';
import 'package:of_flutter_mobile/app/models/salary_model.dart';
import 'package:of_flutter_mobile/app/services/salary/salary_service.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';
import 'package:of_flutter_mobile/app/utils/file_downloader.dart';
import 'package:of_flutter_mobile/app/utils/formatter.dart';
import 'package:of_flutter_mobile/app/utils/url_files.dart';

class SalaryDatatable extends DataTableSource {
  final List<SalaryModel> data = [];
  final GlobalState globalState = Get.find<GlobalState>();

  final ColorPicker colors = ColorPicker();

  int totalRow = 0;
  int currentPage = 1;
  int perPage = 10;

  void updateData(List<SalaryModel> newData) {
    data.clear();
    data.addAll(newData);
    notifyListeners();
  }

  void updateDataFromController(List<SalaryModel> tasks) {
    final newData = tasks.map((item) {
      return SalaryModel(
        id: item.id,
        employeeId: item.employeeId,
        employeeModel: item.employeeModel,
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

        return data.indexOf(currentRow) % 2 == 0
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
          Text(formatDate(currentRow.createdAt)),
        ),
        DataCell(
          Text(currentRow.employeeModel!.name!),
        ),
        DataCell(Row(
          children: [
            IconButton(
              onPressed: () {
                String url = urlFileBuilder(
                    transaction: "pdf",
                    type: "salary",
                    query: "id=${currentRow.id}");
                final FileDownloader fileDownloader =
                    Get.find<FileDownloader>();
                fileDownloader.downloadDoc(url);
              },
              icon: const Icon(
                Icons.picture_as_pdf,
                color: Colors.red,
              ),
            ),
            if (globalState.getPermissions.contains('delete-salary'))
              IconButton(
                onPressed: () {
                  awesomeDialog(
                    title: "Delete Salary",
                    desc: "Are you sure to delete this salary?",
                    type: DialogType.question,
                    cancel: () {},
                    callback: () async {
                      EasyLoading.show(status: "Loading...");
                      final response = await SalaryService()
                          .destroySalary(id: currentRow.id!);
                      if (response.statusCode == 200) {
                        EasyLoading.dismiss();
                        EasyLoading.showSuccess("Success Delete");
                        Get.back();
                      } else {
                        EasyLoading.dismiss();
                      }
                    },
                  );
                },
                icon: const Icon(
                  FontAwesomeIcons.trash,
                  color: Colors.red,
                ),
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
