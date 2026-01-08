# Tasks for `redefine-playback-as-playlist`

- [ ] 1. **Refactor `MyAudioHandler`:**
    - [ ] 1.1. Create a new method `playTrackList(List<Track> tracks, int initialIndex)` that takes a list of tracks and the index of the track to start playing.
    - [ ] 1.2. This method will convert the `List<Track>` to a `List<MediaItem>` and set it as the current queue using `updateQueue()`.
    - [ ] 1.3. It will then call `skipToQueueItem(initialIndex)` to start playback.
    - [ ] 1.4. Deprecate `playRemoteTrack` and `playLocalTrack` in favor of `playTrackList`.

- [ ] 2. **Refactor `LibraryScreen`:**
    - [ ] 2.1. In `lib/screens/library_screen.dart`, modify the "play" button's `onPressed` callback to call `(audioHandler as MyAudioHandler).playTrackList(_tracks, index)`.
    - [ ] 2.2. Remove the "Add to Queue" button, as it is now redundant.

- [ ] 3. **Refactor `SearchScreen` (or relevant search implementation):**
    - [ ] 3.1. In the search results view, modify the "play" button's `onPressed` callback to call `(audioHandler as MyAudioHandler).playTrackList(searchResults, index)`.

- [ ] 4. **Validation:**
    - [ ] 4.1. Play a track from the library and verify that "next" and "previous" buttons cycle through the library tracks.
    - [ ] 4.2. Play a track from search results and verify that "next" and "previous" buttons cycle through the search result tracks.
    - [ ] 4.3. Verify that the queue in `PlayerScreen` is automatically populated with the correct list of tracks.
    - [ ] 4.4. Verify that background playback and lock screen controls for "next" and "previous" work as expected.
