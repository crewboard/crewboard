// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import '../config/palette.dart';

class AudioPreview extends StatefulWidget {
  const AudioPreview({
    super.key,
    required this.url,
    this.color = Colors.grey, // Default color if not provided
    this.localUrl = false,
    this.waveform,
  });
  final String url;
  final Color color;
  final bool? localUrl;
  final List<double>? waveform;

  @override
  State<AudioPreview> createState() => _AudioPreviewState();
}

class _AudioPreviewState extends State<AudioPreview> {
  final AudioPlayer _player = AudioPlayer();
  ValueNotifier<bool> playing = ValueNotifier<bool>(false);
  List<double> noises = [];
  double noiseHeight = 50;
  double noiseWidth = 200;

  @override
  void initState() {
    super.initState();
    // Initialize visualization
    // Calculate target item count based on width 200 and item width 2 + gap 1 = 3px unit? 
    // Or width 2 and gap determined by spaceBetween.
    // Let's aim for ~60 items.
    int targetCount = (noiseWidth / 3).floor(); // 200 / 3 = 66

    if (widget.waveform != null && widget.waveform!.isNotEmpty) {
      List<double> raw = widget.waveform!;
      // Resample to targetCount
      noises = [];
      if (raw.length <= targetCount) {
         noises = List.from(raw);
         // Pad if necessary? Or just let it be short.
         // Let's stretch? Or just show what we have.
         // Common behavior: linear interpolation or nearest neighbor if too small?
         // For now just use what we have, maybe it's enough.
         // But if it is huge, we must downsample.
      } else {
         // Downsample
         int chunkSize = (raw.length / targetCount).ceil();
         for (int i = 0; i < targetCount; i++) {
             int start = i * chunkSize;
             if (start >= raw.length) break;
             int end = math.min(start + chunkSize, raw.length);
             // Take average or max
             double chunkMax = 0;
             for (int j = start; j < end; j++) {
                 chunkMax = math.max(chunkMax, raw[j]);
             }
             noises.add(chunkMax);
         }
      }

      // Normalize
      if (noises.isNotEmpty) {
         final max = noises.reduce(math.max);
         if (max > 0) {
            noises = noises.map((e) => 10 + ((e / max) * 20)).toList();
         }
      }
    } else {
        // Fallback to random noise
        noises = [];
        for (int i = 0; i < targetCount; i++) {
            noises.add(10 + ((30 - 10) * math.Random().nextDouble()));
        }
    }
    _init();

    // Listen to player state to update playing notifier
    _player.onPlayerStateChanged.listen((state) {
        if(mounted){
            playing.value = (state == PlayerState.playing);
        }
    });

    _player.onPlayerComplete.listen((event) {
        if(mounted){
            playing.value = false;
        }
    });
  }

  Future<void> _init() async {
    try {
      bool isLocal = widget.localUrl == true;
      
      if (!isLocal && !widget.url.startsWith(RegExp(r'https?://'))) {
         isLocal = true;
      }

      if (isLocal) {
         // Assuming URL is a file path for local
        await _player.setSourceDeviceFile(widget.url);
      } else {
        await _player.setSourceUrl(widget.url);
      }
    } catch (e) {
      debugPrint("Error loading audio source: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.onPositionChanged,
        // audioplayers doesn't have a direct buffered position stream like just_audio, 
        // passing position as buffered for now to satisfy UI or Stream.value(Duration.zero)
        Stream.value(Duration.zero), 
        _player.onDurationChanged,
        (position, bufferedPosition, duration) =>
            PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 60,
      decoration: BoxDecoration(
        color: widget.color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Added min constraint
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: playing,
            builder: (BuildContext context, bool isPlaying, Widget? child) {
              return InkWell(
                onTap: () async {
                  if (isPlaying) {
                    await _player.pause();
                  } else {
                    await _player.resume();
                  }
                },
                child: Icon((isPlaying) ? Icons.pause : Icons.play_arrow, color: Pallet.font3),
              );
            },
          ),
          const SizedBox(width: 10),
          StreamBuilder<PositionData>(
            stream: _positionDataStream,
            initialData: PositionData(Duration.zero, Duration.zero, Duration.zero),
            builder: (context, snapshot) {
              final positionData = snapshot.data;
              if (positionData != null) {
                return SeekBar(
                  width: 200,
                  height: 50,
                  noises: noises,
                  duration: positionData.duration,
                  position: positionData.position,
                  bufferedPosition: positionData.bufferedPosition,
                  onChangeEnd: (newPosition) {
                    _player.seek(newPosition);
                  },
                );
              }
              return const SizedBox(width: 200, height: 50);
            },
          ),
        ],
      ),
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final double width;
  final double height;
  final List<double> noises;

  const SeekBar({
    super.key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.width,
    required this.height,
    required this.noises,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  late SliderThemeData _sliderThemeData;
  int passed = 0;

  @override
  void initState() {
    super.initState();
    _calcPassed();
  }
  
  void _calcPassed() {
      if (widget.duration.inSeconds > 0) {
          int totalSegments = (widget.width / 10).toInt();
          int segmentDuration = (widget.duration.inSeconds / totalSegments).toInt();
          if(segmentDuration > 0) {
               passed = (widget.position.inSeconds / segmentDuration).toInt();
          } else {
              passed = 0;
          }
      } else {
          passed = 0;
      }
  }

  @override
  void didUpdateWidget(covariant SeekBar oldWidget) {
      super.didUpdateWidget(oldWidget);
       _calcPassed();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sliderThemeData = SliderTheme.of(context).copyWith(trackHeight: 2.0);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          SizedBox(
            width: widget.width,
            height: widget.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (int i = 0; i < widget.noises.length; i++)
                  Container(
                    width: 2.5,
                    height: widget.noises[i],
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: i < passed ? Pallet.font1 : Pallet.font3,
                    ),
                  ),
              ],
            ),
          ),
          SliderTheme(
            data: _sliderThemeData.copyWith(
              activeTrackColor: Colors.transparent,
              thumbColor: Colors.transparent,
              disabledActiveTrackColor: Colors.transparent,
              inactiveTrackColor: Colors.transparent,
              overlayColor: Colors.transparent,
              trackShape: CustomTrackShape(width: widget.width),
              thumbShape: SliderComponentShape.noThumb,
              minThumbSeparation: 0,
            ),
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
              },
              value: math.min(
                widget.bufferedPosition.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble(),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Text(
              _remainingString,
              style: TextStyle(color: Pallet.font3, fontSize: 8),
            ),
          ),
        ],
      ),
    );
  }

  String get _remainingString {
      Duration remaining = widget.duration - widget.position;
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(remaining.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(remaining.inSeconds.remainder(60));
      return "$twoDigitMinutes:$twoDigitSeconds";
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  CustomTrackShape({required this.width});
  final double width;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    const double trackHeight = 10;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    return Rect.fromLTWH(trackLeft, trackTop, width, trackHeight);
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
