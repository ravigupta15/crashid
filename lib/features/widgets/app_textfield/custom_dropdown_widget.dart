import 'package:crashid/core/theme/app_theme_extensions.dart';
import 'package:crashid/res/app_colors.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropDownItem {
  final String value;
  final String key;

  const CustomDropDownItem({
    required this.value,
    required this.key,
  });

  factory CustomDropDownItem.empale() {
    return CustomDropDownItem(
      key: "test",
      value: 'test',
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomDropDownItem &&
          runtimeType == other.runtimeType &&
          key == other.key;

  @override
  int get hashCode => key.hashCode;
}

// ignore: must_be_immutable
class CustomDropDownFormFiledWidget extends StatelessWidget {
  final List<CustomDropDownItem>? items;
  final String? hintText;
  final String? title;
  final bool showOptional;

  final Color? enableBorderColor;
  final ValueChanged<CustomDropDownItem?>? onChanged;
  final bool ignoring;
  CustomDropDownItem? initialValue;
  CustomDropDownItem? selectedValue;
  final bool withBorder;
  final FormFieldSetter<CustomDropDownItem>? onSaved;
  FormFieldValidator<CustomDropDownItem>? validator;
  final Color? iconColor;
  final Color? fillColor;
  final TextStyle? hintTextStyle;
  final TextStyle? itemTextStyle;

  final double? dropdownMaxHeight;
  final FocusNode? focusNode;
  final Widget? prefixIcon;
  final Widget? helperWidget; 
  final double? borderRadius;
  final Widget Function(CustomDropDownItem item)? selectedItemBuilder;

  CustomDropDownFormFiledWidget({
    super.key,
    this.items,
    this.title,
    this.itemTextStyle,
    this.enableBorderColor,
    this.ignoring = false,
    this.hintText,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.dropdownMaxHeight,
    this.initialValue,
    this.fillColor,
    this.withBorder = true,
    this.iconColor,
    this.focusNode,
    this.hintTextStyle,
    this.selectedValue,
    this.prefixIcon,
    this.helperWidget,
    this.selectedItemBuilder,
    this.showOptional = false,
    this.borderRadius
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField2<CustomDropDownItem>(
          decoration: InputDecoration(
            hintStyle: hintTextStyle ??
               context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
               ),
            isDense: true,
            fillColor: fillColor ?? AppColors.whiteColor,
            filled: true,
            contentPadding: EdgeInsetsDirectional.only(
                start: 1, end: 10, top: 15, bottom: 15),
            prefixIcon: prefixIcon == null
                ? null
                : Transform.translate(offset: Offset(9, 0), child: prefixIcon),
            prefixIconConstraints: BoxConstraints(
              minWidth: 25,
              maxWidth: 25,
            ),
            enabledBorder: textFormFieldEnabledBorder,
            disabledBorder: textFormFieldDisabledBorder,
            errorBorder: textFormFieldErrorBorder,
            focusedErrorBorder: textFormFieldFocusErrorBorder,
            focusedBorder: textFormFieldFocusBorder,
            border: const OutlineInputBorder(),
          ),
          focusNode: focusNode,
          isExpanded: true,
          hint: initialValue != null
              ? selectedItemBuilder?.call(initialValue!) ??
                  Text(
                    initialValue!.value,
                    style: context.titleMedium.copyWith(
                      fontSize: 15, fontWeight: FontWeight.w500
                    )
                  )
              : Text(
                  hintText ?? '',
                  style: hintTextStyle ??
                      context.bodyMedium.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.darkGrayColor.withValues(alpha: .6),
               ),
                ),
          buttonStyleData: ButtonStyleData(padding: EdgeInsets.zero),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            offset: const Offset(0, 0),
          ),
          iconStyleData: IconStyleData(
            icon: Icon(
              Icons.keyboard_arrow_down,
              size: 24,
              color: AppColors.blackColor,
            ),
          ),
          items: buildDropdownList(items),
          validator: validator,
          value: selectedValue ?? initialValue,
          onChanged: (value) {
            initialValue = value;
            if (onChanged != null) {
              onChanged!(value);
            }
          },
          onSaved: onSaved,
        ),
        if (helperWidget != null) ...[
          const SizedBox(height: 10),
          helperWidget!,
        ],
      ],
    );
  }

  List<DropdownMenuItem<CustomDropDownItem>>? buildDropdownList(
      List<CustomDropDownItem>? list) {
    return list == null || ignoring
        ? null
        : list.map((CustomDropDownItem item) {
            return DropdownMenuItem<CustomDropDownItem>(
              value: item,
              child: Text(item.value,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
            );
          }).toList();
  }

  OutlineInputBorder get textFormFieldErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??40),
        borderSide: const BorderSide(color: AppColors.redColor),
      );

  OutlineInputBorder get textFormFieldFocusBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        borderSide:  BorderSide(color: AppColors.primaryColor),
      );

  OutlineInputBorder get textFormFieldFocusErrorBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??40),
        borderSide: const BorderSide(color: AppColors.redColor),
      );

  OutlineInputBorder get textFormFieldEnabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ??40),
        borderSide: BorderSide(
          color: enableBorderColor ?? AppColors.lightGrayColor,
        ),
      );

  OutlineInputBorder get textFormFieldDisabledBorder => OutlineInputBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        borderSide: BorderSide(
          color: enableBorderColor ?? AppColors.lightGrayColor,
        ),
      );
}
