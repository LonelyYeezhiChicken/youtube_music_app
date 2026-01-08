# Tasks for `create-download-website`

- [x] 1. **Create Directory:** Create a new directory named `docs` at the root of the project repository.

- [x] 2. **Create `index.html`:** Inside the `docs` directory, create a new file named `index.html`.

- [x] 3. **Add HTML Content:** Populate `index.html` with a clean, user-friendly layout. This will include:

    - A responsive meta tag.

    - A title for the page.

    - Simple inline CSS for styling the page and a download button.

    - A header with the app name "YT Music".

    - A "Download for Android" button. The button's link (`href`) will point to `https://github.com/LonelyYeezhiChicken/youtube_music_app/releases/latest/download/app-release.apk`.

- [x] 4. **Create Instructional README:** Inside the `docs` directory, create a `README.md` file that explains the manual steps the user needs to take after the code is pushed. This includes:
    - How to build the release APK (`flutter build apk`).
    - How to navigate to their project's GitHub Releases page and create a new release.
    - How to upload the `app-release.apk` from `build/app/outputs/flutter-apk/` as a release asset.
    - How to enable GitHub Pages in the repository settings to serve from the `/docs` folder of the `main` branch.

- [x] 5. **Commit and Push:** Add the new `docs` directory and its contents to Git, commit, and push to the `main` branch.

- [ ] 6. **Validation:** After the user enables GitHub Pages, the URL `https://lonelyyeezhichicken.github.io/youtube_music_app/` should display the new download page, and the download button should work correctly (once they have created a release and uploaded the APK).
