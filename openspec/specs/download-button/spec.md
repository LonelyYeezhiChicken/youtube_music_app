# download-button Specification

## Purpose
TBD - created by archiving change fix-apk-download-redirect. Update Purpose after archive.
## Requirements
### Requirement: Download Attribute for APK Link
The download link for the APK **SHALL** include the `download` attribute.

#### Scenario: User clicks APK download link
- **GIVEN** a user is viewing the GitHub Pages site
- **WHEN** the user clicks on the "Download for Android" link
- **THEN** the browser **MUST** be prompted to download the `app-release.apk` file
- **AND** the browser **MUST NOT** redirect to another browser application (e.g., Brave)

