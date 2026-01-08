# YouTube Music App (學術專用)

---

> [!WARNING]
> **僅供學術研究用途 (For Academic Use Only)**
> 
> 本專案僅作為 Flutter 應用程式開發、API 整合與本地儲存技術的學術研究與概念驗證。
> 嚴禁任何形式的商業用途或公開散佈。所有下載的內容版權歸原創者所有，使用者應遵守 YouTube 的服務條款。
> 
> This project is intended for academic research and as a proof-of-concept for Flutter application development, API integration, and local storage techniques only.
> Any form of commercial use or public distribution is strictly prohibited. The copyright of all downloaded content belongs to the original creators. Users must comply with YouTube's Terms of Service.

---

## 關於專案 (About The Project)

這是一個使用 Flutter 開發的 YouTube 音樂播放器，可以搜尋、下載並離線播放 YouTube 上的內容。

This is a YouTube music player built with Flutter, allowing users to search, download, and play content from YouTube offline.

### 主要功能 (Features)

- **搜尋 (Search):** 透過 YouTube API 搜尋影片。
- **下載 (Download):** 將影片以下載至本機，並以 `.mp4` 格式儲存。
- **離線播放 (Offline Playback):** 播放已下載的 `.mp4` 檔案。
- **播放控制 (Playback Controls):** 支援播放、暫停、前一首、下一首功能。

## 開始使用 (Getting Started)

### 需求 (Prerequisites)

- Flutter SDK
- Android SDK (若要建置 Android 應用)

### 安裝與執行 (Installation & Running)

1. **Clone 專案 (Clone the repo)**
   ```sh
   git clone https://github.com/LonelyYeezhiChicken/youtube_music_app.git
   ```
2. **進入專案目錄 (Navigate to the project directory)**
   ```sh
   cd DManager/youtube_music_app
   ```
3. **取得依賴套件 (Get dependencies)**
   ```sh
   flutter pub get
   ```
4. **執行應用 (Run the app)**
   ```sh
   flutter run
   ```

## 建置 APK (Building for Android)

若要建置 Android APK，請在 `youtube_music_app` 目錄下執行以下指令：

To build the Android APK, run the following command in the `youtube_music_app` directory:

```sh
flutter build apk
```

產生的 APK 檔案會位於 `build/app/outputs/flutter-apk/app-release.apk`。

The resulting APK file will be located at `build/app/outputs/flutter-apk/app-release.apk`.