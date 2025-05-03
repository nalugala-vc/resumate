import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';

class ResultsController extends BaseController {
  static ResultsController get instance => Get.find();
  // Observable data
  final results = <String, double>{}.obs;
  final topCategory = ''.obs;
  final level = ''.obs;
  final recommendations = <String>[].obs;
  final categoryNames = <String, String>{}.obs;

  // Non-observable function
  late Function(String) calculateCategoryMetrics;

  // You can create an init method to set everything
  void setResultsData({
    required Map<String, double> resultsData,
    required String topCat,
    required String levelData,
    required List<String> recs,
    required Map<String, String> catNames,
    required Function(String) calcFunc,
  }) {
    results.value = resultsData;
    topCategory.value = topCat;
    level.value = levelData;
    recommendations.value = recs;
    categoryNames.value = catNames;
    calculateCategoryMetrics = calcFunc;
  }
}
