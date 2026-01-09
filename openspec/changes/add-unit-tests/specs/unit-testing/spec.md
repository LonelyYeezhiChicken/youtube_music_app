## ADDED Requirements

### Requirement: Unit Test Coverage for Core Services
The application SHALL have comprehensive unit tests for its core service layers (`youtube_service.dart`, `database_service.dart`, `download_service.dart`, `audio_handler.dart`) to ensure correctness and prevent regressions.

#### Scenario: `youtube_service` searches videos
- **GIVEN** `youtube_service` is properly initialized.
- **WHEN** `searchVideos` is called with a valid query.
- **THEN** it SHALL return a list of `Video` objects.

#### Scenario: `database_service` manages tracks
- **GIVEN** `database_service` is initialized.
- **WHEN** `addTrack`, `getTracks`, `deleteTrack` are called.
- **THEN** tracks SHALL be added, retrieved, and deleted correctly.

#### Scenario: `download_service` downloads audio
- **GIVEN** `download_service` is initialized with valid dependencies.
- **WHEN** `downloadAudio` is called with a valid `Video` object.
- **THEN** it SHALL successfully download the audio and return the file path.

#### Scenario: `audio_handler` manages playback
- **GIVEN** `audio_handler` is initialized.
- **WHEN** `playRemoteTrack` or `playLocalTrack` are called.
- **THEN** audio playback SHALL start correctly.
- **AND** playback controls (play/pause/stop) SHALL function as expected.
