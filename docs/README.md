# Manual Steps for Website Deployment

This `index.html` file is ready to be deployed using GitHub Pages. Please follow these manual steps to build your app, create a release, and enable the website.

### Step 1: Build the Release APK

First, you need to build the Android APK file that users will download. Run this command from the `youtube_music_app` directory:

```sh
flutter build apk
```

This will create the APK file at: `youtube_music_app/build/app/outputs/flutter-apk/app-release.apk`.

### Step 2: Create a New GitHub Release

1.  Navigate to your GitHub repository in your browser: `https://github.com/LonelyYeezhiChicken/youtube_music_app`.
2.  On the right-hand side, click on **"Releases"**.
3.  Click **"Create a new release"** or "Draft a new release".
4.  Choose a tag version (e.g., `v1.0.0`). It's a good practice to create a new tag for each release.
5.  In the "Release title", you can put the same tag (e.g., `v1.0.0`).
6.  In the section **"Attach binaries by dropping them here or selecting them"**, upload the `app-release.apk` file you built in Step 1.
7.  Click **"Publish release"**.

By doing this, the download link `https://github.com/LonelyYeezhiChicken/youtube_music_app/releases/latest/download/app-release.apk` in `index.html` will automatically point to the APK you just uploaded.

### Step 3: Enable GitHub Pages

1.  In your GitHub repository, go to the **"Settings"** tab.
2.  In the left sidebar, click on **"Pages"**.
3.  Under "Build and deployment", for the "Source", select **"Deploy from a branch"**.
4.  For the "Branch", select `main` and `/docs` as the folder.
5.  Click **"Save"**.

After a few minutes, your website will be live at: **`https://lonelyyeezhichicken.github.io/youtube_music_app/`**
