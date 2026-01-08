import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../screens/player_screen.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MediaItem?>(
      stream: audioHandler.mediaItem,
      builder: (context, mediaItemSnapshot) {
        final mediaItem = mediaItemSnapshot.data;
        if (mediaItem == null) {
          return const SizedBox.shrink();
        }
        return Container(
          color: Colors.black.withOpacity(0.8),
          child: StreamBuilder<PlaybackState>(
            stream: audioHandler.playbackState,
            builder: (context, playbackStateSnapshot) {
              final playbackState = playbackStateSnapshot.data;
              final isPlaying = playbackState?.playing ?? false;
              final position = playbackState?.position ?? Duration.zero;
              final duration = mediaItem.duration ?? Duration.zero;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (duration != Duration.zero)
                    LinearProgressIndicator(
                      value: (duration.inSeconds == 0) ? 0 : position.inSeconds / duration.inSeconds,
                      backgroundColor: Colors.grey.shade700,
                    ),
                  ListTile(
                    leading: mediaItem.artUri != null ? Image.network(mediaItem.artUri.toString()) : null,
                    title: Text(mediaItem.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text(mediaItem.artist ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: isPlaying ? const Icon(Icons.pause) : const Icon(Icons.play_arrow),
                      onPressed: () {
                        if (isPlaying) {
                          audioHandler.pause();
                        } else {
                          audioHandler.play();
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PlayerScreen()),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
