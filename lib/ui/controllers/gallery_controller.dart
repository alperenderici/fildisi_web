import 'package:get/get.dart';

class GalleryController extends GetxController {
  final selectedCategoryIndex = 0.obs;

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }
}
