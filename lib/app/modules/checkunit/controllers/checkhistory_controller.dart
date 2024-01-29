import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/source/datatable/checkhistory_source.dart';

class CheckhistoryController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final CheckHistorySource source = CheckHistorySource();
  final List<Map<String, dynamic>> options = [
    {'id': 1, 'name': 'Option 1'},
    {'id': 2, 'name': 'Option 2'},
    {'id': 3, 'name': 'Option 3'},
  ];

  var locationId = 0.obs;

  void onChangedInput(String type, dynamic value) {
    switch (type) {
      case "location":
        break;
      case "shift":
        break;
      case "pallet":
        break;
      case "forklift_hour_meter":
        break;
      default:
    }

    update();
  }

  Future suggestions(String query) async {
    return options
        .where((element) =>
            element['name'].toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  void onTypeAheadSelected(Map<String, dynamic> value) {
    textController.text = value['name'];
  }
}
