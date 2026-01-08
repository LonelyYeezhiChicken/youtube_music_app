# Tasks for `implement-hybrid-playback`

- [x] 1. **Re-add Dependencies:**
    - [x] 1.1. Add the `video_player` and `video_player_win` packages back to `pubspec.yaml`.
    - [x] 1.2. Run `flutter pub get`.

- [x] 2. **Re-create `VideoPlayerScreen`:**
    - [x] 2.1. Create a new file `lib/screens/video_player_screen.dart`.
    - [x] 2.2. Build a stateful widget `VideoPlayerScreen` that takes a local file path as an argument.

- [x] 3. **Implement Synchronization Logic:**
    - [x] 3.1. In `VideoPlayerScreen`, initialize a `VideoPlayerController` with the given file path.
    - [x] 3.2. Mute the video player controller: `_controller.setVolume(0.0)`.
    - [x] 3.3. Add a `StreamBuilder` to listen to `audioHandler.playbackState`.
    - [x] 3.4. Inside the `StreamBuilder`, synchronize the video player. When the `audioHandler` is playing, call `_controller.play()`. When paused, call `_controller.pause()`.
    - [x] 3.5. Periodically check the position from `audioHandler.playbackState.position` against `_controller.value.position`. If they differ by a significant margin (e.g., > 250ms), call `_controller.seekTo()` to resynchronize.
    - [x] 3.6. Ensure the `VideoPlayerController` is disposed of properly when the widget is disposed.

- [x] 4. **Update `LibraryScreen` Navigation:**
    - [x] 4.1. In `lib/screens/library_screen.dart`, when a local track's play button is pressed:
        - Call `(audioHandler as MyAudioHandler).playLocalTrack(track)` to start the audio playback via `audio_service`.
        - Immediately after, navigate to the new `VideoPlayerScreen`, passing the `track.filePath`.

- [in_progress] 5. **Validation:**
    - [ ] 5.1. Play a downloaded track from the library.
    - [ ] 5.2. Verify that the `VideoPlayerScreen` opens and shows the video (muted) in sync with the audio.
    - [ ] 5.3. Background the app and verify the audio continues to play.
    - [ ] 5.4. Return to the app and verify the video screen re-appears and re-syncs with the audio.
    - [ ] 5.5. Test pausing and playing from the `MiniPlayer` or system notification and ensure both the audio and video react accordingly.
