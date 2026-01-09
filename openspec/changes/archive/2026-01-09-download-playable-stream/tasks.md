# Tasks for `download-playable-stream`

- [x] 1. **Setup:** Create a new feature branch `feature/download-playable-stream` from the `main` branch.
- [x] 2. **Modify DownloadService:** In `lib/services/download_service.dart`, update the `downloadAudio` method.
- [x] 3. **Change Stream Selection:** Replace the stream selection logic from `streamManifest.audioOnly.withHighestBitrate()` to `streamManifest.muxed.withHighestVideoQuality()`.
- [x] 4. **Update File Naming:** Ensure the saved file path uses a `.mp4` extension instead of the audio container name.
- [x] 5. **Add User-Agent Header:** Add a standard browser User-Agent string to the headers of the `http.Request` to help prevent 403 errors.
- [x] 6. **Validation - Download:** Perform a test download to verify that a `.mp4` file is successfully created in local storage.
- [x] 7. **Validation - Playback:**
    - [x] 7.1 Verify that the downloaded `.mp4` file can be played by an external video player.
    - [x] 7.2 Verify if the in-app `audioplayers` instance can still play the audio track from the downloaded `.mp4` file. If not, document this limitation. (Limitation confirmed)
- [ ] 8. **Code Cleanup:** Remove any dead code or unnecessary logic related to the old download method.
- [ ] 9. **Pull Request:** Open a pull request to merge the changes into the `main` branch for review.
