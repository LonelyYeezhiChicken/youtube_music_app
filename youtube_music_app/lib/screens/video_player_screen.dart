import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../main.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String filePath;

  const VideoPlayerScreen({super.key, required this.filePath});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.filePath))
      ..initialize().then((_) {
        // Mute the video player as audio is handled by audio_service
        _videoController.setVolume(0.0);
        // Do not call _videoController.play() here.
        // Playback state will be controlled by syncing with audio_service.
        setState(() {}); // Rebuild to show video
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_videoController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Loading Video...')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Playing Video')),
      body: StreamBuilder<PlaybackState>(
        stream: audioHandler.playbackState,
        builder: (context, snapshot) {
          final playbackState = snapshot.data;
          final isPlaying = playbackState?.playing ?? false;
          final audioPosition = playbackState?.updatePosition ?? Duration.zero;

          // Sync play/pause state
          if (isPlaying && !_videoController.value.isPlaying) {
            _videoController.play();
          } else if (!isPlaying && _videoController.value.isPlaying) {
            _videoController.pause();
          }

          // Sync position
          final videoPosition = _videoController.value.position;
          final difference = (audioPosition - videoPosition).abs();
          if (difference > const Duration(milliseconds: 250)) {
            _videoController.seekTo(audioPosition);
          }

          return Center(
            child: AspectRatio(
              aspectRatio: _videoController.value.aspectRatio,
              child: VideoPlayer(_videoController),
            ),
          );
        },
      ),
    );
  }
}
