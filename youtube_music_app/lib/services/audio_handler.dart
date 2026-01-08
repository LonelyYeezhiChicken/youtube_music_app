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
      if (mediaItem.extras?['is_local_file'] == true) {
        // Play from local file
        await _player.setSourceDeviceFile(mediaItem.id);
      } else {
        // Play from YouTube stream (assuming mediaItem.id is YouTube Video ID)
        final manifest = await _yt.videos.streamsClient.getManifest(mediaItem.id);
        final streamInfo = manifest.audioOnly.withHighestBitrate();
        await _player.setSourceUrl(streamInfo.url.toString());
      }
      await play();
    } catch (e) {
      print("Error playing media: $e");
      stop();
    }
  }

  /// Plays a track from a remote YouTube stream.
  void playRemoteTrack(Track track) {
    final mediaItem = MediaItem(
      id: track.id, // YouTube Video ID for streaming
      title: track.title,
      artist: track.author,
      duration: track.duration,
      artUri: Uri.parse(track.thumbnailUrl),
      extras: {'is_local_file': false},
    );
    playMediaItem(mediaItem);
  }

  /// Plays a track from a local downloaded file.
  void playLocalTrack(Track track) {
    final mediaItem = MediaItem(
      id: track.filePath, // Local file path
      title: track.title,
      artist: track.author,
      duration: track.duration,
      artUri: Uri.parse(track.thumbnailUrl),
      extras: {'is_local_file': true},
    );
    playMediaItem(mediaItem);
  }
}
