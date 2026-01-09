import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
// import 'package:mockito/annotations.dart'; // No longer needed
// import 'package:mockito/mockito.dart'; // No longer needed
import 'package:youtube_music_app/models/track.dart';
import 'package:youtube_music_app/services/database_service.dart';

// import 'database_service_test.mocks.dart'; // No longer needed

// @GenerateMocks([Box]) // No longer needed
void main() {
  group('DatabaseService', () {
    late DatabaseService databaseService;
    late Box<Track> testBox; // Use a real Box for testing

    setUp(() async {
      Hive.initForTest(); // Initialize Hive for testing
      testBox = await Hive.openBox<Track>('testTracks'); // Open a specific test box

      databaseService = DatabaseService.internal(trackBox: testBox); // Inject the testBox
      // No need to call databaseService.init() if box is injected
    });

    tearDown(() async {
      await testBox.close();
      await Hive.deleteFromDisk();
    });

    test('addTrack adds a track to the box', () async {
      // Arrange
      final track = Track(
        id: 'testId',
        title: 'Test Title',
        author: 'Test Author',
        duration: Duration(seconds: 100),
        filePath: '/path/to/test.mp4',
        thumbnailUrl: 'http://thumbnail.com/test.jpg',
      );

      // Act
      await databaseService.addTrack(track);

      // Assert
      expect(testBox.get(track.id), track);
    });

    test('getTracks returns a list of tracks', () async {
      // Arrange
      final track1 = Track(id: 'id1', title: 'Title1', author: 'Author1', duration: Duration(seconds: 10), filePath: 'path1', thumbnailUrl: 'thumb1');
      final track2 = Track(id: 'id2', title: 'Title2', author: 'Author2', duration: Duration(seconds: 20), filePath: 'path2', thumbnailUrl: 'thumb2');
      await testBox.put(track1.id, track1);
      await testBox.put(track2.id, track2);

      // Act
      final tracks = databaseService.getTracks();

      // Assert
      expect(tracks, hasLength(2));
      expect(tracks.first.id, 'id1');
    });

    test('deleteTrack deletes a track from the box', () async {
      // Arrange
      final trackId = 'testId';
      final track = Track(id: trackId, title: 'Title', author: 'Author', duration: Duration(seconds: 10), filePath: 'path', thumbnailUrl: 'thumb');
      await testBox.put(trackId, track);

      // Act
      await databaseService.deleteTrack(trackId);

      // Assert
      expect(testBox.get(trackId), isNull);
    });

    test('getTracks returns an empty list when no tracks are present', () async {
      // Arrange - testBox is empty from setUp

      // Act
      final tracks = databaseService.getTracks();

      // Assert
      expect(tracks, isEmpty);
    });
  });
}

// Extension to initialize Hive for testing (in-memory)
// This is required because Hive.init expects a path, which is not available in unit tests.
extension HiveTestInit on HiveInterface {
  void initForTest() {
    init(null);
  }
}
