import 'package:hive/hive.dart';
import '../models/track.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  late Box<Track> _tracksBox;

  Future<void> init() async {
    _tracksBox = await Hive.openBox<Track>('tracks');
  }

  Future<void> addTrack(Track track) {
    return _tracksBox.put(track.id, track);
  }

  List<Track> getTracks() {
    return _tracksBox.values.toList();
  }

  Future<void> deleteTrack(String id) {
    return _tracksBox.delete(id);
  }
}
