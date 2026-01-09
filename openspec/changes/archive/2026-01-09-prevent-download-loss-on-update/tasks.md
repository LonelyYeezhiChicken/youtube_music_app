# Tasks for `prevent-download-loss-on-update`

- [ ] 1. **Investigate Current Storage Behavior:**
    - [ ] 1.1. Confirm the exact location where `getApplicationDocumentsDirectory()` resolves to on Android and Windows, both before and after an application update (simulated by re-installing a new build).
    - [ ] 1.2. Document whether files in this location are indeed wiped upon update/reinstall.

- [ ] 2. **Identify Persistent Storage Solution:**
    - [ ] 2.1. Research suitable persistent storage locations for downloaded media on Android and Windows that survive application updates/reinstalls. (e.g., `getExternalStorageDirectory()` on Android, or a user-selected folder).
    - [ ] 2.2. Consider the implications for user privacy and permissions for the chosen location.

- [ ] 3. **Modify `DownloadService`:**
    - [ ] 3.1. Update `downloadAudio` method to save files to the identified persistent storage location.
    - [ ] 3.2. Handle potential changes in file access permissions for the new location.

- [ ] 4. **Implement Migration Strategy (if necessary):**
    - [ ] 4.1. If the storage location changes, implement a one-time migration logic to move existing downloaded files from the old location to the new persistent location during application startup.

- [ ] 5. **Update `DatabaseService`:**
    - [ ] 5.1. Ensure that the `filePath` stored in Hive correctly reflects the new persistent storage location.

- [ ] 6. **Validation:**
    - [ ] 6.1. Download several audio tracks.
    - [ ] 6.2. Perform an application update/reinstall (simulating a new build).
    - [ ] 6.3. Launch the updated application and verify that all previously downloaded tracks are still available and playable.
    - [ ] 6.4. Test on both Android and Windows.
