# Design: Full-Screen Player with Queue Management

## 1. Problem
The user lacks a dedicated in-app interface to view the current playback queue and interact with a full-featured player. The existing `MyAudioHandler` is also designed to handle only one track at a time, with no concept of a playlist or queue.

## 2. Proposed Solution: State-Driven UI with a Queued Audio Handler
The solution is to create a new `PlayerScreen` that is a "dumb" view reflecting the state of `MyAudioHandler`, and upgrade `MyAudioHandler` to manage a playback queue.

### 2.1. `MyAudioHandler` Refactor for Queue Support
`audio_service` has first-class support for a playback queue. We will leverage this.

- The `MyAudioHandler` will now hold the entire playlist in its `queue` state.
- **New `updatePlaylist(List<Track> tracks, bool isLocal)` method:** A new method will be added to the handler. This method will convert a list of `Track` objects into a list of `MediaItem`s and update the handler's queue via `updateQueue()`.
- **Playback Initiation:** Methods like `playLocalTrack` and `playRemoteTrack` will now be responsible for calling `updatePlaylist` first, and then calling `skipToQueueItem(index)` to start playback of a specific track within that new queue. This ensures the handler is always aware of the full context.
- **Native Queue Commands:** The handler will override `skipToNext()` and `skipToPrevious()` to call the superclass methods, which `audio_service` uses to automatically navigate the queue. This provides working next/previous controls on the lock screen and in notifications.

### 2.2. New `PlayerScreen` (`lib/screens/player_screen.dart`)
This screen will be a state-driven UI that purely visualizes the state of `MyAudioHandler`.

- **State Listening:** The widget will be composed of `StreamBuilder`s connected to `audioHandler`:
    - `StreamBuilder<MediaItem?>` listening to `audioHandler.mediaItem` for the current track's metadata (art, title, artist).
    - `StreamBuilder<PlaybackState>` listening to `audioHandler.playbackState` for play/pause state, current position, and total duration (for the seek bar).
    - `StreamBuilder<List<MediaItem>>` listening to `audioHandler.queue` for the list of tracks to display.
- **Controls:** All buttons on this screen (Play, Pause, Next, Previous, Seek) will simply delegate to the global `audioHandler` instance (e.g., `audioHandler.play()`, `audioHandler.seek(position)`). The UI will then update automatically via the streams.

### 2.3. Navigation
- The `MiniPlayer` widget (`lib/widgets/mini_player.dart`) will be wrapped in a `GestureDetector`.
- The `onTap` event will trigger a standard `Navigator.push` to the new `PlayerScreen`. Since the `PlayerScreen` reads its state globally from `audioHandler`, no arguments need to be passed during navigation.

This architecture creates a reactive and robust system where the UI is completely decoupled from the audio logic, which is the standard and recommended pattern when using `audio_service`.
