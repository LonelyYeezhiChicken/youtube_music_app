import 'dart:io';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../models/track.dart';
import '../services/audio_handler.dart';
import '../services/database_service.dart';
import '../widgets/mini_player.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  late List<Track> _tracks;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTracks();
  }

  void _loadTracks() {
    setState(() {
      _tracks = DatabaseService().getTracks();
      _isLoading = false;
    });
  }

  Future<void> _deleteTrack(Track track) async {
    try {
      final file = File(track.filePath);
      if (await file.exists()) {
        await file.delete();
      }
      await DatabaseService().deleteTrack(track.id);
      _loadTracks();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('"${track.title}" has been deleted.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting track: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _tracks.isEmpty
                    ? const Center(child: Text('No downloaded music yet.'))
                    : ListView.builder(
                        itemCount: _tracks.length,
                        itemBuilder: (context, index) {
                          final track = _tracks[index];
                          return ListTile(
                            leading: Image.network(track.thumbnailUrl),
                            title: Text(track.title),
                            subtitle: Text(track.author),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () {
                                    (audioHandler as MyAudioHandler).playLocalTrack(track);
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Delete Track'),
                                        content: Text('Are you sure you want to delete "${track.title}"?'),
                                        actions: [
                                          TextButton(
                                            child: const Text('Cancel'),
                                            onPressed: () => Navigator.of(context).pop(),
                                          ),
                                          TextButton(
                                            child: const Text('Delete'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                              _deleteTrack(track);
                                            },
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Version: 1.0.1', style: Theme.of(context).textTheme.bodySmall), // Hardcoded version
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}