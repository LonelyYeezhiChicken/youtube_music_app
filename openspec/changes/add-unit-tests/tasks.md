# Tasks for `add-unit-tests`

- [ ] 1. **Dependency Setup:**
    - [ ] 1.1. Add `mockito` (or a suitable mocking framework) to `dev_dependencies` in `pubspec.yaml` and run `flutter pub get`.

- [ ] 2. **Unit Tests for `youtube_service.dart`:**
    - [ ] 2.1. Create `test/services/youtube_service_test.dart`.
    - [ ] 2.2. Write tests for `searchVideos()`:
        - [ ] Test successful video search.
        - [ ] Test empty search query.
        - [ ] Test error handling (e.g., network issues, `youtube_explode_dart` exceptions).

- [ ] 3. **Unit Tests for `database_service.dart`:**
    - [ ] 3.1. Create `test/services/database_service_test.dart`.
    - [ ] 3.2. Write tests for `addTrack()`, `getTracks()`, `deleteTrack()`:
        - [ ] Test adding a track.
        - [ ] Test retrieving all tracks.
        - [ ] Test deleting a track.
        - [ ] Test behavior with an empty database.
        - [ ] Test data persistence (if mocking Hive is feasible).

- [ ] 4. **Unit Tests for `download_service.dart`:**
    - [ ] 4.1. Create `test/services/download_service_test.dart`.
    - [ ] 4.2. Write tests for `downloadAudio()`:
        - [ ] Test successful download (mock `http.Client` and `youtube_explode_dart`).
        - [ ] Test download progress callback.
        - [ ] Test `ClientException` handling and retry mechanism.
        - [ ] Test error handling (e.g., no stream found, network errors).
        - [ ] Test file writing (mock `dart:io` operations).

- [ ] 5. **Unit Tests for `audio_handler.dart`:**
    - [ ] 5.1. Create `test/services/audio_handler_test.dart`.
    - [ ] 5.2. Write tests for `playMediaItem()`, `playRemoteTrack()`, `playLocalTrack()`, `skipToNext()`, `skipToPrevious()`, `addQueueItem()`, `updateQueue()`:
        - [ ] Test playing a remote track.
        - [ ] Test playing a local track.
        - [ ] Test play/pause/stop functionality.
        - [ ] Test queue management (add, skip next/previous).
        - [ ] Test error handling during playback.

- [ ] 6. **Validation:**
    - [ ] 6.1. Run all unit tests (`flutter test`) and ensure they pass.
    - [ ] 6.2. Verify test coverage for the tested service layers.
