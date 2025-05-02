import 'dart:io';
import 'dart:typed_data';

import 'package:docx_to_text/docx_to_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pdf_text/pdf_text.dart';
import 'package:resumate_flutter/core/controller/base_controller.dart';
import 'package:resumate_flutter/features/ai/repository/ai_repository.dart';
import 'package:resumate_flutter/features/ai/view/pages/resume_results.dart';

class AiController extends BaseController {
  static AiController get instance => Get.find();
  final AiRepository _aiRepository = AiRepository();

  final errorMessage = ''.obs;

  Future<String?> extractResumeText(
    File file, {
    Function(String)? onProgress,
  }) async {
    try {
      final String filePath = file.path.toLowerCase();
      String? extractedText;

      // Update progress if callback provided
      onProgress?.call('Starting text extraction...');

      if (filePath.endsWith('.pdf')) {
        // Handle PDF files
        onProgress?.call('Processing PDF file...');
        PDFDoc doc = await PDFDoc.fromFile(file);
        extractedText = await doc.text;
      } else if (filePath.endsWith('.docx')) {
        // Handle DOCX files
        onProgress?.call('Processing DOCX file...');
        extractedText = docxToText(file.path as Uint8List);
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
      print(res);

      res.fold(
        (failure) {
          print(failure.message);
          Get.snackbar('Error', failure.message);
        },
        (resumeResults) {
          Navigator.of(
            Get.context!,
            rootNavigator: true,
          ).pop(); // Dismiss dialog
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
