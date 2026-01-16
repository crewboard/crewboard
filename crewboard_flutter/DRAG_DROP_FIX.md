# Drag & Drop Fix for Chat Screen

## Issue
Files show a disabled/prohibited cursor when trying to drag them into the chat screen on Windows.

## Solution Applied

### 1. Added `enable: true` to DropTarget
The `DropTarget` widget now explicitly enables drag-and-drop:

```dart
DropTarget(
  enable: true,  // ← Added this
  onDragEntered: (details) { ... },
  onDragExited: (details) { ... },
  onDragDone: (details) { ... },
  child: ...
)
```

### 2. Steps to Test

1. **Stop the app completely** (don't just hot reload)
2. **Rebuild and restart** the application:
   ```bash
   flutter clean
   flutter pub get
   flutter run -d windows
   ```

3. **Test drag-and-drop**:
   - Open a chat room
   - Try dragging an image/video/audio file from File Explorer
   - You should see a blue overlay with "Drop files here"
   - Release to attach the file

### 3. Supported File Types

The chat accepts:
- **Images**: jpg, jpeg, png, gif, webp, bmp
- **Videos**: mp4, mov, avi, mkv, webm
- **Audio**: mp3, wav, m4a, flac, aac, ogg

### 4. Alternative: Manual File Selection

If drag-and-drop still doesn't work, users can click the attachment icon (📎) in the message input to manually select files.

## Troubleshooting

### If drag-and-drop still shows disabled cursor:

1. **Check Windows permissions**: Run the app as administrator once to test
2. **Verify plugin installation**:
   ```bash
   flutter pub get
   flutter clean
   flutter run -d windows --release
   ```

3. **Check for bitsdojo_window conflicts**: The custom window manager might interfere. Try temporarily disabling custom window decorations in `main.dart`:
   ```dart
   // Comment out these lines temporarily:
   // doWhenWindowReady(() {
   //   ...
   // });
   ```

4. **Test with a simple DropTarget**: Create a minimal test widget to isolate the issue:
   ```dart
   DropTarget(
     enable: true,
     onDragDone: (details) {
       print('Files dropped: ${details.files.length}');
     },
     child: Container(
       width: 300,
       height: 300,
       color: Colors.blue,
       child: Center(child: Text('Drop here')),
     ),
   )
   ```

### Known Issues

- **Hot reload doesn't work**: You must fully restart the app after changes to drag-and-drop code
- **Debug vs Release**: Sometimes drag-and-drop works differently in release mode
- **Windows 11 specific**: Some Windows 11 security settings can block drag-and-drop

## Implementation Details

The drag-and-drop implementation:
1. Uses `desktop_drop` package (v0.4.4)
2. Validates file types using MIME types
3. Shows visual feedback during drag operations
4. Stores files in `MessagesController.attachedFiles`
5. Sends files when user presses send or Enter

## Files Modified

- `lib/screens/chats/chat_screen.dart` - Added `enable: true` to DropTarget
