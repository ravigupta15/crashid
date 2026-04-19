import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/notification/presentation/widgets/notification_card_widget.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationScreen extends StatefulWidget {
  static void open(BuildContext context) {
    context.push(AppRoutesPath.notificationScreen);
  }

  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: CustomAppBar(
        title: 'Notifications',
       
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY',
            style: context.titleMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor,
            ),
          ),
          const SizedBox(height: 15),
          NotificationCardWidget(
            title: 'Emergency Alert',
            onPrimaryTap: () {},
          ),
          const SizedBox(height: 14),
          NotificationCardWidget(
            title: 'Witness Request',
            onPrimaryTap: () {},
            onSecondaryTap: () {},
          ),
          const SizedBox(height: 14),
          NotificationCardWidget(
            title: 'Accident Request',
            onPrimaryTap: () {},
            onSecondaryTap: () {},
          ),
        ],
      ),
    );
  }
}
