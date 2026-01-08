import 'package:audio_service/audio_service.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import '../models/track.dart';

Future<MyAudioHandler> initAudioService() async {
  return await AudioService.init(
    builder: () => MyAudioHandler(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.mycompany.myapp.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
}

class MyAudioHandler extends BaseAudioHandler with SeekHandler {
  final AudioPlayer _player = AudioPlayer();
  final _yt = YoutubeExplode();

  MyAudioHandler() {
    _player.onPlayerStateChanged.listen((playerState) {
      final isPlaying = playerState == PlayerState.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.pause,
          MediaControl.stop,
        ],
        processingState: AudioProcessingState.ready,
        playing: isPlaying,
      ));
    });
  }

  @override
  Future<void> play() async {
    await _player.resume();
  }

  @override
  Future<void> pause() async {
    await _player.pause();
  }

  @override
  Future<void> stop() async {
    await _player.stop();
    await super.stop();
  }

  @override
  Future<void> seek(Duration position) async {
    await _player.seek(position);
  }

  @override
  Future<void> playMediaItem(MediaItem mediaItem) async {
    this.mediaItem.add(mediaItem);

    try {
      // Get the stream manifest and choose the best audio-only stream
      final manifest = await _yt.videos.streamsClient.getManifest(mediaItem.id);
      final streamInfo = manifest.audioOnly.withHighestBitrate();
      
      // Set the URL and start playing
      await _player.setSourceUrl(streamInfo.url.toString());
      await play();
    } catch (e) {
      print("Error setting source url: $e");
      stop();
    }
  }

  // This method can be called from the UI to start streaming a track.
  // Note: It now uses the track's YouTube ID.
  void playStreamableTrack(Track track) {
    final mediaItem = MediaItem(
      id: track.id, // Use YouTube video ID for streaming
      title: track.title,
      artist: track.author,
      duration: track.duration,
      artUri: Uri.parse(track.thumbnailUrl),
    );
    playMediaItem(mediaItem);
  }

  // Kept for compatibility, but its usage is now for streaming.
  // It's better to call playStreamableTrack for clarity.
  void playTrack(Track track) {
    playStreamableTrack(track);
  }
}
