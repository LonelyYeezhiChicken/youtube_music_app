import 'package:hive/hive.dart';

part 'track.g.dart';

@HiveType(typeId: 0)
class Track extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String author;

  @HiveField(3)
  final Duration duration;

  @HiveField(4)
  final String filePath;

  @HiveField(5)
  final String thumbnailUrl;

  Track({
    required this.id,
    required this.title,
    required this.author,
    required this.duration,
    required this.filePath,
    required this.thumbnailUrl,
  });
}
