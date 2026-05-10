import 'package:crashid/app_routes/app_routes_path.dart';
import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/features/add_accident/presentation/widgets/accident_details_widget.dart';
import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:crashid/res/app_asset_paths.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CaseDetailsScreen extends StatefulWidget {
  static const String kId = "kId";

  final String? id;
    static void open(BuildContext context, {String? id}) {
    context.push(AppRoutesPath.caseDetailsScreen, extra: {CaseDetailsScreen.kId: id});
  }

  const CaseDetailsScreen({super.key, this.id});

  @override
  State<CaseDetailsScreen> createState() => _CaseDetailsScreenState();
}

class _CaseDetailsScreenState extends State<CaseDetailsScreen> {
  // Example dynamic image list (replace with your data source)
  final List<String> evidenceImagePaths = [
    'assets/images/img1.png',
    'assets/images/img1.png',
    'assets/images/img1.png',
    'assets/images/img1.png',
    'assets/images/img1.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Case Summary",),
      body: _screenContent(),
    );
  }
  // -----------------------------------------------------------------------------
  // Widget Methods
  // -----------------------------------------------------------------------------

  Widget _screenContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Case Id: SYD2013095265',
            style: context.bodyMedium.copyWith(color: AppColors.blackColor,
              fontSize: 15, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 20,),
          _caseNameWidget(),
          const SizedBox(height: 39,),
          _plateNumberWidget(),
          const SizedBox(height: 30,),
          _evidenceWidget(evidenceImagePaths),
          const SizedBox(height: 10,),
          _evidenceVideoWidget(),
          const SizedBox(height: 25,),
          _caseDescriptionWidget(),
          const SizedBox(height: 20,),
          AccidentDetailsWidget(
            isAccidentTitle: false,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Divider(
            color: AppColors.blackColor.withValues(alpha: .2),
          ),
        ),
        const SizedBox(height: 30,),
        _paymentStatusWidget(),
        const SizedBox(height: 22,),
        AppElevatedButton.withTitleAndIcon(
          width: double.infinity,
          icon: Icon(Icons.check, color: AppColors.accentColor,),
           title: "Close Accident Case", onPressed: (){},)
        ],
      ),
    );
  }

  
Widget _caseNameWidget() {
  return Container(
    padding: EdgeInsets.all(6),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: AppColors.lightGrayColor)
    ),
    child: Row(
      children: [
        Image.asset(AppAssetPaths.circlePersonIcon, width: 24, height: 24,),
        const Spacer(),
        Text("Samuel Oaks", style: context.bodyMedium.copyWith(
          fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.blackColor
        ),),
        const Spacer()

      ],
    ),
  );
}

Widget _plateNumberWidget() {
  return Container(
                height: 55,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  border: Border.all(color: AppColors.blackColor),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 20,
                      color: AppColors.blackColor.withValues(alpha: .2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 3),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssetPaths.roundStrokeIcon),
                          const SizedBox(height: 5),
                          Text(
                            "D",
                            style: context.bodyMedium.copyWith(
                              fontSize: 10,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                       'SE-SB 1992',
                      style: context.titleMedium.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: AppColors.blackColor,
                      ),
                    ),
                  ],
                ),
              );
}

Widget _evidenceWidget(List<String> imagePaths) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Evidence Images", style: context.bodyMedium.copyWith(
        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.blackColor
      ),),
      const SizedBox(height: 10,),
      GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imagePaths[index],
            fit: BoxFit.cover,
          ),
        );
      },
    )
    ],
  );
}

Widget _evidenceVideoWidget() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Evidence Videos", style: context.bodyMedium.copyWith(
        fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.blackColor
      ),),
      const SizedBox(height: 10,),
      Image.asset("assets/images/Mask group.png")
    ],
  );
}

Widget _caseDescriptionWidget() {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Color(0xffEEF4FF),
          borderRadius: BorderRadius.circular(12)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Case Description', style: context.bodyMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.blackColor
            ),),
            const SizedBox(height: 12,),
            Text("Vehicle was stationary at a red light when a secondary vehicle failed to brake, causing a low-speed rear-end collision. Visibility was clear with dry road conditions.",
            style: context.bodyMedium.copyWith(
              fontSize: 16, fontWeight: FontWeight.w400, color: Color(0xff434654)
            ),
            ),
          ],
        ),
      )
    ],
  );
}

Widget _paymentStatusWidget() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100),
      color: Color(0xff00544C).withValues(alpha: .1),
    ),
    padding: EdgeInsets.symmetric(vertical: 19),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center ,
      children: [
        Image.asset(AppAssetPaths.checkIcon),
        const SizedBox(width: 6,),
        Text("PAYMENT STATUS: PAID", style: context.bodyMedium.copyWith(
          fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xff00544C)
        ),)
      ],
    ),
  );
}

}