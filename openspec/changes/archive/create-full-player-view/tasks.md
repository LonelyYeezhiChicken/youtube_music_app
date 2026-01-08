# Tasks for `create-full-player-view`

- [x] 1. **Refactor `MyAudioHandler` for Queue Management:**
    - [x] 1.1. In `lib/services/audio_handler.dart`, modify the handler to manage a `List<MediaItem>` as the queue.
    - [x] 1.2. Instead of playing items immediately, `playLocalTrack` and `playRemoteTrack` will now first build a list of `MediaItem`s from the provided `Track` list, call `updateQueue()` to set the playlist, and then call `skipToQueueItem()` to start playing the selected track.
    - [x] 1.3. Implement the `skipToNext()` and `skipToPrevious()` overrides to enable queue navigation from native controls.

- [x] 2. **Create `PlayerScreen` UI:**
    - [x] 2.1. Create a new file `lib/screens/player_screen.dart`.
    - [x] 2.2. Build the UI for `PlayerScreen` using `StreamBuilder`s to listen to `audioHandler.mediaItem`, `audioHandler.playbackState`, and `audioHandler.queue`.
    - [x] 2.3. The UI should include: a large artwork display, title/artist text, a seek bar, play/pause/next/previous buttons, and a list of the tracks in the queue.

- [x] 3. **Implement `PlayerScreen` Controls:**
    - [x] 3.1. Connect the play, pause, skip, and seek controls on the `PlayerScreen` UI to their corresponding methods on the `audioHandler` instance (e.g., `audioHandler.play()`, `audioHandler.seek()`).

- [x] 4. **Update UI Navigation:**
    - [x] 4.1. In `lib/widgets/mini_player.dart`, wrap the main widget in a `GestureDetector` and use its `onTap` to navigate to the new `PlayerScreen`.
    - [x] 4.2. In `lib/library_screen.dart`, modify the `onPressed` logic to pass the entire `_tracks` list to the new handler method that builds the queue.
    - [x] 4.3. In `lib/main.dart` (`SearchScreen`), modify the `onPressed` logic to pass a list containing just the single track to the handler, which will form a queue of one.

- [ ] 5. **Validation:**
    - [ ] 5.1. Start playing a track from the library or search screen.
    - [ ] 5.2. Tap the `MiniPlayer` and verify that it navigates to the `PlayerScreen`.
    - [ ] 5.3. Verify the `PlayerScreen` correctly shows the current track's info, playback state, and the full queue.
    - [ ] 5.4. Test all controls (play, pause, seek, next, previous) on the `PlayerScreen` and confirm they work as expected.
    - [ ] 5.5. Play a track and switch to another app; verify the lock screen controls can still control playback.
