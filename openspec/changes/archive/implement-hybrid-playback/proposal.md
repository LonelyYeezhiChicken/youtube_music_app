# Proposal: Implement Hybrid Audio/Video Playback

**Goal:** Implement a hybrid playback system. When playing a local file, the app will display video if in the foreground, but seamlessly continue playing audio-only when sent to the background.

**Current Behavior:** The app currently operates in a pure audio-only mode. All playback (local and remote) is handled by `audio_service` and does not display any video content.

**Proposed Behavior:** A new `VideoPlayerScreen` will be created to display the visual component of local `.mp4` files. This screen will be synchronized with `MyAudioHandler`, which will manage the audio component of the file. When the app is backgrounded, the `VideoPlayerScreen` will be dismissed, but the audio will continue to play uninterrupted via `audio_service`. This provides the best of both worlds: a rich foreground experience and a robust background experience.
