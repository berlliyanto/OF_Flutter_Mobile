import 'package:get/get.dart';
import 'package:of_flutter_mobile/app/models/checklist_model.dart';
import 'package:of_flutter_mobile/app/services/checklist/checklist_service.dart';

class MychecklistController extends GetxController {
  List<ChecklistModel> listChecklist = [];

  var isLoading = false.obs;

  Future<void> myChecklist() async {
    isLoading.value = true;
    update();
    final response = await CheckListService().unfinish();
    if (response.statusCode == 200) {
      listChecklist = (response.data['data'] as List)
          .map((e) => ChecklistModel.fromJson(e))
          .toList();
    }
    isLoading.value = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    myChecklist();
  }
}
