import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crewboard_client/crewboard_client.dart';
import 'package:giphy_get/giphy_get.dart';
import 'package:mime/mime.dart';
import '../../main.dart'; // For client
import 'package:flutter/services.dart';
import 'rooms_controller.dart';
import 'emoji_controller.dart';
import 'auth_controller.dart';
import 'dart:convert';
import 'package:waveform_extractor/waveform_extractor.dart';

class MessagesState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final bool isDragging;
  final List<File> attachedFiles;
  final bool showFilePreview;
  final List<Emoji> autocompleteEmojis;
  final int selectedAutocompleteIndex;
  final bool showAutocomplete;
  final List<TypingIndicator> typingUsers;
  final ChatMessage? reply;
  final ChatMessage? edit;

  MessagesState({
    this.messages = const [],
    this.isLoading = false,
    this.isDragging = false,
    this.attachedFiles = const [],
    this.showFilePreview = false,
    this.autocompleteEmojis = const [],
    this.selectedAutocompleteIndex = 0,
    this.showAutocomplete = false,
    this.typingUsers = const [],
    this.reply,
    this.edit,
  });

  MessagesState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    bool? isDragging,
    List<File>? attachedFiles,
    bool? showFilePreview,
    List<Emoji>? autocompleteEmojis,
    int? selectedAutocompleteIndex,
    bool? showAutocomplete,
    List<TypingIndicator>? typingUsers,
    ChatMessage? reply,
    ChatMessage? edit,
    bool clearReply = false,
    bool clearEdit = false,
  }) {
    return MessagesState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      isDragging: isDragging ?? this.isDragging,
      attachedFiles: attachedFiles ?? this.attachedFiles,
      showFilePreview: showFilePreview ?? this.showFilePreview,
      autocompleteEmojis: autocompleteEmojis ?? this.autocompleteEmojis,
      selectedAutocompleteIndex:
          selectedAutocompleteIndex ?? this.selectedAutocompleteIndex,
      showAutocomplete: showAutocomplete ?? this.showAutocomplete,
      typingUsers: typingUsers ?? this.typingUsers,
      reply: clearReply ? null : (reply ?? this.reply),
      edit: clearEdit ? null : (edit ?? this.edit),
    );
  }
}

final messagesProvider = NotifierProvider<MessagesNotifier, MessagesState>(MessagesNotifier.new);

class MessagesNotifier extends Notifier<MessagesState> {
  final Map<UuidValue, User> _userCache = {};
  StreamSubscription<ChatStreamEvent>? _subscription;
  Timer? _typingDebounce;
  final TextEditingController messageController = TextEditingController();

  @override
  MessagesState build() {
    ref.onDispose(() {
      _subscription?.cancel();
      _typingDebounce?.cancel();
      messageController.dispose();
    });
    return MessagesState();
  }

  void addEmojiToMessage(String emoji) {
    print("Adding emoji: $emoji");
    final text = messageController.text;
    final selection = messageController.selection;

    if (selection.baseOffset >= 0) {
      final newText = text.replaceRange(selection.start, selection.end, emoji);
      messageController.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(
          offset: selection.baseOffset + emoji.length,
        ),
      );
    } else {
      messageController.text += emoji;
    }
  }

  void setReply(ChatMessage? message) {
    if (message == null) {
      state = state.copyWith(clearReply: true);
    } else {
      state = state.copyWith(reply: message);
    }
  }

  void setEdit(ChatMessage? message) {
    if (message == null) {
      state = state.copyWith(clearEdit: true);
    } else {
      state = state.copyWith(edit: message);
    }
  }

  void setIsDragging(bool dragging) {
    state = state.copyWith(isDragging: dragging);
  }

  Future<void> sendGifMessage(GiphyGif gif) async {
    print("Sending GIF: ${gif.id}");
    if (gif.images?.original?.url != null) {
      sendMessage(
        messageText: gif.images!.original!.url!,
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

  Future<void> loadInitialMessages({required UuidValue roomId}) async {
    try {
      state = state.copyWith(isLoading: true);
      final response = await client.chat.getMessages(
        roomId,
        limit: 50,
        offset: 0,
      );
      state = state.copyWith(messages: response, isLoading: false);
      subscribeToRoom(roomId);
    } catch (e) {
      debugPrint('Error loading messages: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> sendMessage({
    required String messageText,
    required MessageType messageType,
    List<double>? waveform,
    UuidValue? parentMessageId,
  }) async {
    final roomsState = ref.read(roomsProvider);
    final selectedRoom = roomsState.selectedRoom;
    if (selectedRoom == null) return;

    if (messageText.trim().isEmpty) return;

    final authState = ref.read(authProvider);

    final chatMessage = ChatMessage(
      roomId: selectedRoom.id!,
      message: messageText,
      messageType: messageType,
      seenUserList: [],
      sameUser: false,
      deleted: false,
      createdAt: DateTime.now(),
      userId: authState.currentUserId ??
          UuidValue.fromString('00000000-0000-0000-0000-000000000000'),
      waveform: waveform,
      parentMessageId: parentMessageId ?? state.reply?.id,
    );

    try {
      await client.chat.sendMessage(chatMessage);
      messageController.clear();
      // Clear reply state
      if (state.reply != null) {
        state = state.copyWith(clearReply: true);
      }
      // Update the room's last message on the sidebar
      ref.read(roomsProvider.notifier).updateLastMessage(selectedRoom.id!, chatMessage);
    } catch (e) {
      debugPrint('Error sending message: $e');
    }
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
      state = state.copyWith(showAutocomplete: false);
      return;
    }

    final textBeforeCursor = text.substring(0, selection.baseOffset);
    final lastColonIndex = textBeforeCursor.lastIndexOf(':');

    if (lastColonIndex != -1) {
      final query = textBeforeCursor.substring(lastColonIndex + 1);
      // Support queries like :smile, but only if there's no space after colon
      if (!query.contains(' ')) {
        if (query.length >= 1) {
          final emojiNotifier = ref.read(emojiProvider.notifier);
          final results = await emojiNotifier.searchEmojis(query);
          final autocompleteEmojis = results.take(5).toList();
          
          if (autocompleteEmojis.isNotEmpty) {
            state = state.copyWith(
              autocompleteEmojis: autocompleteEmojis,
              showAutocomplete: true,
              selectedAutocompleteIndex: state.selectedAutocompleteIndex >= autocompleteEmojis.length ? 0 : state.selectedAutocompleteIndex,
            );
          } else {
            state = state.copyWith(showAutocomplete: false);
          }
          return;
        }
      }
    }
    state = state.copyWith(showAutocomplete: false);
  }

  KeyEventResult handleKeyEvent(FocusNode node, KeyEvent event) {
    if (!state.showAutocomplete || state.autocompleteEmojis.isEmpty)
      return KeyEventResult.ignored;

    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        state = state.copyWith(
          selectedAutocompleteIndex: (state.selectedAutocompleteIndex + 1) % state.autocompleteEmojis.length,
        );
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        state = state.copyWith(
          selectedAutocompleteIndex: (state.selectedAutocompleteIndex - 1 + state.autocompleteEmojis.length) %
            state.autocompleteEmojis.length,
        );
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.enter ||
          event.logicalKey == LogicalKeyboardKey.tab) {
        selectEmojiFromAutocomplete(
          state.autocompleteEmojis[state.selectedAutocompleteIndex],
        );
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.escape) {
        state = state.copyWith(showAutocomplete: false, autocompleteEmojis: []);
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
      final newText = text.replaceRange(
        lastColonIndex,
        selection.baseOffset,
        emoji.emoji,
      );
      messageController.text = newText;
      messageController.selection = TextSelection.fromPosition(
        TextPosition(offset: lastColonIndex + emoji.emoji.length),
      );
      state = state.copyWith(
        showAutocomplete: false,
        autocompleteEmojis: [],
        selectedAutocompleteIndex: 0,
      );
    }
  }

  Future<void> _sendTypingStatus(bool isTyping) async {
    final roomsState = ref.read(roomsProvider);
    final room = roomsState.selectedRoom;
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

  void subscribeToRoom(UuidValue roomId) {
    _subscription?.cancel();
    _subscription = client.chat.subscribeToRoom(roomId).listen((event) {
      if (event.message != null) {
        final message = event.message!;
        if (state.messages.any((m) => m.id == message.id)) return;
        
        state = state.copyWith(
          messages: [message, ...state.messages],
          typingUsers: state.typingUsers.where((t) => t.userId != message.userId).toList(),
        );
      } else if (event.typing != null) {
        final typing = event.typing!;
        if (typing.isTyping) {
          // Add if not exists
          if (!state.typingUsers.any((t) => t.userId == typing.userId)) {
            state = state.copyWith(
              typingUsers: [...state.typingUsers, typing],
            );
          }

          // Auto-remove after 3 seconds if no stop received or message
          Timer(const Duration(seconds: 3), () {
            state = state.copyWith(
              typingUsers: state.typingUsers.where((t) => t.userId != typing.userId).toList(),
            );
          });
        } else {
          state = state.copyWith(
            typingUsers: state.typingUsers.where((t) => t.userId != typing.userId).toList(),
          );
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

    state = state.copyWith(
      attachedFiles: [...state.attachedFiles, ...validFiles],
      showFilePreview: validFiles.isNotEmpty || state.showFilePreview,
    );
  }

  void removeAttachedFile(File file) {
    state = state.copyWith(
      attachedFiles: state.attachedFiles.where((f) => f.path != file.path).toList(),
    );
  }

  void clearAttachedFiles() {
    state = state.copyWith(
      attachedFiles: [],
      showFilePreview: false,
    );
  }

  void updateAttachedFiles(List<File> files) {
    state = state.copyWith(attachedFiles: files);
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
    if (state.attachedFiles.isEmpty && messageController.text.trim().isEmpty) {
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
    for (final file in state.attachedFiles) {
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
      }

      List<double>? waveform;
      if (messageType == MessageType.audio) {
        try {
          final extractor = WaveformExtractor();
          final result = await extractor.extractWaveform(
            file.path,
          );
          if (result.waveformData.isNotEmpty) {
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
  }
}
