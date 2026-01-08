import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeService {
  final YoutubeExplode _yt;

  YoutubeService() : _yt = YoutubeExplode();

  Future<List<Video>> searchVideos(String query) async {
    try {
      final searchResult = await _yt.search.search(query);
      return searchResult.toList();
    } catch (e) {
      print('Error searching videos: $e');
      return [];
    }
  }
}
