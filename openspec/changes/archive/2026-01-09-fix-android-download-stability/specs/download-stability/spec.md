## ADDED Requirements

### Requirement: Robust Android Download Stability
The application SHALL ensure that audio downloads on Android are robust and resilient to backgrounding and network interruptions.

#### Scenario: Download continues in background
- **GIVEN** a user initiates an audio download on Android.
- **WHEN** the user switches the application to the background during an active download.
- **THEN** the download SHALL continue uninterrupted in the background.
- **AND** the user SHALL be notified of the download's progress via a persistent notification.

#### Scenario: Download resumes after interruption
- **GIVEN** an active audio download on Android.
- **WHEN** the network connection is temporarily lost or interrupted.
- **THEN** the download SHALL attempt to automatically resume from the point of interruption once the network connection is restored.
- **AND** the downloaded file SHALL be complete and playable upon successful resumption.

#### Scenario: User feedback on download status
- **GIVEN** an active audio download on Android.
- **WHEN** the download progresses, pauses, or encounters an error.
- **THEN** the application SHALL provide clear and timely feedback to the user about the download status.
