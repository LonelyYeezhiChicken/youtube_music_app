# macos-icon Specification

## Purpose
TBD - created by archiving change update-app-icon. Update Purpose after archive.
## Requirements
### Requirement: macOS App Icon Display
The macOS desktop application SHALL display the `logo.png` as its app icon.

#### Scenario: App icon in Dock and Applications folder
- **GIVEN** the application is installed on a macOS desktop.
- **WHEN** the user views the Dock, Applications folder, or Launchpad.
- **THEN** the application icon SHALL be the `logo.png` in `.icns` format or as a set of PNGs in an asset catalog.

