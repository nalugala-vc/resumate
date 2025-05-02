import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:heroicons/heroicons.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/notifications_icon.dart';
import 'package:resumate_flutter/core/utils/widgets/rounded_button.dart';
import 'package:resumate_flutter/features/ai/view/widgets/analyzing_popup.dart';
import 'package:resumate_flutter/features/ai/viewmodel/ai_controller.dart';

class UploadResumePage extends StatefulWidget {
  @override
  _UploadResumePageState createState() => _UploadResumePageState();
}

class _UploadResumePageState extends State<UploadResumePage> {
  final controller = Get.put(AiController());
  File? _selectedFile;

  void _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _processResumeFile() async {
    if (_selectedFile != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AnalyzingPopup(),
      );

      String? resumeText = await controller.extractResumeText(
        _selectedFile!,
        onProgress: (message) {
          debugPrint(message);
        },
      );

      if (resumeText != null) {
        debugPrint('Extracted text length: ${resumeText.length}');

        await controller.uploadResumeAndEvaluate(resume: resumeText);
      } else {
        Navigator.pop(context); // Close analyzing popup
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to extract text from the resume')),
        );
      }
    }
  }

  Widget _buildDashedContainer() {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(16),
      dashPattern: [6, 4],
      color: AppPallete.primary400,
      strokeWidth: 1.5,
      child: InkWell(
        onTap: _pickResume,
        child: Container(
          width: double.infinity,
          height: 300,
          padding: EdgeInsets.all(20),
          child: Center(
            child:
                _selectedFile == null
                    ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            color: AppPallete.primary100,
                            shape: BoxShape.circle,
                          ),
                          child: HeroIcon(
                            HeroIcons.arrowUpTray,
                            style: HeroIconStyle.solid,
                            color: AppPallete.primary400,
                            size: 34,
                          ),
                        ),
                        spaceH20,
                        Text(
                          "Upload Resume",
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    )
                    : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedFile!.path.endsWith('.pdf')
                              ? Icons.picture_as_pdf
                              : Icons.description,
                          size: 60,
                          color: AppPallete.primary400,
                        ),
                        spaceH10,
                        Text(
                          _selectedFile!.path.split('/').last,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnalyzeButton() {
    if (_selectedFile == null) return SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: RoundedButton(
        label: 'analyze my resume',
        onTap: _processResumeFile,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SfProDisplay(
                        text: 'Upload Resume',
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                      ),
                      SfProDisplay(
                        text: "Get feedback tailored to you!",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        textColor: AppPallete.greyColor,
                        lineheight: 0,
                      ),
                    ],
                  ),
                  NotificationsIcon(),
                ],
              ),

              spaceH30,
              _buildDashedContainer(),
              spaceH20,
              _buildAnalyzeButton(),
            ],
          ),
        ),
      ),
    );
  }
}
