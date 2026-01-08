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
  int _nextMediaId = 0;
  List<MediaItem> _queue = [];
  int _queueIndex = -1;


  MyAudioHandler() {
    _player.onPlayerStateChanged.listen((playerState) {
      final isPlaying = playerState == PlayerState.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          if (isPlaying) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
        ],
        processingState: AudioProcessingState.ready,
        playing: isPlaying,
      ));
    });

    _player.onPositionChanged.listen((position) {
      if (mediaItem.value != null) {
        playbackState.add(
          playbackState.value.copyWith(
            updatePosition: position,
          ),
        );
      }
    });

    _player.onPlayerComplete.listen((event) {
      if (playbackState.value.playing) {
        skipToNext();
      }
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
    // If the item is not in the queue, add it.
    if (_queue.indexWhere((item) => item.id == mediaItem.id) == -1) {
      addQueueItem(mediaItem);
    }
    _queueIndex = _queue.indexWhere((item) => item.id == mediaItem.id);


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
    } catch (e, s) {
      print("Error playing media: $e");
      print("Stack trace: $s");
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
  /// Plays a list of tracks, starting from a specific index.
  Future<void> playTrackList(List<Track> tracks, int initialIndex) async {
    final mediaItems = tracks.map((track) {
      final isLocal = track.filePath.isNotEmpty;
      return MediaItem(
        id: isLocal ? track.filePath : track.id, // Use file path for local, video id for remote
        title: track.title,
        artist: track.author,
        duration: track.duration,
        artUri: Uri.parse(track.thumbnailUrl),
        extras: {'is_local_file': isLocal},
      );
    }).toList();

    await updateQueue(mediaItems);
    await skipToQueueItem(initialIndex);
  }

  @override
  Future<void> skipToNext() async {
    if (_queueIndex + 1 < _queue.length) {
      _queueIndex++;
      playMediaItem(_queue[_queueIndex]);
    }
  }

  @override
  Future<void> skipToPrevious() async {
    if (_queueIndex - 1 >= 0) {
      _queueIndex--;
      playMediaItem(_queue[_queueIndex]);
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index >= 0 && index < _queue.length) {
      _queueIndex = index;
      playMediaItem(_queue[_queueIndex]);
    }
  }

  @override
  Future<void> addQueueItem(MediaItem mediaItem) async {
    _queue.add(mediaItem);
    updateQueue(_queue);
  }
  
  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    _queue.addAll(mediaItems);
    updateQueue(_queue);
  }

  @override
  Future<void> updateQueue(List<MediaItem> newQueue) async {
    _queue = newQueue;
    queue.add(_queue);
  }
}
