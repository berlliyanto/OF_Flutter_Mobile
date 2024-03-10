import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/workorder_model.dart';
import 'package:of_flutter_mobile/app/services/workorder/workorder_service.dart';

class MyworkorderController extends GetxController {
  List<WorkorderModel> listWorkorder = [];

  var isLoading = false.obs;

  Future<void> myWO() async {
    isLoading.value = true;
    update();

    final response = await WorkorderService().myWorkorder();
    if (response.statusCode == 200) {
      listWorkorder = (response.data['data'] as List)
          .map((e) => WorkorderModel.fromJson(e))
          .toList();
    }

    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    myWO();
  }
}
