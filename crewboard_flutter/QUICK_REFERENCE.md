# Drag and Drop - Quick Reference

## For Users

### How to Send Files
1. **Drag files** from Windows Explorer into chat window
2. OR **Click 📎** icon and select files
3. **Review** attached files
4. **Click send** ➤

### Supported Files
✅ Images: JPG, PNG, GIF, WEBP, BMP
✅ Videos: MP4, MOV, AVI, MKV, WEBM
✅ Audio: MP3, WAV, M4A, FLAC, AAC, OGG

### Remove Files
- Click **×** on individual file
- Click **×** next to "Attached Files" to clear all

---

## For Developers

### Key Files
- `lib/controllers/messages_controller.dart` - File management logic
- `lib/screens/chats/chat_screen.dart` - UI implementation
- `pubspec.yaml` - Dependencies

### Dependencies Added
```yaml
desktop_drop: ^0.4.4
mime: ^1.0.5
path: ^1.9.0
```

### Controller Methods
```dart
// Add files
messagesController.addAttachedFiles([File('path')]);

// Remove file
messagesController.removeAttachedFile(file);

// Clear all
messagesController.clearAttachedFiles();

// Send with attachments
await messagesController.sendMessageWithAttachments();

// Check drag state
if (messagesController.isDragging.value) { }

// Get attached files
messagesController.attachedFiles
```

### File Type Detection
```dart
MessageType getMessageTypeFromFile(File file) {
  final mimeType = lookupMimeType(file.path);
  if (mimeType.startsWith('image/')) return MessageType.image;
  if (mimeType.startsWith('video/')) return MessageType.video;
  if (mimeType.startsWith('audio/')) return MessageType.audio;
  return MessageType.file;
}
```

### UI Components
- `DropTarget` - Wraps chat area for drag and drop
- `_AttachedFileChip` - Displays individual file preview
- Drag overlay - Shows during drag operation

### Installation
```bash
cd crewboard_flutter
flutter pub get
```

### Testing
```bash
flutter analyze lib/screens/chats/chat_screen.dart
flutter run -d windows
```

---

## TODO

### Critical (Before Production)
- [ ] Implement actual file upload to server
- [ ] Add file size validation
- [ ] Error handling for upload failures

### Nice to Have
- [ ] Image thumbnails
- [ ] Upload progress bars
- [ ] File compression
- [ ] Paste from clipboard
- [ ] Drag and drop to specific contacts

---

## Troubleshooting

### Build Errors
```bash
flutter clean
flutter pub get
flutter run
```

### Import Errors
Check that all dependencies are in `pubspec.yaml`

### Drag Not Working
- Ensure `desktop_drop` is installed
- Check that `DropTarget` wraps the chat area
- Verify Windows platform

### Files Not Attaching
- Check MIME type validation
- Verify file exists and is accessible
- Check file extension is supported

---

## Architecture

```
┌─────────────────────────────────────┐
│         User Action                 │
│  (Drag files / Click attach)        │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│    MessagesController               │
│  - Validates MIME types             │
│  - Stores in attachedFiles          │
│  - Manages drag state               │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│         UI Updates                  │
│  - Shows file chips                 │
│  - Displays drag overlay            │
│  - Updates send button              │
└──────────────┬──────────────────────┘
               ↓
┌─────────────────────────────────────┐
│      Send Message                   │
│  - Sends text (if any)              │
│  - Uploads each file                │
│  - Clears attachments               │
└─────────────────────────────────────┘
```

---

## Performance

- **File validation**: O(1) per file (MIME check)
- **UI updates**: Reactive (GetX observables)
- **Memory**: Only stores File references
- **Rendering**: Efficient with Wrap widget

---

## Security

- ✅ MIME type validation
- ✅ Extension whitelist
- ⚠️ Need server-side validation
- ⚠️ Need file size limits
- ⚠️ Need virus scanning (production)
