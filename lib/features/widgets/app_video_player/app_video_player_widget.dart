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
    this.showFullScreenButton = false,
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
  final bool showFullScreenButton;

  @override
  State<AppVideoPlayerWidget> createState() => _AppVideoPlayerWidgetState();
}

class _AppVideoPlayerWidgetState extends State<AppVideoPlayerWidget> {
  VideoPlayerController? _controller;
  Future<void>? _initFuture;

  BorderRadius _topRoundedBottomSquareBorderRadius() {
    // Requirement: keep only top corners rounded, bottom corners square.
    return BorderRadius.only(
      topLeft: Radius.circular(widget.borderRadius),
      topRight: Radius.circular(widget.borderRadius),
      bottomLeft: Radius.zero,
      bottomRight: Radius.zero,
    );
  }

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

    setState(() {
      _controller = controller;
      _initFuture = initFuture;
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

        final videoSize = controller.value.size;
        // Prefer `size` over `aspectRatio` to better handle some videos with
        // rotation metadata where `aspectRatio` can be misleading.
        final aspectRatio = (videoSize.width > 0 && videoSize.height > 0)
            ? (videoSize.width / videoSize.height)
            : (controller.value.aspectRatio > 0
                ? controller.value.aspectRatio
                : 16 / 9);

        return ClipRRect(
          borderRadius: _topRoundedBottomSquareBorderRadius(),
          child: AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final isPlaying = controller.value.isPlaying;

              return Stack(
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
                        opacity: isPlaying ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          color: Colors.black26,
                          alignment: Alignment.center,
                          child: Icon(
                            isPlaying
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

                  // Fullscreen option (optional).
                  if (widget.showFullScreenButton)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: IconButton(
                        icon: const Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _openFullScreen(
                            context: context,
                            controller: controller,
                            aspectRatio: aspectRatio,
                          );
                        },
                      ),
                    ),

                  Positioned(
                    right: 10,
                    top: 10,
                    child: IconButton(
                      icon: Icon(
                        isPlaying ? Icons.pause_circle : Icons.play_circle,
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
              );
            },
          ),
        );
      },
    );
  }

  Future<void> _openFullScreen({
    required BuildContext context,
    required VideoPlayerController controller,
    required double aspectRatio,
  }) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.zero,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: _topRoundedBottomSquareBorderRadius(),
          ),
          child: SizedBox.expand(
            child: ClipRRect(
              borderRadius: _topRoundedBottomSquareBorderRadius(),
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final isPlaying = controller.value.isPlaying;
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: AspectRatio(
                          aspectRatio: aspectRatio,
                          child: VideoPlayer(controller),
                        ),
                      ),

                      // Tap anywhere to play/pause.
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
                            opacity: isPlaying ? 0.0 : 1.0,
                            duration:
                                const Duration(milliseconds: 150),
                            child: Container(
                              color: Colors.black26,
                              alignment: Alignment.center,
                              child: Icon(
                                isPlaying
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                size: 74,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),

                      if (widget.showScrubber)
                        Positioned(
                          left: 16,
                          right: 16,
                          bottom: 18,
                          child: VideoProgressIndicator(
                            controller,
                            allowScrubbing: true,
                          ),
                        ),

                      Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.fullscreen_exit,
                            color: Colors.white,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),

                      Positioned(
                        right: 10,
                        top: 10,
                        child: IconButton(
                          icon: Icon(
                            isPlaying
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
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

