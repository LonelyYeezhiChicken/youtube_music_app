# Design: Hybrid Playback with Synchronized Players

## 1. Problem
The app needs to provide both a visual video experience in the foreground and a seamless background audio experience for the same local media file. This requires two different player technologies (`video_player` and `audioplayers`) to work in concert.

## 2. Proposed Architecture
We will create a system where `audio_service` remains the "master" player, controlling the audio and background lifecycle, while a new `VideoPlayerScreen` acts as a "slave" visualizer that only appears in the foreground.

### 2.1. Core Components
- **`MyAudioHandler` (`audio_service` + `audioplayers`):** This remains the master controller for all playback. It will handle the audio for local files and continue playing it when the app is backgrounded.
- **`VideoPlayerScreen` (`video_player`):** A new screen dedicated to displaying the video frames of a local file. Its lifecycle is tied to the application's foreground state.

### 2.2. Synchronization Mechanism
The key challenge is keeping the video and audio in sync.

1.  **Initiation:** When a user taps a local file, `LibraryScreen` will call `audioHandler.playLocalTrack(track)`.
2.  At the same time, `LibraryScreen` will navigate to the new `VideoPlayerScreen`.
3.  **Video Player Setup:**
    - The `VideoPlayerController` inside `VideoPlayerScreen` will be initialized with the same local file path.
    - **Crucially, the video player will be muted (`_controller.setVolume(0.0)`).** It serves only as a visualizer.
4.  **Syncing Logic:**
    - The `VideoPlayerScreen` will listen to the `audioHandler.playbackState` stream.
    - On each position update from `audio_service`, the `VideoPlayerScreen` will compare the audio player's position with the video player's position.
    - If they drift apart by more than a small threshold (e.g., 250ms), it will call `_videoController.seekTo()` to re-align the video with the master audio track. This prevents drift over time.
    - The `VideoPlayer` will also be paused and played in response to the state from `audioHandler`, not its own controls.

### 2.3. Lifecycle Management
- When the `VideoPlayerScreen` is opened, it starts its controller and begins syncing to the `audio_service`'s state.
- When the user navigates away from `VideoPlayerScreen` or backgrounds the app, the `VideoPlayerScreen` is disposed of, and its `VideoPlayerController` is destroyed.
- The `audio_service` continues playing the audio in the background, completely unaware that the foreground visualizer is gone.

This architecture is complex but isolates the responsibilities: `audio_service` is the master of time and sound, and `VideoPlayerScreen` is only a reactive, disposable visualizer.
