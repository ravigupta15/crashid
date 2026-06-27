import 'package:crashid/features/my_insurance/model/insurance_response_model.dart';
import 'package:crashid/features/widgets/app_textfield/custom_dropdown_widget.dart';

class AppDropdownItemWidget {
  static List<CustomDropDownItem> industryTypeList = [
    CustomDropDownItem(value: "Transportation", key: "Transportation"),
  ];



  static List<CustomDropDownItem> fuelTypes = const [
    CustomDropDownItem(key: "petrol", value: "Petrol"),
    CustomDropDownItem(key: "diesel", value: "Diesel"),
    CustomDropDownItem(key: "EV", value: "EV"),
    CustomDropDownItem(key: "Cng", value: "Cng"),
  ];

  static List<CustomDropDownItem> insuranceCompanies(
      List<InsuranceModel>? insuranceList) {
    return insuranceList
            ?.map((insurance) => CustomDropDownItem(
                  key: '${insurance.insuranceId}',
                  value: '${insurance.insuranceCompanyName ?? ''}',
                ))
            .toList() ??
        [];
  }

  // static List<CustomDropDownItem> operatorDropdown(List<Operators> list) {
  //   final List<CustomDropDownItem> menuItems = [];
  //   for (final item in list) {
  //     menuItems.add(CustomDropDownItem(value: item.name, key: item.serviceID));
  //   }
  //   return menuItems;
  // }

}
