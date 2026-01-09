# Tasks for `update-app-icon`

## Phase 1: Setup and Basic Generation (Android, iOS, Web)
- [x] 1. **Add `flutter_launcher_icons` dependency:**
    - [x] 1.1. Add `flutter_launcher_icons` to `dev_dependencies` in `youtube_music_app/pubspec.yaml`.
    - [x] 1.2. Run `flutter pub get` in `youtube_music_app` directory.
- [x] 2. **Configure `flutter_launcher_icons`:**
    - [x] 2.1. Add a `flutter_launcher_icons` section to `youtube_music_app/pubspec.yaml`.
    - [x] 2.2. Specify `image_path: ../../logo.png` (relative path from `youtube_music_app/` to `DManager/logo.png`).
    - [x] 2.3. Enable desired platforms (`android: true`, `ios: true`, `web: true`).
    - [x] 2.4. (Android only) If adaptive icons are desired, configure `adaptive_icon_background` and `adaptive_icon_foreground` (e.g., specify a color code or an image path for foreground/background). For this proposal, we will assume the logo.png will be the foreground and the background will be transparent or a default color if not specified by the user.
- [x] 3. **Generate icons for Android, iOS, Web:**
    - [x] 3.1. Run `flutter pub run flutter_launcher_icons:main -f pubspec.yaml` in `youtube_music_app` directory.
    - [x] 3.2. Verify generated icons in `youtube_music_app/android/app/src/main/res/mipmap-*` and `youtube_music_app/ios/Runner/Assets.xcassets` and `youtube_music_app/web/icons`.

## Phase 2: Desktop Platform Icons (Manual or Alternative Tooling)
- [x] 4. **Windows Icon:**
    - [x] 4.1. Convert `logo.png` to `.ico` format (e.g., using an online converter or image editor).
    - [x] 4.2. Replace `youtube_music_app/windows/runner/resources/app_icon.ico` with the new `.ico` file.
- [x] 5. **macOS Icon:**
    - [x] 5.1. Convert `logo.png` to `.icns` format (e.g., using an online converter or image editor on macOS).
    - [x] 5.2. Update `youtube_music_app/macos/Runner/Assets.xcassets/AppIcon.appiconset/` with the new `.icns` file or individual PNGs of required sizes. (Requires a Mac to generate `.icns` directly, or pre-generated assets). For this proposal, we will assume generating the necessary PNGs and placing them in the `AppIcon.appiconset` is sufficient.
- [x] 6. **Linux Icon:** (Cancelled by user)
    - [x] 6.1. Generate various sizes of PNGs (e.g., 256x256, 128x128, 64x64).
    - [x] 6.2. Copy the generated PNGs to appropriate directories (e.g., `youtube_music_app/linux/icons/hicolor/`).
    - [x] 6.3. Update the `.desktop` file (`youtube_music_app/linux/app.flt.desktop` or similar) to point to the new icon.

## Phase 3: Validation
- [x] 7. **Build and Test:**
    - [x] 7.1. Run `flutter build apk` and `flutter build ios` (if on macOS), `flutter build web`, `flutter build windows`, `flutter build linux`, `flutter build macos`. (Built for Android, Web, Windows. iOS/macOS/Linux skipped as per user instructions or environment.)
    - [ ] 7.2. Install and launch the application on each platform to visually confirm the new icon is displayed correctly in app launchers, taskbars, and about screens. (Manual verification required)