# Tasks for `implement-video-player-with-controls`

- [x] 1. **Dependency:** Add the `video_player` package to the `pubspec.yaml` file and run `flutter pub get`.
- [x] 2. **Scaffold Player Screen:** Create a new file `lib/screens/video_player_screen.dart` and define a new stateful widget named `VideoPlayerScreen`.
- [x] 3. **Player Screen UI:** Design and build the UI for `VideoPlayerScreen`. It should include:
    - A main area for the `VideoPlayer` widget.
    - An overlay or bottom bar for control buttons: "Previous," "Play/Pause," and "Next."
- [x] 4. **Navigation:**
    - Modify the `LibraryScreen` so that tapping a downloaded track navigates to `VideoPlayerScreen`.
    - Pass the full list of downloaded track paths and the tapped track's index as arguments to `VideoPlayerScreen`.
- [x] 5. **Controller Initialization:** In `VideoPlayerScreen`, initialize a `VideoPlayerController` with the file path of the track passed in the arguments.
- [x] 6. **Implement Play/Pause:** Wire up the "Play/Pause" button to call `_controller.play()` or `_controller.pause()` and update the button's icon accordingly.
- [x] 7. **Implement "Next" Logic:** When the "Next" button is pressed, increment the current track index (looping to 0 if at the end), dispose of the old controller, and initialize a new controller for the next track.
- [x] 8. **Implement "Previous" Logic:** When the "Previous" button is pressed, decrement the current track index (looping to the end if at 0), dispose of the old controller, and initialize a new controller for the previous track.
- [x] 9. **Lifecycle Management:** Ensure the `VideoPlayerController` is properly disposed of when the `VideoPlayerScreen` is closed.
- [x] 10. **Validation:**
    - [x] 10.1 Test that a downloaded `.mp4` file opens and plays in the new `VideoPlayerScreen`.
    - [x] 10.2 Test the "Play/Pause" functionality.
    - [x] 10.3 Test the "Next" and "Previous" buttons, ensuring they correctly navigate through the track list and loop around.
- [ ] 11. **(Optional) Code Cleanup:** Remove the now-unused `audioplayers` logic if it's no longer needed for any other feature.
