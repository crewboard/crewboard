import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;

class FullScreenVideoPreview extends StatefulWidget {
  final String? url;
  final File? file;
  final Duration startPosition;

  const FullScreenVideoPreview({
    super.key,
    this.url,
    this.file,
    this.startPosition = Duration.zero,
  }) : assert(url != null || file != null);

  @override
  State<FullScreenVideoPreview> createState() => _FullScreenVideoPreviewState();
}

class _FullScreenVideoPreviewState extends State<FullScreenVideoPreview> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;
  bool _volumeOpen = false;
  bool _isDownloading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      if (widget.file != null) {
        _controller = VideoPlayerController.file(widget.file!);
      } else {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.url!));
      }

      await _controller.initialize();
      await _controller.seekTo(widget.startPosition);
      _controller.addListener(_updateState);

      if (mounted) {
        setState(() {
          _initialized = true;
        });
        _controller.play(); // Auto-play on fullscreen
      }
    } catch (e) {
      debugPrint("Error initializing fullscreen video: $e");
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
        });
      }
    }
  }

  void _updateState() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_updateState);
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Future<void> _downloadVideo() async {
    if (widget.url == null) return;

    setState(() => _isDownloading = true);

    try {
      final ByteData data = await NetworkAssetBundle(
        Uri.parse(widget.url!),
      ).load("");
      final Uint8List bytes = data.buffer.asUint8List();

      String fileName = "video.mp4";
      try {
        final uri = Uri.parse(widget.url!);
        final segments = uri.pathSegments;
        if (segments.isNotEmpty) fileName = segments.last;
      } catch (_) {}

      if (!p.extension(fileName).isNotEmpty) fileName += ".mp4";

      String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Video',
        fileName: fileName,
        type: FileType.video,
      );

      if (outputFile != null) {
        final file = File(outputFile);
        await file.writeAsBytes(bytes);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Video saved successfully')),
          );
        }
      }
    } catch (e) {
      debugPrint("Download error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save video: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isDownloading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        alignment: Alignment.center,
        children: [
          if (_errorMessage != null)
            Center(
              child: Text(
                "Error: $_errorMessage",
                style: const TextStyle(color: Colors.white),
              ),
            )
          else if (!_initialized)
            const Center(child: CircularProgressIndicator(color: Colors.white))
          else
            GestureDetector(
              onTap: () => setState(() => _showControls = !_showControls),
              child: Center(
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),

          // Top Bar
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 300),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pop(_controller.value.position),
                  ),
                  const Spacer(),
                  if (widget.url != null)
                    _isDownloading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : IconButton(
                            icon: const Icon(
                              Icons.download_rounded,
                              color: Colors.white,
                            ),
                            onPressed: _downloadVideo,
                          ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () =>
                        Navigator.of(context).pop(_controller.value.position),
                  ),
                ],
              ),
            ),
          ),

          // Central Play/Pause
          if (_initialized && (!_controller.value.isPlaying || _showControls))
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Icon(
                    _controller.value.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 48,
                  ),
                ),
              ),
            ),

          // Bottom Controls
          if (_initialized)
            Positioned(
              bottom: 40,
              left: 30,
              right: 30,
              child: AnimatedOpacity(
                opacity: _showControls ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    VideoProgressIndicator(
                      _controller,
                      allowScrubbing: true,
                      colors: VideoProgressColors(
                        playedColor: const Color(0xFF0084FF),
                        bufferedColor: Colors.white.withValues(alpha: 0.2),
                        backgroundColor: Colors.white.withValues(alpha: 0.1),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    Row(
                      children: [
                        // Volume
                        MouseRegion(
                          onEnter: (_) => setState(() => _volumeOpen = true),
                          onExit: (_) => setState(() => _volumeOpen = false),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () => setState(() {
                                  _controller.setVolume(
                                    _controller.value.volume > 0 ? 0 : 1,
                                  );
                                }),
                                child: Icon(
                                  _controller.value.volume > 0
                                      ? Icons.volume_up_rounded
                                      : Icons.volume_off_rounded,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              if (_volumeOpen)
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 100,
                                  height: 30,
                                  child: SliderTheme(
                                    data: SliderTheme.of(context).copyWith(
                                      trackHeight: 2,
                                      thumbShape: const RoundSliderThumbShape(
                                        enabledThumbRadius: 6,
                                      ),
                                      overlayShape:
                                          const RoundSliderOverlayShape(
                                            overlayRadius: 12,
                                          ),
                                    ),
                                    child: Slider(
                                      value: _controller.value.volume,
                                      onChanged: (v) =>
                                          _controller.setVolume(v),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.fullscreen_exit_rounded,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () => Navigator.of(
                            context,
                          ).pop(_controller.value.position),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
