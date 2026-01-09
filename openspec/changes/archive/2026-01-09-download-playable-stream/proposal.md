# Proposal: Download Playable Stream

**Goal:** Modify the `DownloadService` to fetch a muxed (video + audio) stream that is guaranteed to be playable by standard players without requiring post-processing.

**Current Behavior:** The `DownloadService` fetches the highest bitrate audio-only stream. This can lead to "403 Forbidden" errors and may result in a container format that is not universally playable.

**Proposed Behavior:** The `DownloadService` will be updated to prioritize fetching a muxed stream (containing both video and audio). This increases the likelihood of getting a standard, playable `.mp4` file, simplifies the process for the user, and may resolve the 403 error. The downloaded file will be saved with a `.mp4` extension.
