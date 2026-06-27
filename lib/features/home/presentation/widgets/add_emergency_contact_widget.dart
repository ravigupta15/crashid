import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/l10n/app_localizations.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';

class AddEmergencyContactWidget extends StatelessWidget {
  final VoidCallback? callback;
  const AddEmergencyContactWidget({super.key, this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 40, right: 15 ,left: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close)),),
            const SizedBox(height: 35,),
          Text(AppLocalizations.of(context)!.emergencyContactRequiredMessage, 
          style: context.titleMedium.copyWith(
            fontSize: 11, fontWeight: FontWeight.w700,
            color: AppColors.darkGrayColor.withValues(alpha: .6)
          ),
          ),
          const SizedBox(height: 19,),
          AppElevatedButton.withTitle(title: AppLocalizations.of(context)!.addButton, onPressed: callback,)
        ],
      ),
    );
  }
}
