# Tasks for `fix-android-download-stability`

- [ ] 1. **Initial Investigation and Setup:**
    - [ ] 1.1. Review existing `download_service.dart` logic for potential Android-specific issues.
    - [ ] 1.2. Explore Flutter packages for robust background download management (e.g., `flutter_downloader`, or deeper integration with `audio_service`).

- [ ] 2. **Implement Foreground Service for Downloads:**
    - [ ] 2.1. Determine the best approach:
        - Option A: Integrate download task within the existing `audio_service` Foreground Service.
        - Option B: Implement a separate Foreground Service specifically for downloads.
    - [ ] 2.2. Update `android/app/src/main/AndroidManifest.xml` with necessary service declarations and permissions (e.g., `FOREGROUND_SERVICE_DATA_SYNC`).
    - [ ] 2.3. Modify `download_service.dart` to start/stop the Foreground Service (or leverage `audio_service`) before/after download tasks.

- [ ] 3. **Implement Download Resumption/Retry Logic:**
    - [ ] 3.1. Modify `download_service.dart` to store partial download progress/state.
    - [ ] 3.2. Add logic to retry failed downloads from the last known good byte range.

- [ ] 4. **Optimize Stream URL Handling (if needed):**
    - [ ] 4.1. Research `youtube_explode_dart` API for methods to refresh stream URLs during long downloads.
    - [ ] 4.2. Implement a mechanism to re-fetch or validate stream URLs if the download encounters an error related to URL expiration.

- [ ] 5. **Validation:**
    - [ ] 5.1. On Android, initiate a long download.
    - [ ] 5.2. Background the app during the download and verify that the download continues (check notification for Foreground Service).
    - [ ] 5.3. Test download stability under poor network conditions (e.g., by throttling network) and verify retry mechanism.
    - [ ] 5.4. Verify that downloaded files are complete and playable.
