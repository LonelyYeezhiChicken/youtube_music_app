import 'package:flutter_test/flutter_test.dart';
import 'package:youtube_music_app/services/youtube_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('YoutubeService', () {
    test('searchVideos returns a list of videos', () async {
      final youtubeService = YoutubeService();
      final videos = await youtubeService.searchVideos('flutter');
      expect(videos, isNotEmpty);
    });
  });
}
