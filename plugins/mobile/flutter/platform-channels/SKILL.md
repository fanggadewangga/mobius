---
name: flutter-platform-channels
trigger: "native", "platform channel", "method channel", "battery", "sensor"
---

# Flutter Platform Channels

When communication with native code is required:

1. **MethodChannel**: Use for simple method calls (one-way or request-response).
2. **EventChannel**: Use for continuous data streams from native to Flutter.
3. **Type Safety**: Use `Pigeon` if the interface is complex and requires type safety across platforms.
4. **Error Handling**: Always catch `PlatformException` in Flutter.
5. **Threading**:
   - Flutter calls are on the main thread on both sides.
   - Use Background Channels if the native operation is heavy.

"Keep the bridge thin. Move as much logic as possible to the Dart side."
