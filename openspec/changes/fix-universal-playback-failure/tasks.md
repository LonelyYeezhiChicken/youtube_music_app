# Tasks for `fix-universal-playback-failure`

- [ ] 1. **Confirm download and playback functionality is working as expected (as per "前一版").**
    - [ ] 1.1. On Windows, download a track and verify it plays correctly.
    - [ ] 1.2. On Android, download a track and verify it plays correctly.
    - [ ] 1.3. On both platforms, verify `audioplayers` can play downloaded `.mp4` files.

- [ ] 2. **Address Android download stability issue.**
    - [ ] 2.1. Investigate `youtube_explode_dart` for more robust download methods or stream URL handling.
    - [ ] 2.2. Implement a download retry mechanism in `download_service.dart`.
    - [ ] 2.3. Ensure download tasks are handled in a way that is resilient to app backgrounding on Android (potentially integrating with `audio_service`'s foreground capabilities).
