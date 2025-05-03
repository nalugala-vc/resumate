import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/feed/model/JobOpportunities.dart';
import 'package:resumate_flutter/features/feed/repository/feed_repository.dart';

class FeedController extends BaseController {
  static FeedController get instance => Get.find();
  final FeedRepository _feedRepository = FeedRepository();

  final errorMessage = ''.obs;
  final selectedTrack = ''.obs;
  RxList<JobOpportunity> jobOpportunities = <JobOpportunity>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchJobOpportunities();
  }

  List<JobOpportunity> get filteredJobOpportunities {
    if (selectedTrack.value.isEmpty) {
      // Print all categories before returning
      for (var job in jobOpportunities) {
        print('Category: ${job.category}');
      }
      return jobOpportunities;
    }

    print('Selected track: ${selectedTrack.value}');
    for (var job in jobOpportunities) {
      print('Category: ${job.category}');
    }

    return jobOpportunities
        .where(
          (job) =>
              job.category.toLowerCase() == selectedTrack.value.toLowerCase(),
        )
        .toList();
  }

  Future<void> fetchJobOpportunities() async {
    try {
      setBusy(true);
      errorMessage.value = '';

      final res = await _feedRepository.fetchJobOpportunities();

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (jobOpportunitiesList) async {
          jobOpportunities.value = jobOpportunitiesList;
          Get.snackbar('Success', 'Job Opportunities loaded successfully');
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }
}
