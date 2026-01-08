import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'models/duration_adapter.dart';
import 'models/track.dart';
import 'screens/library_screen.dart';
import 'services/audio_handler.dart';
import 'services/database_service.dart';
import 'services/download_service.dart';
import 'services/youtube_service.dart';
import 'widgets/mini_player.dart';

late AudioHandler audioHandler;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize audio service first, as it might spawn isolates that conflict with db setup.
  audioHandler = await initAudioService();

  // Then initialize Hive for the main isolate.
  await Hive.initFlutter();
  Hive.registerAdapter(TrackAdapter());
  Hive.registerAdapter(DurationAdapter()); // Register DurationAdapter
  await DatabaseService().init();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YT Music',
      theme: ThemeData(
        primarySwatch: Colors.red,
        brightness: Brightness.dark,
      ),
      home: const SearchScreen(),
    );
  }
}
// ... (rest of the file remains the same for now)

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final YoutubeService _youtubeService = YoutubeService();
  final DownloadService _downloadService = DownloadService();
  final DatabaseService _databaseService = DatabaseService();

  List<Video> _videos = [];
  bool _isLoading = false;
  final Set<String> _downloadingVideos = {};
  final Map<String, double> _downloadProgress = {};

  Future<void> _performSearch() async {
    final query = _searchController.text;
    if (query.isEmpty) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final videos = await _youtubeService.searchVideos(query);

    setState(() {
      _videos = videos;
      _isLoading = false;
    });
  }

  Future<void> _onDownload(Video video) async {
    final videoId = video.id.value;
    if (_downloadingVideos.contains(videoId)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Already downloading!')),
      );
      return;
    }

    setState(() {
      _downloadingVideos.add(videoId);
      _downloadProgress[videoId] = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download started for "${video.title}"')),
    );

    try {
      final filePath = await _downloadService.downloadAudio(video, onProgress: (progress) {
        setState(() {
          _downloadProgress[videoId] = progress;
        });
      });

      final track = Track(
        id: video.id.value,
        title: video.title,
        author: video.author,
        duration: video.duration ?? Duration.zero,
        filePath: filePath,
        thumbnailUrl: video.thumbnails.mediumResUrl,
      );
      await _databaseService.addTrack(track);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Finished downloading and saved "${video.title}"')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error downloading "${video.title}": $e')),
      );
    } finally {
      setState(() {
        _downloadingVideos.remove(videoId);
        _downloadProgress.remove(videoId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search YouTube Music'),
        actions: [
          IconButton(
            icon: const Icon(Icons.library_music),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LibraryScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: 'Search for a song',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _performSearch,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    onSubmitted: (_) => _performSearch(),
                  ),
                ),
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _videos.length,
                          itemBuilder: (context, index) {
                            final video = _videos[index];
                            final videoId = video.id.value;
                            final isDownloading = _downloadingVideos.contains(videoId);
                            final progress = _downloadProgress[videoId] ?? 0.0;

                            return Card(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                              child: ListTile(
                                leading: Image.network(video.thumbnails.mediumResUrl),
                                title: Text(
                                  video.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(video.author),
                                trailing: isDownloading
                                    ? SizedBox(
                                        width: 100, // Adjusted width to accommodate progress indicator better
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            LinearProgressIndicator(value: progress),
                                            const SizedBox(height: 4),
                                            Text('${(progress * 100).toStringAsFixed(0)}%'),
                                          ],
                                        ),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // Play remote track button
                                          IconButton(
                                            icon: const Icon(Icons.play_arrow),
                                            onPressed: () {
                                              final tracks = _videos.map((videoItem) => Track(
                                                id: videoItem.id.value,
                                                title: videoItem.title,
                                                author: videoItem.author,
                                                duration: videoItem.duration ?? Duration.zero,
                                                filePath: '', // No local file path for streaming
                                                thumbnailUrl: videoItem.thumbnails.mediumResUrl,
                                              )).toList();
                                              (audioHandler as MyAudioHandler).playTrackList(tracks, index);
                                            },
                                          ),
                                          // Download button or duration text
                                          IconButton(
                                            icon: const Icon(Icons.download),
                                            onPressed: isDownloading ? null : () => _onDownload(video),
                                          ),
                                        ],
                                      ),
                                onTap: isDownloading ? null : () => _onDownload(video), // Keep download on main tap
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          MiniPlayer(),
        ],
      ),
    );
  }
}
