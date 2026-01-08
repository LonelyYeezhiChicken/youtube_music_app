# Design: Unified Background Audio Architecture

## 1. Problem
The current architecture has two disconnected playback systems:
1.  `VideoPlayerScreen`: A foreground-only player for local `.mp4` files.
2.  `MyAudioHandler` (`audio_service`): A streaming-only audio handler.

This split architecture prevents a consistent background audio experience and adds unnecessary complexity. Sending the app to the background kills the audio session.

## 2. Proposed Solution: Unify Under `audio_service`
We will refactor the application to use `audio_service` as the single source of truth for all audio playback. This is the standard, recommended practice for building robust audio applications in Flutter.

### 2.1. Refactor `MyAudioHandler`
The handler will become the central point for playback logic.

- **`playMediaItem(MediaItem mediaItem)`:** This core method will be enhanced to determine the source of the media. It will inspect the `mediaItem.id`.
    - If the `id` is a network URL (starts with `http`), it will use `_player.setSourceUrl()`.
    - If the `id` is a local file path, it will use `_player.setSourceDeviceFile()`.
- **Stream vs. File Logic:**
    - To stream a new track (e.g., from search), the UI will call a method like `playStreamableTrack(Track track)`. This method will fetch the YouTube stream URL and then create a `MediaItem` with the `id` set to that URL, then call `playMediaItem`.
    - To play a downloaded file, the UI will call `playLocalTrack(Track track)`. This method will create a `MediaItem` with the `id` set to the track's `filePath` and call `playMediaItem`.

### 2.2. UI and Player Screen Unification
- The `VideoPlayerScreen` (`lib/screens/video_player_screen.dart`) will be **deleted**. Its role as a detailed player view is superseded by the system notification and lock screen controls provided by `audio_service`.
- The `MiniPlayer` widget will become the primary in-app interface for controlling ongoing playback.
- **`LibraryScreen`:** The "play" icon on each track will no longer navigate to a new screen. Instead, it will call `audioHandler.playLocalTrack(track)`.
- **`SearchScreen`:** A "play" icon should be added to each search result. This will call `audioHandler.playStreamableTrack(track)` to begin streaming.

### 2.3. Native Configuration
- **iOS:** In `ios/Runner/Info.plist`, we will ensure the `UIBackgroundModes` key exists with the `audio` value.
- **Android:** The `AndroidManifest.xml` is already configured with a `foregroundServiceType` of `mediaPlayback` from our previous fix, which is correct for this use case. No further changes should be needed, but we will verify.

## 3. Benefits of Unification
- **Consistent Background Playback:** The app will behave as users expect, with audio continuing in the background.
- **Simplified Codebase:** Removing the `VideoPlayerScreen` and the separate playback logic reduces complexity and potential bugs.
- **Native Integration:** Full use of `audio_service` provides native lock screen and notification controls for free.
