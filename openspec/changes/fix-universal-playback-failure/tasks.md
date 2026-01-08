# Tasks for `fix-universal-playback-failure`

- [ ] 1. **Add detailed logging to `audio_handler.dart`:**
    - [ ] 1.1. In `playMediaItem`, just before calling `_player.setSourceDeviceFile(mediaItem.id)`, print the value of `mediaItem.id` and a label indicating it's a local file path.
    - [ ] 1.2. In `playMediaItem`, just before calling `_player.setSourceUrl(streamInfo.url.toString())`, print the value of `streamInfo.url.toString()` and a label indicating it's a remote stream URL.
    - [ ] 1.3. Ensure the existing `try-catch` block for `playMediaItem` still prints the full exception and stack trace (`print("Error playing media: $e"); print("Stack trace: $s");`).

- [ ] 2. **Request user to run and collect logs:** Ask the user to run the application on both Windows and Android, attempt to play both local and remote tracks, and provide the complete debug console output.

- [ ] 3. **Analyze collected logs:** Based on the logs, identify whether the `mediaItem.id` (for local files) or `streamInfo.url.toString()` (for remote streams) are valid and accessible.
    - [ ] 3.1. If remote URLs are invalid/expired, investigate re-fetching or refreshing stream manifests.
    - [ ] 3.2. If local file paths are incorrect or files are corrupted, investigate `download_service.dart`.

- [ ] 4. **Implement fix based on analysis.** (This task will be detailed further after log analysis).
