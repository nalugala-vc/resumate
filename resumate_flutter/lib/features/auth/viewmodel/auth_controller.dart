import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/core/utils/widgets/custom_nav_bar.dart';
import 'package:resumate_flutter/features/auth/model/User.dart';
import 'package:resumate_flutter/features/auth/repository/auth_repository.dart';
import 'package:resumate_flutter/features/auth/view/otp.dart';
import 'package:resumate_flutter/features/auth/view/sign_in.dart';
import 'package:resumate_flutter/features/quiz/view/pages/quiz_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpController extends BaseController {
  static SignUpController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

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

  Future<void> signUp({required String email, required String password}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setBusy(true);
      errorMessage.value = '';

      final res = await _authRepo.signup(email: email, password: password);

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
  final Rxn<UserModel> currentUser = Rxn<UserModel>(); // Reactive user state

  final email = TextEditingController();
  final password = TextEditingController();

  UserModel? get user => currentUser.value; // Optional getter for user

  Future<void> signIn({required String email, required String password}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      setBusy(true);
      errorMessage.value = '';

      final res = await _authRepo.signIn(email: email, password: password);

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (user) async {
          currentUser.value = user;

          // Persist values for future sessions
          await prefs.setString('USER_ID', user.id);
          await prefs.setString('USER_EMAIL', user.email);
          await prefs.setString('USER_TOKEN', user.token);

          Get.snackbar('Success', 'Signed in successfully');
          Get.to(() => QuizPage());
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
