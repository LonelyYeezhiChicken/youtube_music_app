# Design Document for fix-download-403

## Context
The application's audio download feature is currently failing with an HTTP 403 Forbidden error. This error occurs because YouTube's servers are rejecting the direct stream download requests. A common reason for such rejections is the absence or inadequacy of the `User-Agent` header in the HTTP request, which can make the request appear non-browser-like or suspicious.

## Proposed Solution
The solution is to explicitly set a `User-Agent` header in the `http.Request` used for downloading audio streams. By mimicking a common web browser's User-Agent, the request is more likely to be accepted by YouTube's servers.

## Detailed Design

### Modification to `DownloadService`
The `DownloadService` is responsible for fetching and saving audio streams. The modification will occur within the `downloadAudio` method.

1.  **Identify the Request:** The `http.Request` object is created with the `audioStreamInfo.url`.
2.  **Add `User-Agent` Header:** Before sending the request using `client.send(request)`, a `User-Agent` header will be added to the request's headers.

    ```dart
    final request = http.Request('GET', audioStreamInfo.url);
    request.headers['User-Agent'] = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'; // Example User-Agent
    final response = await client.send(request);
    ```

### User-Agent String Selection
A generic, widely accepted browser User-Agent string will be chosen. It should represent a modern browser on a common operating system to maximize compatibility. The example above is a good candidate.

## Alternatives Considered

### Using `youtube_explode_dart`'s `download` method
Initially, it was considered to use `_yt.videos.streamsClient.download(audioStreamInfo, file.openWrite())`. While this method would handle the headers internally, it does not provide a direct way to track download progress with a custom callback, which is a required feature of our `downloadAudio` method. Manually implementing progress tracking with `streamsClient.get(streamInfo)` and then piping would essentially lead back to the custom HTTP client approach. Therefore, explicit header manipulation with the `http` package is preferred for finer control over progress reporting.

## Open Questions / Future Considerations
-   YouTube's policies are subject to change. A more robust solution might involve regularly updating the User-Agent string or dynamically fetching a valid User-Agent if the 403 issue re-emerges.
-   The current solution assumes that the User-Agent header is the *sole* reason for the 403 error. If other HTTP request properties (e.g., `Referer`, `Origin`) are also being checked, further investigation and modification may be required.
