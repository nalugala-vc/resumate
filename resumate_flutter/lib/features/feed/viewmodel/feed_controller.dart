import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/feed/model/JobOpportunities.dart';
import 'package:resumate_flutter/features/feed/repository/feed_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  JobOpportunity? getJobById(String id) {
    return jobOpportunities.firstWhereOrNull((job) => job.id == id);
  }

  List<JobOpportunity> get filteredJobOpportunities {
    if (selectedTrack.value.isEmpty) {
      for (var job in jobOpportunities) {
        debugPrint('Category: ${job.category}');
      }
      return jobOpportunities;
    }

    debugPrint('Selected track: ${selectedTrack.value}');
    for (var job in jobOpportunities) {
      debugPrint('Category: ${job.category}');
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
          debugPrint(failure.message);
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

  Future<void> applyForJob({required String jobId}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userId = prefs.getString('USER_ID');
      setBusy(true);
      errorMessage.value = '';

      final res = await _feedRepository.applyForJob(
        jobId: jobId,
        userId: userId!,
      );

      res.fold(
        (failure) {
          debugPrint(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (success) async {
          final index = jobOpportunities.indexWhere((job) => job.id == jobId);
          if (index != -1) {
            final job = jobOpportunities[index];

            job.applicants += 1;
            jobOpportunities[index] = job;
            jobOpportunities.refresh();
          }
          Get.snackbar('Success', 'Job applied successfully');
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
