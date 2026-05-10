import 'package:crashid/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:crashid/features/widgets/app_textfield/app_textform_filled_widget.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:crashid/utils/validators/app_validation.dart';
import 'package:crashid/utils/validators/validator.dart';
import 'package:flutter/material.dart';

class SosWidget extends StatefulWidget {
  final Function(String? val)? onClickSend;
  const SosWidget({super.key, this.onClickSend});

  @override
  State<SosWidget> createState() => _SosWidgetState();
}

class _SosWidgetState extends State<SosWidget> with AppValidation {

final controller = TextEditingController();
final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(12),
      child: Padding( 
        padding: const EdgeInsets.only(top: 15, bottom: 40, right: 15 ,left: 15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.close)),),
              const SizedBox(height: 35,),
              AppTextFormField(
                maxLines: 3,
                borderRadius: 1,
                controller: controller,
                hintText: "Write a message or just send",
                inputFormatters: [
                  Validator.removeLeadingWhiteSpace(),
                ],
                validator: validateEmpty,
              ),
              const SizedBox(height: 23,),
              AppElevatedButton.withTitle(title: "Send", onPressed: _onValidation,)
            ],
          ),
        ),
      ),
    );
  }

  void _onValidation() {
    if (formKey.currentState!.validate()) {
      widget.onClickSend?.call(controller.text);
    }
  }
}