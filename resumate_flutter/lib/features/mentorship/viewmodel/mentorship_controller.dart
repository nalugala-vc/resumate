import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/mentorship/repository/mentorship_repo.dart';

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
          print(failure.message);
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
}
