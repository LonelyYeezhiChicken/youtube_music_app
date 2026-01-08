# Proposal: Implement Video Player with Controls

**Goal:** Replace the existing audio-only player with a video-capable player to handle `.mp4` files. This new player will include essential playback controls, specifically "play/pause," "previous," and "next" track navigation.

**Current Behavior:** The app uses the `audioplayers` package, which cannot render the video from downloaded `.mp4` files. The existing playback controls lack a "previous/next" track feature for navigating between downloaded items.

**Proposed Behavior:** The app will be enhanced with the `video_player` package. When a user selects a downloaded track, a new player screen will appear, displaying the video. This screen will feature a user interface with "play/pause," "next," and "previous" buttons. These controls will allow the user to seamlessly navigate through their library of downloaded tracks.
