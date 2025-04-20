import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/services.dart';

class Lesson {
  final String title;
  final String subtitle;
  final String videoUrl;

  Lesson({required this.title, required this.subtitle, required this.videoUrl});
}

class VideoCoursePage extends StatefulWidget {
  @override
  _VideoCoursePageState createState() => _VideoCoursePageState();
}

class _VideoCoursePageState extends State<VideoCoursePage> {
  late VideoPlayerController _controller;
  int _selectedLessonIndex = 0;
  int _selectedTab = 0;
  bool _isFullScreen = false;

  final List<Lesson> lessons = [
    Lesson(
      title: 'Introduction',
      subtitle: 'Lorem ipsum dolor sit amet',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    Lesson(
      title: 'Variables',
      subtitle: 'Lorem ipsum dolor sit amet',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
    Lesson(
      title: 'Classes',
      subtitle: 'Lorem ipsum dolor sit amet',
      videoUrl:
          'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _initializeVideo(lessons[_selectedLessonIndex].videoUrl);
  }

  void _initializeVideo(String url) {
    _controller = VideoPlayerController.network(url)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  }

  void _onLessonSelected(int index) {
    setState(() {
      _selectedLessonIndex = index;
      _controller.dispose();
      _initializeVideo(lessons[index].videoUrl);
    });
  }

  void _toggleFullScreen() {
    setState(() {
      _isFullScreen = !_isFullScreen;
    });

    if (_isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _controller.value.isInitialized
              ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    VideoPlayer(_controller),
                    _ControlsOverlay(
                      controller: _controller,
                      onFullScreenToggle: _toggleFullScreen,
                    ),
                    VideoProgressIndicator(_controller, allowScrubbing: true),
                  ],
                ),
              )
              : Container(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
          if (!_isFullScreen)
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: _buildCourseHeader(),
                  ),
                  Expanded(
                    child:
                        _selectedTab == 0
                            ? _buildLessonsTab()
                            : _buildResourcesTab(),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar:
          _isFullScreen
              ? null
              : Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: Text('Enroll Now'),
                ),
              ),
    );
  }

  Widget _buildCourseHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'JavaScript Mastery',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Icons.person_outline, size: 16),
            SizedBox(width: 4),
            Text('Matthew Angelo'),
            SizedBox(width: 16),
            Icon(Icons.grade, size: 16),
            SizedBox(width: 4),
            Text('Beginner'),
            SizedBox(width: 16),
            Icon(Icons.access_time, size: 16),
            SizedBox(width: 4),
            Text('2hrs 30 min'),
            SizedBox(width: 16),
            Icon(Icons.people_outline, size: 16),
            SizedBox(width: 4),
            Text('3.4k Students'),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Description',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua...',
        ),
        SizedBox(height: 16),
        Row(
          children: [
            ChoiceChip(
              label: Text("Lessons"),
              selected: _selectedTab == 0,
              onSelected: (val) => setState(() => _selectedTab = 0),
            ),
            SizedBox(width: 10),
            ChoiceChip(
              label: Text("Resources"),
              selected: _selectedTab == 1,
              onSelected: (val) => setState(() => _selectedTab = 1),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLessonsTab() {
    return ListView.builder(
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessons[index];
        final isSelected = index == _selectedLessonIndex;

        return GestureDetector(
          onTap: () => _onLessonSelected(index),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal.withOpacity(0.1) : Colors.white,
              border: Border.all(
                color: isSelected ? Colors.teal : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Text(
                  '${(index + 1).toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.teal : Colors.grey,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        lesson.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        lesson.subtitle,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.play_circle_fill,
                  color: isSelected ? Colors.teal : Colors.teal.shade100,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResourcesTab() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        ListTile(
          leading: Icon(Icons.picture_as_pdf, color: Colors.teal),
          title: Text('JavaScript Cheatsheet.pdf'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.link, color: Colors.teal),
          title: Text('MDN JavaScript Guide'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.note, color: Colors.teal),
          title: Text('Lecture Notes'),
          onTap: () {},
        ),
      ],
    );
  }
}

// Overlay with playback controls
class _ControlsOverlay extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onFullScreenToggle;

  const _ControlsOverlay({
    required this.controller,
    required this.onFullScreenToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: GestureDetector(
            onTap: () {
              controller.value.isPlaying
                  ? controller.pause()
                  : controller.play();
            },
            child: Icon(
              controller.value.isPlaying
                  ? Icons.pause_circle_filled
                  : Icons.play_circle_fill,
              color: Colors.white,
              size: 64,
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: IconButton(
            icon: Icon(Icons.fullscreen, color: Colors.white),
            onPressed: onFullScreenToggle,
          ),
        ),
      ],
    );
  }
}
