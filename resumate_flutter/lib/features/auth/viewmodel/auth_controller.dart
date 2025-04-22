import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/core/utils/widgets/custom_nav_bar.dart';
import 'package:resumate_flutter/features/auth/repository/auth_repository.dart';

class SignUpController extends BaseController {
  static SignUpController get instance => Get.find();
  final AuthRepository _authRepo = AuthRepository();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final errorMessage = ''.obs;

  // Validation method for password
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
      isLoading.value = true;
      errorMessage.value = '';

      final res = await _authRepo.signup(email: email, password: password);

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (successMessage) {
          Get.snackbar('Success', successMessage);
          Get.to(() => CustomBottomNavBar());
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

class SignInController extends BaseController {
  static SignInController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
}
