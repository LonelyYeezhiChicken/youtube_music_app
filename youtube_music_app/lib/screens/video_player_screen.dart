import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<String> trackPaths;
  final int initialIndex;

  const VideoPlayerScreen({
    super.key,
    required this.trackPaths,
    required this.initialIndex,
  });

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _initializeController();
  }

  void _initializeController() {
    _controller = VideoPlayerController.file(File(widget.trackPaths[_currentIndex]))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized
        setState(() {});
        _controller.play();
      });
  }

  void _playNext() {
    _controller.dispose();
    setState(() {
      _currentIndex = (_currentIndex + 1) % widget.trackPaths.length;
      _initializeController();
    });
  }

  void _playPrevious() {
    _controller.dispose();
    setState(() {
      _currentIndex = (_currentIndex - 1 + widget.trackPaths.length) % widget.trackPaths.length;
      _initializeController();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // A simple loading indicator while the controller is not yet initialized
    if (!_controller.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading...'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Track ${_currentIndex + 1} of ${widget.trackPaths.length}'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: VideoPlayer(_controller),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.skip_previous),
              onPressed: _playPrevious,
            ),
            IconButton(
              icon: Icon(_controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  _controller.value.isPlaying ? _controller.pause() : _controller.play();
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.skip_next),
              onPressed: _playNext,
            ),
          ],
        ),
      ),
    );
  }
}
