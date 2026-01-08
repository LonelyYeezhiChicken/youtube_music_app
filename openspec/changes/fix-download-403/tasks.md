## Tasks for fix-download-403

**## ADDED Tasks**
- [ ] 1. Modify `DownloadService` to include a `User-Agent` header in HTTP requests for audio streams.
- [ ] 2. Update the implementation of `downloadAudio` to explicitly set a standard browser User-Agent string in the `http.Request` headers.
- [ ] 3. Run `flutter build windows` (or the target platform) to create a new application build.
- [ ] 4. Test the download functionality in the new build to verify that audio files are downloaded successfully and are playable.
- [ ] 5. Verify that no "403 Forbidden" errors occur during the download process by observing the debug logs.
