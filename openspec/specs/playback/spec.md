## MODIFIED Requirements

### Requirement: Playlist-centric Playback

Playback SHALL be centered around a playlist, which is automatically generated from the user's current context (e.g., library, search results).

#### Scenario: Play from Library
- **Given** I am on the Library screen with a list of downloaded tracks.
- **When** I tap the "play" button on a track.
- **Then** playback starts for that track.
- **And** the current playlist is set to the complete list of tracks in the library.
- **And** pressing "next" plays the next track in the library list.
- **And** pressing "previous" plays the previous track in the library list.

#### Scenario: Play from Search
- **Given** I am on the Search screen with a list of search results.
- **When** I tap the "play"button on a track.
- **Then** playback starts for that track.
- **And** the current playlist is set to the complete list of tracks from the search results.
- **And** pressing "next" plays the next track in the search results.
- **And** pressing "previous" plays the previous track in the search results.