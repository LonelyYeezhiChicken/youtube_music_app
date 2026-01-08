# Proposal: Enable Background Audio Playback

**Goal:** Enable the application to continue playing audio when it is in the background or the device screen is locked. This functionality should apply to both streamed audio and locally downloaded files.

**Current Behavior:** Audio playback stops immediately when the application is sent to the background. This is because playback for local files is handled by `VideoPlayerScreen`, which is foreground-only, and the streaming handler is not fully integrated into the app's lifecycle for background execution.

**Proposed Behavior:** All audio playback will be unified under the `audio_service` package. This will provide a single, robust playback system that persists in the background. When a user starts playing any track (streamed or local), the audio will continue after the app is backgrounded. The system's media controls on the lock screen and in the notification shade will be active and will control the app's playback.
