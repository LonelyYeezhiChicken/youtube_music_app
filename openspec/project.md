# Project Context

## Purpose
The goal is to build a cross-platform application (initially for iOS, with future support for Android and Desktop) that allows users to download audio from YouTube videos for offline and background playback.

## Tech Stack
- **Main Framework:** Flutter
- **Main Language:** Dart
- **Key Packages:**
    - `youtube_explode_dart` (For parsing YouTube information)
    - `audioplayers` (For background and offline audio playback)
    - `path_provider` / `hive` (For file path management and local data storage)

## Project Conventions

### Code Style
[To be defined. Standard Dart/Flutter conventions will be followed.]

### Architecture Patterns
[To be defined. A clean architecture like BLoC or Riverpod is recommended.]

### Testing Strategy
[To be defined. Flutter's standard testing framework will be used for unit, widget, and integration tests.]

### Git Workflow
[Please describe your branching strategy (e.g., GitFlow, trunk-based) and any conventions for commit messages.]

## Domain Context
- **Track:** Represents a single audio file downloaded from a YouTube video.
- **Playlist:** A user-curated collection of tracks.
- **Offline Playback:** The ability to play downloaded tracks without an internet connection.
- **Background Playback:** The ability for audio to continue playing when the app is not in the foreground or the screen is locked.

## Important Constraints
- **Compliance:** Development and usage must adhere to YouTube's Terms of Service.
- **Platform Integration:** The app must correctly handle platform-specific features like background audio and file system access.

## External Dependencies
- **YouTube:** The primary external service for fetching video data.
- **Pub.dev:** The package repository for Flutter/Dart dependencies.
