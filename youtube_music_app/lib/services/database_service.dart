import 'package:hive/hive.dart';
import '../models/track.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal({Box<Track>? trackBox}) { // Add optional trackBox parameter
    if (trackBox != null) {
      _tracksBox = trackBox;
    }
  }

  late Box<Track> _tracksBox;

  Future<void> init() async {
    if (!Hive.isBoxOpen('tracks')) { // Only open if not already open (e.g., injected)
      _tracksBox = await Hive.openBox<Track>('tracks');
    }
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
