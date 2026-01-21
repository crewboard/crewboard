import 'dart:io';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../config/palette.dart';
import 'full_screen_video_preview.dart';

class VideoPreview extends StatefulWidget {
  final File? file;
  final String? url;
  final double? height;

  const VideoPreview({
    super.key,
    this.file,
    this.url,
    this.height,
  }) : assert(file != null || url != null, 'Either file or url must be provided');

  @override
  State<VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<VideoPreview> {
  late VideoPlayerController _controller;
  bool _initialized = false;
  bool _showControls = true;
  bool _isHovering = false;
  bool _volumeOpen = false;
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
      _controller.addListener(_updateState);
      
      if (mounted) {
        setState(() {
          _initialized = true;
        });
      }
    } catch (e) {
      debugPrint("Error initializing video player: $e");
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
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    if (_errorMessage != null) {
      return Container(
        height: widget.height ?? 200,
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.redAccent, size: 32),
              const SizedBox(height: 8),
              Text(
                "Error loading video",
                style: TextStyle(color: Pallet.font3, fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    if (!_initialized) {
      return Container(
        height: widget.height ?? 200,
        decoration: BoxDecoration(
          color: Pallet.inside2,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      );
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() {
        _isHovering = false;
        _volumeOpen = false;
      }),
      child: GestureDetector(
        onTap: () => setState(() => _showControls = !_showControls),
        child: Container(
          constraints: BoxConstraints(maxHeight: widget.height ?? 400),
          child: AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  VideoPlayer(_controller),
                  
                  // Gradient Overlay
                  AnimatedOpacity(
                    opacity: (_showControls || _isHovering) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.3),
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.6),
                          ],
                          stops: const [0.0, 0.2, 0.7, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Central Play/Pause
                  AnimatedOpacity(
                    opacity: (!_controller.value.isPlaying || _isHovering) ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _controller.value.isPlaying ? _controller.pause() : _controller.play();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        child: Icon(
                          _controller.value.isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),

                  // Bottom Controls
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: AnimatedSlide(
                      offset: (_showControls || _isHovering) ? Offset.zero : const Offset(0, 1),
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Progress Bar
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              colors: VideoProgressColors(
                                playedColor: const Color(0xFF0084FF),
                                bufferedColor: Colors.white.withValues(alpha: 0.2),
                                backgroundColor: Colors.white.withValues(alpha: 0.1),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                            ),
                            Row(
                              children: [
                                // Volume
                                MouseRegion(
                                  onEnter: (_) => setState(() => _volumeOpen = true),
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () => setState(() {
                                          _controller.setVolume(_controller.value.volume > 0 ? 0 : 1);
                                        }),
                                        child: Icon(
                                          _controller.value.volume > 0 ? Icons.volume_up_rounded : Icons.volume_off_rounded,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                      if (_volumeOpen)
                                        SizedBox(
                                          width: 60,
                                          height: 20,
                                          child: SliderTheme(
                                            data: SliderTheme.of(context).copyWith(
                                              trackHeight: 2,
                                              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 4),
                                              overlayShape: const RoundSliderOverlayShape(overlayRadius: 10),
                                            ),
                                            child: Slider(
                                              value: _controller.value.volume,
                                              onChanged: (v) => _controller.setVolume(v),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Time
                                Text(
                                  "${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}",
                                  style: const TextStyle(color: Colors.white, fontSize: 10),
                                ),
                                const Spacer(),
                                // Fullscreen Toggle
                                GestureDetector(
                                  onTap: () async {
                                    final bool wasPlaying = _controller.value.isPlaying;
                                    if (wasPlaying) await _controller.pause();
                                    
                                    if (!mounted) return;
                                    
                                    final dynamic result = await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FullScreenVideoPreview(
                                          url: widget.url,
                                          file: widget.file,
                                          startPosition: _controller.value.position,
                                        ),
                                      ),
                                    );

                                    if (result is Duration && mounted) {
                                      await _controller.seekTo(result);
                                      if (wasPlaying) await _controller.play();
                                    }
                                  },
                                  child: const Icon(Icons.fullscreen_rounded, color: Colors.white, size: 20),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
