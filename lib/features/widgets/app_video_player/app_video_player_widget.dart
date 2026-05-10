import 'dart:io';

import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayerWidget extends StatefulWidget {
  const AppVideoPlayerWidget({
    super.key,
    this.videoFile,
    this.videoUrl,
    this.height = 220,
    this.borderRadius = 12,
    this.showScrubber = true,
  }) : assert(
          videoFile != null || videoUrl != null,
          'Provide either `videoFile` or `videoUrl`.',
        );

  /// Local video file.
  final File? videoFile;

  /// Remote video URL.
  final String? videoUrl;

  final double height;
  final double borderRadius;
  final bool showScrubber;

  @override
  State<AppVideoPlayerWidget> createState() => _AppVideoPlayerWidgetState();
}

class _AppVideoPlayerWidgetState extends State<AppVideoPlayerWidget> {
  VideoPlayerController? _controller;
  Future<void>? _initFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    _controller?.dispose();

    final controller = widget.videoFile != null
        ? VideoPlayerController.file(widget.videoFile!)
        : VideoPlayerController.networkUrl(
            Uri.parse(widget.videoUrl!),
          );

    final initFuture = controller.initialize();

    controller.addListener(() {
      final playing = controller.value.isPlaying;
      if (_isPlaying != playing && mounted) {
        setState(() => _isPlaying = playing);
      }
    });

    setState(() {
      _controller = controller;
      _initFuture = initFuture;
      _isPlaying = controller.value.isPlaying;
    });

    await initFuture;
    if (!mounted) return;
    setState(() {});
  }

  @override
  void didUpdateWidget(covariant AppVideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoFile?.path != widget.videoFile?.path ||
        oldWidget.videoUrl != widget.videoUrl) {
      _init();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  String _shortName() {
    if (widget.videoFile != null) {
      return widget.videoFile!.path.split(RegExp(r'[\\/]')).last;
    }
    return widget.videoUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final controller = _controller;
    final initFuture = _initFuture;

    if (controller == null || initFuture == null) {
      return SizedBox(
        height: widget.height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    return FutureBuilder(
      future: initFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError || !controller.value.isInitialized) {
          return SizedBox(
            height: widget.height,
            child: Center(
              child: Text(
                'Failed to load video: ${_shortName()}',
                style: context.bodyMedium.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkGrayColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final aspectRatio =
            controller.value.aspectRatio == 0 ? 16 / 9 : controller.value.aspectRatio;

        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: widget.height,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),

              // Tap anywhere on the video to play/pause.
              Positioned.fill(
                child: GestureDetector(
                  onTap: () {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  },
                  child: AnimatedOpacity(
                    opacity: controller.value.isPlaying ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 150),
                    child: Container(
                      color: Colors.black26,
                      alignment: Alignment.center,
                      child: Icon(
                        controller.value.isPlaying
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                        size: 64,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              if (widget.showScrubber)
                Positioned(
                  left: 12,
                  right: 12,
                  bottom: 10,
                  child: VideoProgressIndicator(
                    controller,
                    allowScrubbing: true,
                  ),
                ),

              Positioned(
                right: 10,
                top: 10,
                child: IconButton(
                  icon: Icon(
                    controller.value.isPlaying
                        ? Icons.pause_circle
                        : Icons.play_circle,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (controller.value.isPlaying) {
                      controller.pause();
                    } else {
                      controller.play();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

