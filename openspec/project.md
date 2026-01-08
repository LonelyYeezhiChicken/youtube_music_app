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

---

## Current Status & Known Issues (As of 2026-01-08)

### Codebase State
The `main` branch is currently based on the stable `v1.0.0-audio-only` tag. This version provides a unified, background-capable audio player using `audio_service`. All video-related playback features have been removed to ensure stability.

### Known Issue: Unstable Downloads
- **Problem:** The download functionality has become unreliable, frequently failing with a `ClientException: Connection closed while receiving data` error.
- **History:** This was previously fixed by switching the download stream type to `muxed`. However, this method has also become unstable, presumably due to changes on YouTube's end.
- **Current Action (Experimental):** As of the latest commit, the `download_service` has been modified to use `audioOnly.withHighestBitrate()` as suggested. This is an experimental attempt to find a more stable download source.

### Playback State
- Playback is handled exclusively by `audio_service` for a pure **audio-only** experience.
- It can play both remote streams (from search) and local files (from the library).
- Background playback is fully functional.

### Next Steps
- The immediate next step is to **validate if the new `audioOnly` download method is reliable**.
- If download issues persist, further investigation into `youtube_explode_dart` or alternative stream-fetching methods will be required.
