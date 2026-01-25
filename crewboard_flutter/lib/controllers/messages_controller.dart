import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:mime/mime.dart';
import '../../main.dart'; // For client
import 'package:flutter/services.dart';
import 'rooms_controller.dart';
import 'emoji_controller.dart';
import 'auth_controller.dart';
import 'package:waveform_extractor/waveform_extractor.dart';

class MessagesController extends GetxController {
  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isDragging = false.obs;
  final RxList<File> attachedFiles = <File>[].obs;
  final RxBool showFilePreview = false.obs;
  
  // User cache for displaying message author info
  final Map<UuidValue, User> _userCache = {};

  // Autocomplete state
  final RxList<Emoji> autocompleteEmojis = <Emoji>[].obs;
  final RxInt selectedAutocompleteIndex = 0.obs;
  final RxBool showAutocomplete = false.obs;




  void addEmojiToMessage(String emoji) {
    print("Adding emoji: $emoji");
    final text = messageController.text;
    final selection = messageController.selection;
    
    if (selection.baseOffset >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, emoji);
      messageController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: selection.baseOffset + emoji.length),
      );
    } else {
      messageController.text += emoji;
    }
  }

  Future<void> sendGifMessage(GiphyGif gif) async {
      print("Sending GIF: ${gif.id}");
      if(gif.images?.original?.url != null) {
          sendMessage(
            messageText: gif.images!.original!.url,
            messageType: MessageType.image, 
          );
      }
  }

  Future<void> sendInlineGifMessage(Gif gif) async {
      print("Sending Inline GIF: ${gif.id}");
      sendMessage(
        messageText: gif.url,
        messageType: MessageType.image, 
      );
  }

  final Rx<ChatMessage?> reply = Rx<ChatMessage?>(null);
  final Rx<ChatMessage?> edit = Rx<ChatMessage?>(null);

  final TextEditingController messageController = TextEditingController();

  Future<void> loadInitialMessages({required UuidValue roomId}) async {
    try {
      isLoading.value = true;
      final response = await client.chat.getMessages(
        roomId,
        limit: 50,
        offset: 0,
      );
      messages.assignAll(response);
      subscribeToRoom(roomId);
    } catch (e) {
      debugPrint('Error loading messages: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required MessageType messageType,
    List<double>? waveform,
  }) async {
    final roomsController = Get.find<RoomsController>();
    final selectedRoom = roomsController.selectedRoom.value;
    if (selectedRoom == null) return;

    if (messageText.trim().isEmpty) return;

    final chatMessage = ChatMessage(
      roomId: selectedRoom.id!,
      message: messageText,
      messageType: messageType,
      seenUserList: [],
      sameUser: false,
      deleted: false,
      createdAt: DateTime.now(),
      userId: Get.find<AuthController>().currentUserId.value ?? UuidValue.fromString('00000000-0000-0000-0000-000000000000'),
      waveform: waveform,
    );

    try {
      await client.chat.sendMessage(chatMessage);
      messageController.clear();
      // Update the room's last message on the sidebar
      roomsController.updateLastMessage(selectedRoom.id!, chatMessage);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  StreamSubscription<ChatStreamEvent>? _subscription;
  Timer? _typingDebounce;
  final RxList<TypingIndicator> typingUsers = <TypingIndicator>[].obs;

  @override
  void onClose() {
    _subscription?.cancel();
    _typingDebounce?.cancel();
    super.onClose();
  }

  void onTextChanged(String text) {
    if (_typingDebounce?.isActive ?? false) _typingDebounce!.cancel();

    _typingDebounce = Timer(const Duration(milliseconds: 500), () {
        _sendTypingStatus(false);
    });

    _sendTypingStatus(true);
    
    _checkAutocomplete(text);
  }

  void _checkAutocomplete(String text) async {
    final selection = messageController.selection;
    if (selection.baseOffset <= 0) {
      showAutocomplete.value = false;
      return;
    }

    final textBeforeCursor = text.substring(0, selection.baseOffset);
    final lastColonIndex = textBeforeCursor.lastIndexOf(':');

    if (lastColonIndex != -1) {
      final query = textBeforeCursor.substring(lastColonIndex + 1);
      // Support queries like :smile, but only if there's no space after colon
      if (!query.contains(' ')) {
        if (query.length >= 1) {
          final emojiController = Get.find<EmojiController>();
          final results = await emojiController.searchEmojis(query);
          autocompleteEmojis.assignAll(results.take(5).toList());
          if (autocompleteEmojis.isNotEmpty) {
            showAutocomplete.value = true;
            // Keep index in bounds if query changed
            if (selectedAutocompleteIndex.value >= autocompleteEmojis.length) {
              selectedAutocompleteIndex.value = 0;
            }
          } else {
            showAutocomplete.value = false;
          }
          return;
        }
      }
    }
    showAutocomplete.value = false;
  }

  KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!showAutocomplete.value || autocompleteEmojis.isEmpty) return KeyEventResult.ignored;

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        selectedAutocompleteIndex.value = (selectedAutocompleteIndex.value + 1) % autocompleteEmojis.length;
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        selectedAutocompleteIndex.value = (selectedAutocompleteIndex.value - 1 + autocompleteEmojis.length) % autocompleteEmojis.length;
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.enter || event.logicalKey == LogicalKeyboardKey.tab) {
        selectEmojiFromAutocomplete(autocompleteEmojis[selectedAutocompleteIndex.value]);
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        showAutocomplete.value = false;
        autocompleteEmojis.clear();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  void selectEmojiFromAutocomplete(Emoji emoji) {
    final text = messageController.text;
    final selection = messageController.selection;
    final textBeforeCursor = text.substring(0, selection.baseOffset);
    final lastColonIndex = textBeforeCursor.lastIndexOf(':');

    if (lastColonIndex != -1) {
      final newText = text.replaceRange(lastColonIndex, selection.baseOffset, emoji.emoji);
      messageController.text = newText;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: lastColonIndex + emoji.emoji.length),
      );
      showAutocomplete.value = false;
      autocompleteEmojis.clear();
      selectedAutocompleteIndex.value = 0;
    }
  }


  Future<void> _sendTypingStatus(bool isTyping) async {
    final room = Get.find<RoomsController>().selectedRoom.value;
    if (room == null) return;
    try {
        await client.chat.sendTyping(isTyping, room.id!);
    } catch (e) {
        debugPrint("Error sending typing status: $e");
    }
  }

  /// Get user profile for a given user ID
  User? getUserProfile(UuidValue userId) {
    return _userCache[userId];
  }
  
  /// Cache user information from room data
  void cacheUserFromRoom(ChatRoom room, UuidValue userId) {
    if (_userCache.containsKey(userId)) return;
    
    // For direct rooms, extract username from room name (format: "User1 & User2")
    if (room.roomType == 'direct' && room.roomName != null) {
      final names = room.roomName!.split(' & ');
      if (names.length == 2) {
        // We don't know which user is which, so we'll need to handle this differently
        // For now, just create placeholder users
        // This is a limitation without a getRoomMembers endpoint
      }
    }
  }

  void subscribeToRoom(UuidValue roomId) {
    _subscription?.cancel();
    _subscription = client.chat.subscribeToRoom(roomId).listen((event) {
      if (event.message != null) {
         final message = event.message!;
         if (messages.any((m) => m.id == message.id)) return;
         messages.insert(0, message);
         
         // Remove typing indicator for this user if message received
         typingUsers.removeWhere((t) => t.userId == message.userId);
      } else if (event.typing != null) {
          final typing = event.typing!;
          if (typing.isTyping) {
             // Add if not exists
             if (!typingUsers.any((t) => t.userId == typing.userId)) {
                 typingUsers.add(typing);
             }
             
             // Auto-remove after 3 seconds if no stop received or message
              Timer(const Duration(seconds: 3), () {
                 typingUsers.removeWhere((t) => t.userId == typing.userId);
              });
          } else {
              typingUsers.removeWhere((t) => t.userId == typing.userId);
          }
      }
    });
  }

  void addAttachedFiles(List<File> files) {
    final validFiles = files.where((file) {
      final mimeType = lookupMimeType(file.path);
      if (mimeType == null) return false;

      return mimeType.startsWith('image/') ||
          mimeType.startsWith('video/') ||
          mimeType.startsWith('audio/');
    }).toList();

    attachedFiles.addAll(validFiles);
    if (validFiles.isNotEmpty) {
      showFilePreview.value = true;
    }
  }

  void removeAttachedFile(File file) {
    attachedFiles.remove(file);
  }

  void clearAttachedFiles() {
    attachedFiles.clear();
    showFilePreview.value = false;
  }

  void closeFilePreview() {
    clearAttachedFiles();
  }

  MessageType getMessageTypeFromFile(File file) {
    final mimeType = lookupMimeType(file.path);
    if (mimeType == null) return MessageType.text;

    if (mimeType.startsWith('image/')) return MessageType.image;
    if (mimeType.startsWith('video/')) return MessageType.video;
    if (mimeType.startsWith('audio/')) return MessageType.audio;

    return MessageType.file;
  }

  Future<void> sendMessageWithAttachments() async {
    if (attachedFiles.isEmpty && messageController.text.trim().isEmpty) {
      return;
    }

    // Send text message if present
    if (messageController.text.trim().isNotEmpty) {
      await sendMessage(
        messageText: messageController.text,
        messageType: MessageType.text,
      );
    }

    // Send each file as a separate message
    for (final file in attachedFiles) {
      final messageType = getMessageTypeFromFile(file);

      // Upload file to server and get URL
      String content = file.path;
      try {
        final bytes = await file.readAsBytes();
        final uploadedUrl = await client.upload.uploadFile(
          file.path,
          ByteData.view(bytes.buffer),
        );
        if (uploadedUrl != null) {
          content = uploadedUrl;
        }
      } catch (e) {
        debugPrint('Error uploading file: $e');
        // Fallback to local path or handle error
      }

      List<double>? waveform;
      if (messageType == MessageType.audio) {
        try {
          // Extract waveform
          // This requires importing audio_waveforms
          // We'll add the import in a separate chunk or just use dynamic if easy,
          // but better to import.
          final extractor = WaveformExtractor();
          final result = await extractor.extractWaveform(
            file.path,

          );
          // Result is List<double> but generic?
          // Check package signature. usually returns List<double>.
          // If result is expected to be simple list.
          if (result.waveformData.isNotEmpty) {
            // Normalize if needed, but usually it's fine.
            // Map to our expected range if raw values are huge?
            // The package usually returns raw amplitude.
            // We might need to normalization on UI side or here.
            // Let's store raw integers/doubles.
            waveform = result.waveformData.map((e) => e.toDouble()).toList();
          }
        } catch (e) {
          debugPrint("Error extracting waveform: $e");
        }
      }

      await sendMessage(
        messageText: content,
        messageType: messageType,
        waveform: waveform,
      );
    }

    clearAttachedFiles();
    showFilePreview.value = false;
  }
}
