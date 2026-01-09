# Design: Downloading Muxed Streams for Direct Playback

## 1. Problem
The current implementation in `DownloadService` fetches `audioOnly` streams from YouTube. This approach faces two primary issues:
1.  **403 Forbidden Errors:** Audio-only streams are sometimes protected and requests for them can be rejected with a "403 Forbidden" status, failing the download. This is a known issue when accessing YouTube's raw streams.
2.  **Playback Incompatibility:** The user's goal is to play the file directly after download. The current `audio_service` and `audioplayers` setup is designed for audio files. Downloading a video container might work, but it's not guaranteed, and the user's request implies they want a file that "just works," even if it means using an external player. Prioritizing a standard `.mp4` format is the most direct way to achieve this.

## 2. Proposed Solution
The solution is to change the stream selection logic within `DownloadService` to prioritize muxed streams (video + audio).

1.  **Stream Selection:** Instead of calling `streamManifest.audioOnly.withHighestBitrate()`, the code will call `streamManifest.muxed.withHighestVideoQuality()`. `youtube_explode_dart` returns these streams as `.mp4` containers, which are highly compatible.
2.  **File Extension:** The downloaded file will be saved with a `.mp4` extension to match its container type.
3.  **User-Agent:** To mitigate potential 403 errors, a standard browser `User-Agent` header will be added to the HTTP download request.

## 3. Trade-offs
*   **Pro:**
    *   **High Compatibility:** The downloaded `.mp4` file will be directly playable on almost any device and media player.
    *   **Error Reduction:** Muxed streams are less prone to the "403 Forbidden" errors that affect audio-only streams.
    *   **Simplicity:** No conversion or stream-merging is required.

*   **Con:**
    *   **Larger File Size:** The downloaded files will be significantly larger because they contain video data. The user has explicitly accepted this trade-off ("影片也沒關係" / "video is also okay").
    *   **In-App Playback:** The current player is built for audio. While `audioplayers` might play audio from an mp4, this needs verification. The primary goal is a playable file, which is met regardless of in-app playback capability.
