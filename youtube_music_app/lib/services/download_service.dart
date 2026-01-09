import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;

class DownloadService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<String> downloadAudio(Video video, {required Function(double) onProgress}) async {
    final maxRetries = 3;
    for (int retry = 0; retry < maxRetries; retry++) {
      try {
        final streamManifest = await _yt.videos.streamsClient.getManifest(video.id);
        MuxedStreamInfo? streamInfo; // Use MuxedStreamInfo
        if (streamManifest.muxed.isNotEmpty) {
          streamManifest.muxed.sortByVideoQuality();
          streamInfo = streamManifest.muxed.first;
        }

        if (streamInfo != null) {
          final container = streamInfo.container.name; // Use container name for extension
          print('Downloading stream with container: $container');
          print('Stream URL: ${streamInfo.url}');
          
          final appDir = await getApplicationDocumentsDirectory();
          final filePath = '${appDir.path}/${video.id.value}.$container';
          final file = File(filePath);

          final client = http.Client();
          final request = http.Request('GET', streamInfo.url)
            ..headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36'
            ..headers['Referer'] = 'https://www.youtube.com/';
          final response = await client.send(request).timeout(const Duration(seconds: 30)); // Add timeout

          print('HTTP Response Status Code: ${response.statusCode}');

          final contentLength = response.contentLength;
          print('Content-Length: $contentLength');
          if (contentLength == null) {
            throw Exception('Cannot get content length');
          }

          List<int> bytes = [];
          int bytesReceived = 0;

          print('Starting download stream loop...');
          await for (var chunk in response.stream) {
            bytes.addAll(chunk);
            bytesReceived += chunk.length;
            final progress = bytesReceived / contentLength;
            onProgress(progress);
          }
          print('Finished download stream loop.');
          
          print('Total bytes received: ${bytes.length}. Writing to file...');
          await file.writeAsBytes(bytes);
          client.close();
          
          print('Downloaded ${video.title} to $filePath');
          return filePath;
        } else {
          throw Exception('No muxed stream found'); // Changed from No audio-only stream found
        }
      } catch (e) {
        print('Error downloading audio (retry ${retry + 1}/$maxRetries): $e');
        if (retry == maxRetries - 1) rethrow; // Rethrow only after last retry
        await Future.delayed(Duration(seconds: 2)); // Wait before retrying
      }
    }
    throw Exception('Download failed after $maxRetries retries.'); // Should not be reached
  }
} // Add missing closing brace for DownloadService class
