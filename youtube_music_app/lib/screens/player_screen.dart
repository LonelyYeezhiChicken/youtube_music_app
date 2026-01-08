import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../main.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Now Playing'),
      ),
      body: StreamBuilder<MediaItem?>(
        stream: audioHandler.mediaItem,
        builder: (context, mediaItemSnapshot) {
          final mediaItem = mediaItemSnapshot.data;
          if (mediaItem == null) {
            return const Center(child: Text('Nothing Playing'));
          }

          return StreamBuilder<PlaybackState>(
            stream: audioHandler.playbackState,
            builder: (context, playbackStateSnapshot) {
              final playbackState = playbackStateSnapshot.data;
              final isPlaying = playbackState?.playing ?? false;
              final position = playbackState?.updatePosition ?? Duration.zero;
              final duration = mediaItem.duration ?? Duration.zero;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Artwork
                    Expanded(
                      flex: 3,
                      child: mediaItem.artUri != null
                          ? Image.network(
                              mediaItem.artUri.toString(),
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stack) => const Icon(Icons.music_note, size: 150),
                            )
                          : const Icon(Icons.music_note, size: 150),
                    ),
                    const SizedBox(height: 20),

                    // Title and Artist
                    Text(
                      mediaItem.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      mediaItem.artist ?? 'Unknown Artist',
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Seek Bar
                    Slider(
                      value: position.inSeconds.toDouble(),
                      max: duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        audioHandler.seek(Duration(seconds: value.toInt()));
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(_formatDuration(position)),
                          Text(_formatDuration(duration)),
                        ],
                      ),
                    ),

                    // Controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.skip_previous),
                          iconSize: 48.0,
                          onPressed: audioHandler.skipToPrevious,
                        ),
                        IconButton(
                          icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                          iconSize: 64.0,
                          onPressed: isPlaying ? audioHandler.pause : audioHandler.play,
                        ),
                        IconButton(
                          icon: const Icon(Icons.skip_next),
                          iconSize: 48.0,
                          onPressed: audioHandler.skipToNext,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Queue
                    Text('Up Next', style: Theme.of(context).textTheme.titleLarge),
                    Expanded(
                      flex: 2,
                      child: StreamBuilder<List<MediaItem>>(
                        stream: audioHandler.queue,
                        builder: (context, queueSnapshot) {
                          final queue = queueSnapshot.data ?? [];
                          return ListView.builder(
                            itemCount: queue.length,
                            itemBuilder: (context, index) {
                              final item = queue[index];
                              return ListTile(
                                title: Text(item.title),
                                subtitle: Text(item.artist ?? ''),
                                onTap: () {
                                  audioHandler.skipToQueueItem(index);
                                },
                                leading: item.artUri != null ? Image.network(item.artUri.toString()) : null,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
