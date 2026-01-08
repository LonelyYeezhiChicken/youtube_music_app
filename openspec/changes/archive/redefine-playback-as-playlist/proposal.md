# Proposal: Redefine Playback as Playlist-Centric

This proposal redefines the music playback experience to be playlist-centric, ensuring that playing a track automatically creates a queue for "next" and "previous" functionality.

## Problem
The current implementation requires users to manually add tracks to a queue to enable "next" and "previous" playback. This is not intuitive for a music player, where users expect to be able to skip to the next or previous track in the current view (e.g., search results, library) without manual queuing.

## Proposed Solution
The proposed solution is to modify the `AudioHandler` to automatically create a queue based on the current context (e.g., the list of tracks in the library or the current search results). When a user plays a track from a list, the entire list will be treated as the current playlist.

This will enable the following:
- Seamless "next" and "previous" playback within the current context.
- The `PlayerScreen` will display the full queue without requiring manual "add to queue" actions.
- The player will feel more like a standard music player.
