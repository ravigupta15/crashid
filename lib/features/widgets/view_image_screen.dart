import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/utils/app_cached_network/app_cached_network_images.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ViewImageScreen extends StatefulWidget {
  static const kImageUrl = "/kImageUrl";

  final String? imageUrl;
  static void open(BuildContext context, {String? imageUrl}) {
    context.push(AppRoutesPath.viewImageScreen, extra: {kImageUrl: imageUrl});
  }

  const ViewImageScreen({super.key, this.imageUrl});

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: AppCachedNetworkImage(imageUrl: widget.imageUrl ?? ''),
      ),
      // body: ,
    );
  }
}
