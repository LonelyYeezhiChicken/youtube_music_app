# Design: Video Player with Track Controls

## 1. Problem
The application currently faces two limitations:
1.  **Playback Incompatibility:** The `audioplayers` package is unsuitable for playing the `.mp4` files now being downloaded, as it cannot render video.
2.  **Missing Navigation:** The player lacks "previous" and "next" controls, preventing users from easily navigating between tracks in their downloaded library.

## 2. Proposed Solution
The solution involves integrating the `video_player` package and building a new player interface with full navigation controls.

### 2.1. Core Component: `video_player`
- We will add the `video_player` package to `pubspec.yaml`. This package provides the necessary widgets (`VideoPlayer`) and controllers (`VideoPlayerController`) for rendering video content.

### 2.2. New Player UI: `VideoPlayerScreen`
- A new stateful widget, `VideoPlayerScreen`, will be created. This screen will be presented modally or pushed onto the navigation stack when a user taps a downloaded track.
- The screen will contain the `VideoPlayer` widget to display the video and a custom control overlay with buttons for "Previous," "Play/Pause," and "Next."

### 2.3. State Management for Navigation
- When navigating to `VideoPlayerScreen`, the entire list of downloaded track file paths and the index of the selected track will be passed as arguments.
- The screen's state will manage the `currentIndex`.
- **"Next" button:** Increments `currentIndex`, disposes the current `VideoPlayerController`, and initializes a new one with the file path at the new index. If it reaches the end of the list, it will loop back to index `0`.
- **"Previous" button:** Decrements `currentIndex`, performs the same controller lifecycle management, and loops to the end of the list if at index `0`.
- **Controller Lifecycle:** It is critical to properly `initialize()` the new controller and `dispose()` the old one whenever the track changes to free up resources.

## 3. Trade-offs & Considerations
*   **Pro:**
    *   Provides full in-app playback functionality for downloaded files, creating a seamless user experience.
    *   Implements the highly requested "previous/next" navigation feature.

*   **Con:**
    *   **Background Playback:** The `video_player` package does not support background audio playback out of the box. If a user sends the app to the background, playback will stop. This is a regression from `audioplayers` and may need to be addressed in a future enhancement (e.g., by integrating with `audio_service` in a more complex way). For this iteration, we will prioritize foreground video playback.
    *   **UI Complexity:** A new UI screen must be designed and built, which adds to the implementation effort.
