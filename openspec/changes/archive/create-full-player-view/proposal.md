# Proposal: Create Full-Screen Player View

**Goal:** Implement a full-screen player view that is accessible by tapping the `MiniPlayer`. This new screen will display detailed information about the currently playing track, full playback controls, and a view of the current playback queue (i.e., the "playlist").

**Current Behavior:** The `MiniPlayer` widget provides basic playback controls but does not offer a way to view the current playlist or access a more detailed player interface. Tapping the `MiniPlayer` has no effect.

**Proposed Behavior:** Tapping the `MiniPlayer` will navigate the user to a new, full-screen `PlayerScreen`. This screen will feature:
- Prominent display of the current track's artwork, title, and artist.
- A full seek bar for scrubbing through the track.
- Complete playback controls (play/pause, next, previous).
- A scrollable list displaying all `MediaItem`s in the current `audio_service` queue.
The entire screen will be driven by data streams from `audio_service`, ensuring the UI is always in sync with the audio state.
