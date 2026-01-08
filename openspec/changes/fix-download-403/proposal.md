# Proposal: Fix Downloaded Files Unplayable Issue

## Change ID
`fix-download-403`

## Overview
The current implementation of the audio download functionality from YouTube videos results in corrupted or unplayable files. Debugging has revealed that the underlying issue is an "HTTP 403 Forbidden" status code received when attempting to download the audio stream directly from the `youtube_explode_dart` provided URLs using the `http` package. This typically occurs because YouTube's servers impose restrictions on direct access to stream URLs, often checking for a valid `User-Agent` header.

This proposal outlines a solution to address this 403 error by modifying the HTTP request to include a standard browser `User-Agent` header, thereby allowing the download to proceed successfully and yield playable audio files.

## Motivation
Users are currently unable to play downloaded audio files, rendering a core feature of the application dysfunctional. Resolving this issue is critical for the application's usability and fulfilling its primary purpose of enabling offline and background playback of YouTube audio.

## Impact
- **Positive:** Users will be able to download and play audio files successfully.
- **Minimal:** No significant changes to the overall application architecture or user interface are anticipated beyond the fix to the download service.
- **Risk:** There's a minor risk that YouTube's policies or URL generation methods might change in the future, requiring further adjustments. However, setting a standard `User-Agent` is a common and robust approach for such scenarios.

## Affected Components
- `lib/services/download_service.dart` (Modification to HTTP request headers)
- `pubspec.yaml` (No direct changes, but `http` package behavior is modified)

## Testing Strategy
- Manual testing of download and playback functionality on affected platforms (e.g., Windows).
- Verification through debug logs that 403 errors are no longer occurring during download.
- Automated testing (unit/integration tests) for the `DownloadService` would ideally be updated or created to cover this scenario, but will be addressed in a separate task.
