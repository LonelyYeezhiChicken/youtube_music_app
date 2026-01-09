## ADDED Requirements

### Requirement: Application Version Display
The application SHALL display its current version number in a visible and accessible location within the user interface.

#### Scenario: Version visible on Library screen
- **GIVEN** the application is running.
- **WHEN** the user navigates to the Library screen.
- **THEN** the application's full version string (e.g., "1.0.0+1") SHALL be visible in a designated "small corner" of the screen.

#### Scenario: Version updates with new releases
- **GIVEN** a new version of the application is released and installed.
- **WHEN** the user launches the updated application.
- **THEN** the displayed version number SHALL reflect the newly installed version.
