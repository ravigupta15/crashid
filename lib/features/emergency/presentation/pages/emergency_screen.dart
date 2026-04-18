import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/emergency/presentation/widgets/trusted_friend_card_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmergencyScreen extends StatefulWidget {
  
  static void open(BuildContext context) {
    context.push(AppRoutesPath.emergencyScreen);
  }

  const EmergencyScreen({super.key});

  @override
  State<EmergencyScreen> createState() => _EmergencyScreenState();
}

class _EmergencyScreenState extends State<EmergencyScreen> {
  static const List<_TrustedFriendData> _friends = [
    _TrustedFriendData(
      name: 'Alexander Mitchell',
      email: 'alexander.mitchell@email.com',
      plateNumber: 'ABC-1234',
      badgeLabel: 'Active',
      initial: 'A',
    ),
    _TrustedFriendData(
      name: 'Sofia Williams',
      email: 'sofia.williams@email.com',
      plateNumber: 'XYZ-9876',
      badgeLabel: 'Family',
      initial: 'S',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Emergency',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.notifications,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
      body: _screenContent(),
    );
  }

  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return ColoredBox(
      color: AppColors.screenBackground,
      child: Padding( padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
       
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: AppElevatedButton.withTitleAndIcon(
                          icon: Icon(Icons.add, color: AppColors.whiteColor,),
                           title: "Add New", 
                           width: 120,
                           height: 48,
                           textColor: AppColors.whiteColor,
                           onPressed: (){},),
            ),
                          Text(
                'Trusted Friends',
                style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.blackColor,
                    ),
              ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context,sb) => const SizedBox(height: 24,),
                itemCount: _friends.length,
                padding: EdgeInsets.only(top: 20, bottom: 30),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var f = _friends[index];
                return TrustedFriendCardWidget(
                  name: f.name,
                  email: f.email,
                  plateNumber: f.plateNumber,
                  badgeLabel: f.badgeLabel,
                  initial: f.initial,
                  onDetails: () {},
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}

class _TrustedFriendData {
  final String name;
  final String email;
  final String plateNumber;
  final String badgeLabel;
  final String initial;

  const _TrustedFriendData({
    required this.name,
    required this.email,
    required this.plateNumber,
    required this.badgeLabel,
    required this.initial,
  });
}
