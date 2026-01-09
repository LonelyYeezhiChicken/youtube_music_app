# Tasks for `add-version-display`

- [ ] 1. **Add Dependency:**
    - [ ] 1.1. Add `package_info_plus` to `pubspec.yaml` and run `flutter pub get`.

- [ ] 2. **Implement Version Retrieval:**
    - [ ] 2.1. Create a utility function or integrate directly into the chosen screen to asynchronously fetch the application version string using `PackageInfo.fromPlatform()`.

- [ ] 3. **Integrate into UI:**
    - [ ] 3.1. Choose a suitable "small corner" in the application (e.g., the bottom of the `LibraryScreen` or a dedicated "About" page if implemented later).
    - [ ] 3.2. Display the fetched version number prominently.

- [ ] 4. **Validation:**
    - [ ] 4.1. Run the application on all supported platforms (Windows, Android).
    - [ ] 4.2. Verify that the correct version number (e.g., "1.0.0+1") is displayed in the chosen location.
    - [ ] 4.3. Verify that the UI element is clean and does not interfere with other functionalities.
