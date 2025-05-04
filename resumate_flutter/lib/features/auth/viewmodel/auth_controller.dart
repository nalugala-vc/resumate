import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/core/utils/widgets/custom_nav_bar.dart';
import 'package:resumate_flutter/features/auth/model/User.dart';
import 'package:resumate_flutter/features/auth/repository/auth_repository.dart';
import 'package:resumate_flutter/features/auth/view/otp.dart';
import 'package:resumate_flutter/features/auth/view/sign_in.dart';
import 'package:resumate_flutter/features/feed/viewmodel/feed_controller.dart';
import 'package:resumate_flutter/features/quiz/model/quiz_results.dart';
import 'package:resumate_flutter/features/quiz/repository/quiz_repository.dart';
import 'package:resumate_flutter/features/quiz/view/pages/quiz_page.dart';
import 'package:resumate_flutter/features/quiz/viewmodel/results_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends BaseController {
  static SignUpController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final errorMessage = ''.obs;

  String? validatePassword(String password) {
    if (password.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    if (!RegExp(r'(?=.*?[#?!@$%^&*-])').hasMatch(password)) {
      return 'Password must contain at least one special character';
    }
    if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
      return 'Password must contain at least one number';
    }
    return null;
  }

  String? validateConfirmPassword(String password, String confirmPassword) {
    if (password != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  String? validateEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (email.isEmpty) {
      return 'Email is required';
    }
    if (!emailRegex.hasMatch(email)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setBusy(true);
      errorMessage.value = '';

      final res = await _authRepo.signup(
        email: email,
        password: password,
        name: name,
      );

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (successMessage) async {
          Get.snackbar('Success', successMessage);
          await prefs.setString('USER_EMAIL', email);
          Get.to(() => OTP());
        },
      );
      setBusy(false);
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }
}

class SignInController extends BaseController {
  static SignInController get instance => Get.find();

  final AuthRepository _authRepo = AuthRepository();

  final errorMessage = ''.obs;
  var currentUser = Rxn<UserModel>();

  final email = TextEditingController();
  final password = TextEditingController();

  UserModel? get user => currentUser.value;

  Future<void> signIn({required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();

    try {
      setBusy(true);
      errorMessage.value = '';

      final res = await _authRepo.signIn(email: email, password: password);

      res.fold(
        (failure) {
          print('❌ Sign-in failed: ${failure.message}');
          Get.snackbar('Error', failure.message);
        },
        (user) async {
          try {
            // Save user locally
            currentUser.value = user;

            await prefs.setString('USER_ID', user.id);
            await prefs.setString('USER_EMAIL', user.email);
            await prefs.setString('USER_TOKEN', user.token);
            await prefs.setString('USER_NAME', user.name);

            Get.snackbar('Success', 'Signed in successfully');

            // Debugging output
            print('📦 quizResults: ${user.quizResults}');
            print('📦 quizResults.results: ${user.quizResults?.results}');
            print('🧪 is null: ${user.quizResults == null}');
            print('🧪 is empty: ${user.quizResults?.results.isEmpty}');
            print('🧪 keys in results: ${user.quizResults?.results.keys}');

            final isMissingOrInvalid =
                user.quizResults == null ||
                user.quizResults!.results.isEmpty ||
                !user.quizResults!.results.keys.any((key) => key is String);

            if (isMissingOrInvalid) {
              print('🔁 Navigating to QuizPage...');
              Get.to(() => QuizPage());
              return;
            }

            // Safely use quiz data
            final resultsController = Get.find<ResultsController>();

            resultsController.setResultsData(
              resultsData: user.quizResults!.results,
              topCat: user.quizResults!.topCategory,
              levelData: user.quizResults!.level,
              recs: user.quizResults!.recommendations,
              catNames: user.quizResults!.categoryNames,
            );

            final feedController = Get.find<FeedController>();
            feedController.selectedTrack.value = user.quizResults!.topCategory;

            print('✅ Navigating to CustomBottomNavBar');
            Get.to(() => CustomBottomNavBar());
          } catch (e, stack) {
            print('🔥 ERROR inside success block: $e');
            print('📍 Stack trace:\n$stack');
            Get.snackbar('Error', e.toString());
          }
        },
      );
    } catch (e, stack) {
      print('🚨 Unexpected error in signIn(): $e');
      print('📍 Stack trace:\n$stack');
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> loadUserFromStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('USER_ID');
    final email = prefs.getString('USER_EMAIL');
    final token = prefs.getString('USER_TOKEN');
    final name = prefs.getString('USER_NAME');

    if (id != null && email != null && token != null && name != null) {
      currentUser.value = UserModel(
        id: id,
        email: email,
        token: token,
        name: name,
      );
    }
  }
}

class OTPController extends BaseController {
  static OTPController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

  Future<void> verifyOTP({required String OTPcode}) async {
    final prefs = await SharedPreferences.getInstance();

    String? userEmail = prefs.getString('USER_EMAIL');

    final res = await _authRepo.verifyOTP(email: userEmail!, OTPCode: OTPcode);

    res.fold(
      (failure) {
        Get.snackbar('Error', failure.message);
      },
      (res) async {
        Get.snackbar('Success', 'Account Verified Successfully');
        Get.to(() => SignIn());
      },
    );
    setBusy(false);
  }
}
