# Proposal: Fix Android Download Stability Issue

## Problem
Users experience frequent download failures on Android, especially for longer downloads. This issue significantly hinders the core functionality of the application, which relies on successful content download for offline playback. While the current download logic works on other platforms and for shorter downloads on Android, it lacks the robustness required for consistent performance on Android devices, particularly when the application might be backgrounded or network conditions are unstable.

## Hypothesis
The download failures on Android are likely due to one or a combination of the following factors:
1.  **Android OS restrictions:** The Android operating system might be aggressively terminating background tasks (like ongoing downloads) to conserve resources.
2.  **Network instability:** The `http` client's connection might be timing out or getting interrupted more frequently on mobile networks or under unstable Wi-Fi conditions.
3.  **Stream URL validity:** Although less likely after previous fixes, the stream URLs provided by `youtube_explode_dart` might still have a limited lifespan, leading to failures if the download takes too long.

## Proposed Solution
The solution will involve enhancing the download mechanism to be more resilient and robust on Android:

1.  **Utilize Foreground Service for Downloads:** Integrate the download logic with a dedicated Android Foreground Service. This will elevate the download task's priority, making it less susceptible to being terminated by the OS when the app is in the background. Since `audio_service` already runs as a Foreground Service, leveraging it or integrating a download-specific Foreground Service will be explored.
2.  **Implement Download Resumption/Retry Logic:** Introduce a mechanism to automatically retry failed download chunks or resume interrupted downloads from the last known good point. This will improve resilience against network interruptions.
3.  **Optimize Stream URL Handling:** Investigate if stream URLs need to be refreshed during long downloads or if `youtube_explode_dart` offers more stable URL options.

## Impact
- **Positive:** Significantly improves the reliability of downloading audio content on Android, enhancing the core user experience.
- **Moderate Complexity:** Requires changes to `download_service.dart` and potentially `audio_handler.dart` (if integrating with `audio_service`) or Android-specific manifest/service declarations.
- **No UI Changes:** The user interface for initiating downloads will remain the same.

## Affected Components
- `lib/services/download_service.dart` (Core download logic)
- `lib/services/audio_handler.dart` (Potentially, for integrating download with `audio_service`)
- Android Manifest and service configuration.
