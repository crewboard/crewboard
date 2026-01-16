# Drag and Drop File Support for Chat

## Overview
The chat screen now supports drag and drop functionality for images, videos, and audio files on Windows.

## Features

### 1. Drag and Drop
- Drag files from Windows Explorer directly into the chat window
- Visual feedback when dragging files over the chat area
- Blue overlay with upload icon appears during drag
- Supports multiple files at once

### 2. Supported File Types

**Images:**
- .jpg, .jpeg, .png, .gif, .webp, .bmp

**Videos:**
- .mp4, .mov, .avi, .mkv, .webm

**Audio:**
- .mp3, .wav, .m4a, .flac, .aac, .ogg

### 3. Manual File Selection
- Click the attachment icon (📎) in the message input area
- Opens file picker dialog
- Select one or multiple files
- Same file type restrictions apply

### 4. File Preview
- Attached files appear above the message input
- Shows file name and appropriate icon (image/video/audio)
- Each file has a remove button (×)
- "Clear all" button to remove all attached files

### 5. Sending Files
- Files are sent when you click the send button
- Text message (if any) is sent first
- Each file is sent as a separate message with appropriate type
- Message input and file list are cleared after sending

## Implementation Details

### Modified Files

1. **pubspec.yaml**
   - Added `desktop_drop: ^0.4.4` for drag and drop support
   - Added `mime: ^1.0.5` for file type detection
   - Added `path: ^1.9.0` for path utilities

2. **messages_controller.dart**
   - Added `isDragging` observable for drag state
   - Added `attachedFiles` list for file management
   - Added `addAttachedFiles()` method with MIME type validation
   - Added `removeAttachedFile()` and `clearAttachedFiles()` methods
   - Added `getMessageTypeFromFile()` to determine message type
   - Added `sendMessageWithAttachments()` to handle file uploads

3. **chat_screen.dart**
   - Wrapped Messages widget with `DropTarget` from desktop_drop
   - Added drag enter/exit/done handlers
   - Added visual overlay during drag operation
   - Updated Keyboard widget to show attached files
   - Added file picker integration for manual selection
   - Created `_AttachedFileChip` widget for file preview

## Usage

### For Users
1. Open a chat room
2. Drag files from Windows Explorer into the chat window
3. OR click the attachment icon and select files
4. Review attached files in the preview area
5. Type an optional message
6. Click send to upload files

### For Developers

**Adding files programmatically:**
```dart
final messagesController = Get.find<MessagesController>();
messagesController.addAttachedFiles([File('path/to/file.jpg')]);
```

**Checking drag state:**
```dart
Obx(() {
  if (messagesController.isDragging.value) {
    // Show drag feedback
  }
});
```

**Sending with attachments:**
```dart
await messagesController.sendMessageWithAttachments();
```

## TODO / Future Enhancements

1. **File Upload to Server**
   - Currently sends file path as message text
   - Need to implement actual file upload to server
   - Get file URL from server response
   - Send URL in message instead of local path

2. **File Size Validation**
   - Add maximum file size limits
   - Show error for oversized files

3. **Image/Video Thumbnails**
   - Generate and show thumbnails in preview
   - Better visual feedback for media files

4. **Progress Indicators**
   - Show upload progress for large files
   - Cancel upload functionality

5. **File Compression**
   - Compress images before upload
   - Video transcoding options

6. **Drag and Drop Zones**
   - Specific drop zones for different file types
   - Quick actions (e.g., drop on contact to send directly)

## Testing

To test the feature:
1. Run the app on Windows
2. Navigate to a chat room
3. Open Windows Explorer
4. Drag an image/video/audio file into the chat window
5. Verify the blue overlay appears
6. Drop the file
7. Check that file appears in preview area
8. Click send and verify message is sent

## Dependencies

- `desktop_drop: ^0.4.4` - Cross-platform drag and drop support
- `file_picker: ^8.0.0` - Native file picker dialogs
- `mime: ^1.0.5` - MIME type detection
- `path: ^1.9.0` - Path manipulation utilities

## Notes

- Only works on Windows (as per requirement)
- Files are validated by MIME type
- Invalid files are silently filtered out
- Multiple files can be attached at once
- Each file is sent as a separate message
