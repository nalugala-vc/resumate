import 'dart:io';
import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:read_pdf_text/read_pdf_text.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/ai/model/ChatMessage.dart';
import 'package:resumate_flutter/features/ai/repository/ai_repository.dart';
import 'package:resumate_flutter/features/ai/view/pages/resume_results.dart';

class AiController extends BaseController {
  static AiController get instance => Get.find();
  final AiRepository _aiRepository = AiRepository();

  final errorMessage = ''.obs;
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;

  Future<void> sendMessage({required String message}) async {
    try {
      messages.add(ChatMessage(content: message, isUser: true));

      setBusy(true);
      errorMessage.value = '';

      final res = await _aiRepository.chatWithAI(message: message);

      res.fold(
        (failure) {
          errorMessage.value = failure.message;
          Get.snackbar('Error', failure.message);
        },
        (reply) {
          messages.add(ChatMessage(content: reply, isUser: false));
        },
      );
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<String?> extractResumeText(
    File file, {
    Function(String)? onProgress,
  }) async {
    try {
      final String filePath = file.path.toLowerCase();
      String? extractedText;

      onProgress?.call('Starting text extraction...');

      if (filePath.endsWith('.pdf')) {
        onProgress?.call('Processing PDF file...');

        extractedText = await ReadPdfText.getPDFtext(file.path);
      } else if (filePath.endsWith('.docx')) {
        onProgress?.call('Processing DOCX file...');
        extractedText = docxToText(file.readAsBytesSync());
      } else if (filePath.endsWith('.doc')) {
        onProgress?.call('Processing DOC file...');
        throw UnsupportedError(
          'Legacy .doc format requires additional handling',
        );
      } else {
        throw UnsupportedError('Unsupported file format');
      }

      onProgress?.call('Text extraction complete');
      return extractedText;
    } catch (e) {
      debugPrint('Error extracting text: $e');
      return null;
    }
  }

  Future<void> uploadResumeAndEvaluate({required String resume}) async {
    try {
      setBusy(true);
      errorMessage.value = '';

      final res = await _aiRepository.uploadResume(resume: resume);
      debugPrint(res.toString());

      res.fold(
        (failure) {
          debugPrint(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (resumeResults) {
          Navigator.of(Get.context!, rootNavigator: true).pop();
          Get.snackbar('Success', 'Resume evaluated successfully');
          Get.to(() => ResumeResultsPage(results: resumeResults));
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
