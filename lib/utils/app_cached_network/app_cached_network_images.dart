import 'package:cached_network_image/cached_network_image.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppCachedNetworkImage extends StatefulWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double borderRadius;
  final Widget? errorPlaceholder;
  final Widget? loadingPlaceholder;
  final BoxFit? boxFit;
  final int? maxWidthDiskCache;
  final int? memCacheWidth;
  final int? maxHeightDiskCache;
  final int? memCacheHeight;
  final bool enableCache;
  final bool canOpenImage;

  const AppCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.borderRadius = 0,
    this.boxFit,
    this.maxWidthDiskCache,
    this.memCacheWidth,
    this.maxHeightDiskCache,
    this.memCacheHeight,
    this.enableCache = true,
    this.canOpenImage = false,
  });

  @override
  State<AppCachedNetworkImage> createState() => _AppCachedNetworkImageState();
}

class _AppCachedNetworkImageState extends State<AppCachedNetworkImage> {
  @override
  void dispose() {
    _deleteImageFromCache();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _checkMemory();
    return (imageUrl.isEmpty || !_validURL)
        ? SizedBox(
            height: widget.height,
            width: widget.width,
            child: widget.errorPlaceholder ?? _ImageErrorWidget(),
          )
        : GestureDetector(
            onTap: widget.canOpenImage
                ? () {
                    // FilePreviewScreen.open(context, imageUrl);
                  }
                : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              child: _isSVGImage(imageUrl)
                  ? SvgPicture.network(
                      imageUrl,
                      height: widget.height,
                      width: widget.width,
                      fit: widget.boxFit ?? BoxFit.contain,
                      placeholderBuilder: (context) =>
                          widget.loadingPlaceholder ??
                          const _ImageProgressIndicatorBuilder(),
                      errorBuilder: (context, error, stackTrace) =>
                          widget.errorPlaceholder ?? const _ImageErrorWidget(),
                    )
                  : CachedNetworkImage(
                      height: widget.height,
                      width: widget.width,
                      imageUrl: imageUrl,
                      fit: widget.boxFit,

                      /// when enable to cache the image then
                      cacheKey: widget.enableCache ? imageUrl : null,
                      maxWidthDiskCache: widget.maxWidthDiskCache,
                      memCacheWidth: widget.memCacheWidth,
                      maxHeightDiskCache: widget.maxHeightDiskCache,
                      memCacheHeight: widget.memCacheHeight,

                      // placeholder: (context, url) => Image.asset(AppAssetPaths.placeholderIcon),
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) {
                        return widget.loadingPlaceholder ??
                            const _ImageProgressIndicatorBuilder();
                      },
                      errorWidget: (context, url, error) =>
                          widget.errorPlaceholder ?? const _ImageErrorWidget(),
                    ),
            ),
          );
  }

  String get imageUrl {
    if (
        // AppConfigUtils.onDevelopment &&
        widget.imageUrl.contains("assets/camera.svg")) {
      return "";
    }
    return widget.imageUrl;
  }

///////////////////////////////////////////////////////////
//////////////////// Helper methods ///////////////////////
///////////////////////////////////////////////////////////

  Future _deleteImageFromCache() async {
    if (!widget.enableCache) {
      await CachedNetworkImage.evictFromCache(imageUrl);
    }
  }

  bool _isSVGImage(String attachmentPath) {
    final String ext = attachmentPath.split(".").last.toLowerCase();
    return ext == "svg";
  }

  bool get _validURL => Validator.isUrl(imageUrl);

  void _checkMemory() {
    final ImageCache imageCache = PaintingBinding.instance.imageCache;
    if (imageCache.currentSizeBytes >= 100 << 19 ||
        imageCache.currentSize >= imageCache.maximumSize) {
      imageCache.clear();
      imageCache.clearLiveImages();
    }
  }
}

class AppCachedNetworkImageProvider extends CachedNetworkImageProvider {
  final String imageUrl;

  const AppCachedNetworkImageProvider({
    required this.imageUrl,
    int? maxHeight,
    int? maxWidth,
  }) : super(
          imageUrl,
          maxHeight: maxHeight,
          maxWidth: maxWidth,
        );
}

class _ImageProgressIndicatorBuilder extends StatelessWidget {
  const _ImageProgressIndicatorBuilder()
      : super(key: const ValueKey("_ImageProgressIndicatorBuilder"));

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: RepaintBoundary(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ImageErrorWidget extends StatelessWidget {
  const _ImageErrorWidget() : super(key: const ValueKey("_ImageErrorWidget"));

  @override
  Widget build(BuildContext context) {
    return  FittedBox(
      child: Center(
        child: Padding(padding: EdgeInsets.all(20.0), child: SvgPicture.asset(AppAssetPaths.appLogoIcon)
        ),
      ),
    );
  }
}
