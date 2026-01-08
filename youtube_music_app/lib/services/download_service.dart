import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;

class DownloadService {
  final YoutubeExplode _yt = YoutubeExplode();

  Future<String> downloadAudio(Video video, {required Function(double) onProgress}) async {
    try {
      final streamManifest = await _yt.videos.streamsClient.getManifest(video.id);
      MuxedStreamInfo? streamInfo;
      if (streamManifest.muxed.isNotEmpty) {
        streamInfo = streamManifest.muxed.reduce((a, b) =>
            a.videoResolution.height > b.videoResolution.height ? a : b);
      }

      if (streamInfo != null) {
        final container = streamInfo.container.name;
        print('Downloading stream with container: $container');
        print('Stream URL: ${streamInfo.url}');
        
        final appDir = await getApplicationDocumentsDirectory();
        final filePath = '${appDir.path}/${video.id.value}.$container';
        final file = File(filePath);

        final client = http.Client();
        final request = http.Request('GET', streamInfo.url);
        request.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36';
        final response = await client.send(request);

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
          print('Received chunk of size: ${chunk.length}');
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
        throw Exception('No audio stream found');
      }
    } catch (e) {
      print('Error downloading audio: $e');
      rethrow;
    }
  }
}
