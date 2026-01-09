# Proposal: Add Version Display to Application

## Problem
The application currently lacks a visible indication of its version number within the user interface. This can make it difficult for users and developers to identify the exact version of the installed application, which is crucial for bug reporting, support, and tracking feature deployments.

## Proposed Solution
A clear and accessible display of the application's version number will be added to a suitable "small corner" of the application. This will likely be within an existing screen, such as the Library screen or an "About" section if one is introduced, ensuring it's visible without cluttering the main UI.

## Impact
- **Positive:** Improves user and developer experience by providing easy access to version information.
- **Minimal Complexity:** Involves minor UI modification and reading version information from `pubspec.yaml` (via a package like `package_info_plus`).
- **No Core Logic Changes:** Does not affect core download or playback functionalities.

## Affected Components
- `lib/main.dart` or `lib/screens/library_screen.dart` (UI integration)
- `pubspec.yaml` (Adding `package_info_plus` dependency if needed)
