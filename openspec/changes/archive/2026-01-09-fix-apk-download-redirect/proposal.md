# Proposal: Fix APK Download Redirect

## Why
When a user clicks the "Download for Android" button on the GitHub Pages site, it redirects to the Brave browser instead of downloading the APK file. This is likely due to a client-side file association on the user's machine.

## What Changes
To provide a better user experience and hint to the browser that the link is for a download, this proposal suggests adding the `download` attribute to the anchor (`<a>`) tag for the APK download link in `docs/index.html`.

## High-Level Plan
1.  Modify `docs/index.html` to include the `download` attribute in the download link.
