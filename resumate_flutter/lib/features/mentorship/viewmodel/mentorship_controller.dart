import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/mentorship/repository/mentorship_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MentorshipController extends BaseController {
  static MentorshipController get instance => Get.find();
  final MentorshipRepo _mentorshipRepo = MentorshipRepo();

  RxList mentors = [].obs;
  final errorMessage = ''.obs;

  Future<void> fetchMentors() async {
    try {
      setBusy(true);
      errorMessage.value = '';

      final res = await _mentorshipRepo.fetchMentors();

      res.fold(
        (failure) {
          debugPrint(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (mentorsList) async {
          mentors.value = mentorsList;
          Get.snackbar('Success', 'Mentors loaded successfully');
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> bookMentorSession({
    required String mentorId,
    required String date,
    required String time,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('USER_ID');
      setBusy(true);
      errorMessage.value = '';

      final res = await _mentorshipRepo.bookSession(
        date: date,
        mentorId: mentorId,
        time: time,
        userId: id!,
      );

      res.fold(
        (failure) {
          debugPrint(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (success) {
          if (success) {
            Get.snackbar('Success', 'Session booked successfully');
          } else {
            Get.snackbar('Error', 'Booking failed. Try again.');
          }
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
