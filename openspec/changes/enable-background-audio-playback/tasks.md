# Tasks for `enable-background-audio-playback`

- [x] 1. **Refactor `MyAudioHandler`:**
    - [x] 1.1. In `lib/services/audio_handler.dart`, modify `playMediaItem` to check if the `mediaItem.id` is a local file path or a network URL and call the appropriate `_player.setSource` method (`setSourceDeviceFile` or `setSourceUrl`).
    - [x] 1.2. Rename `playStreamableTrack` to `playRemoteTrack` for clarity. This method will fetch the YouTube stream URL and create a `MediaItem` where `id` is the URL.
    - [x] 1.3. Create a new method `playLocalTrack(Track track)` that creates a `MediaItem` where `id` is the `track.filePath`.
    - [x] 1.4. Deprecate or remove the generic `playTrack` method to enforce clearer intent from the caller.

- [x] 2. **Refactor `LibraryScreen`:**
    - [x] 2.1. In `lib/screens/library_screen.dart`, remove the navigation logic to `VideoPlayerScreen`.
    - [x] 2.2. Change the "play" button's `onPressed` callback to call `(audioHandler as MyAudioHandler).playLocalTrack(track)`.

- [x] 3. **Refactor `SearchScreen`:**
    - [x] 3.1. In `lib/main.dart`, add a "play" `IconButton` to the `ListTile` for each search result.
    - [x] 3.2. The `onPressed` callback for this new button should call `(audioHandler as MyAudioHandler).playRemoteTrack(track)`.

- [x] 4. **Remove Redundant Code:**
    - [x] 4.1. Delete the file `lib/screens/video_player_screen.dart`.
    - [x] 4.2. Remove the `video_player` and `video_player_win` packages from `pubspec.yaml` and run `flutter pub get`.

- [x] 5. **iOS Configuration:**
    - [x] 5.1. Check `ios/Runner/Info.plist` and add the `audio` key to `UIBackgroundModes` if not present.

- [x] 6. **Android Configuration:**
    - [x] Re-verify `AndroidManifest.xml` to ensure the `service`, `receiver`, and permissions are correct for foreground service operation. (This should be correct from the last fix, but it's good to verify).

- [x] 7. **Validation:**
    - [x] 7.1. Start streaming a track from the search screen, send the app to the background, and confirm audio continues to play.
    - [x] 7.2. Play a downloaded track from the library screen, send the app to the background, and confirm audio continues.
    - [x] 7.3. For both cases, verify that the system media controls (on the lock screen/notification shade) correctly display track info and control playback (play/pause).
    - [x] 7.4. Test "next" and "previous" track functionality from the lock screen controls (if `audio_service` queue is implemented, which is a future step but good to check).