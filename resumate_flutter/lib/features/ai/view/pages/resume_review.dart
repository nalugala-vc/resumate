import 'package:flutter/material.dart';
import 'package:resumate_flutter/core/utils/fonts/sf_pro_display.dart';
import 'package:resumate_flutter/core/utils/spacers/spacers.dart';
import 'package:resumate_flutter/core/utils/theme/app_pallette.dart';
import 'package:resumate_flutter/core/utils/widgets/custom_appbar.dart';
import 'package:resumate_flutter/features/ai/model/ResumeResults.dart';

class ResumeReviewPage extends StatefulWidget {
  final ResumeResults results;

  const ResumeReviewPage({super.key, required this.results});
  @override
  _ResumeReviewPageState createState() => _ResumeReviewPageState();
}

class _ResumeReviewPageState extends State<ResumeReviewPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<Color> textColor = [
    AppPallete.primary100,
    AppPallete.pink400,
    AppPallete.primary400,
  ];

  final List<Color> backgroundColor = [
    AppPallete.primary400,
    AppPallete.pink100,
    AppPallete.primary100,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Resume Review',
        subtitle: 'Here are the results from your resume analysis',
      ),
      body: SafeArea(
        child: Column(
          children: [
            PreferredSize(
              preferredSize: Size.fromHeight(48.0),
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor:
                    Colors.transparent, // We'll custom style the selected tab
                labelPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 5,
                ), // Reduces horizontal padding
                padding:
                    EdgeInsets
                        .zero, // Removes outer padding from the whole tab bar
                tabs: [
                  _buildTab('Structure', 0),
                  _buildTab('Impact and Experience', 1),
                  _buildTab('Language', 2),
                  _buildTab('ATS', 3),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildStructureTab(widget.results),
                  _buildImpactTab(widget.results),
                  _buildLanguageTab(widget.results),
                  _buildATSTab(widget.results),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStructureTab(ResumeResults results) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfProDisplay(
            text: results.details.structure.description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            shouldTruncate: false,
            textAlignment: TextAlign.left,
          ),
          spaceH20,
          SfProDisplay(
            text: 'Recommendations & Next Steps',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),

          spaceH15,
          ...results.details.structure.recommendations.asMap().entries.map((
            entry,
          ) {
            final index = entry.key;
            final rec = entry.value;

            final bgColor = backgroundColor[index % backgroundColor.length];
            final txtColor = textColor[index % textColor.length];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildRecommendationCard(
                color: bgColor,
                textColor: txtColor,
                title: rec.title,
                subtitle: rec.description,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildImpactTab(ResumeResults results) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfProDisplay(
            text: results.details.impact.description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            shouldTruncate: false,
            textAlignment: TextAlign.left,
          ),
          spaceH20,
          SfProDisplay(
            text: 'Recommendations & Next Steps',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),

          spaceH15,
          ...results.details.impact.recommendations.asMap().entries.map((
            entry,
          ) {
            final index = entry.key;
            final rec = entry.value;

            final bgColor = backgroundColor[index % backgroundColor.length];
            final txtColor = textColor[index % textColor.length];

            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildRecommendationCard(
                color: bgColor,
                textColor: txtColor,
                title: rec.title,
                subtitle: rec.description,
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildLanguageTab(ResumeResults results) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfProDisplay(
            text: results.details.languageClarity.description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            shouldTruncate: false,
            textAlignment: TextAlign.left,
          ),
          spaceH20,
          SfProDisplay(
            text: 'Recommendations & Next Steps',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),

          spaceH15,
          ...results.details.languageClarity.recommendations
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final rec = entry.value;

                final bgColor = backgroundColor[index % backgroundColor.length];
                final txtColor = textColor[index % textColor.length];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildRecommendationCard(
                    color: bgColor,
                    textColor: txtColor,
                    title: rec.title,
                    subtitle: rec.description,
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildATSTab(ResumeResults results) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfProDisplay(
            text: results.details.atsCompatibility.description,
            fontSize: 14,
            fontWeight: FontWeight.w400,
            shouldTruncate: false,
            textAlignment: TextAlign.left,
          ),
          spaceH20,
          SfProDisplay(
            text: 'Recommendations & Next Steps',
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),

          spaceH15,
          ...results.details.atsCompatibility.recommendations
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final rec = entry.value;

                final bgColor = backgroundColor[index % backgroundColor.length];
                final txtColor = textColor[index % textColor.length];

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildRecommendationCard(
                    color: bgColor,
                    textColor: txtColor,
                    title: rec.title,
                    subtitle: rec.description,
                  ),
                );
              }),
        ],
      ),
    );
  }

  Widget _buildRecommendationCard({
    required Color color,
    required Color textColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SfProDisplay(
            text: title,
            textColor: textColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          spaceH10,

          SfProDisplay(
            text: subtitle,
            textColor: textColor,
            fontWeight: FontWeight.w500,
            textAlignment: TextAlign.left,
            shouldTruncate: false,
            lineheight: 1.3,
            fontSize: 15,
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String title, int index) {
    return AnimatedBuilder(
      animation: _tabController.animation!,
      builder: (context, child) {
        final isActive = _tabController.index == index;
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
          decoration: BoxDecoration(
            color: isActive ? AppPallete.primary100 : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: SfProDisplay(
            text: title,
            textColor: isActive ? AppPallete.primary400 : AppPallete.greyColor,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        );
      },
    );
  }
}
