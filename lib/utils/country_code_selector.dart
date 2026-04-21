import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

mixin CountryPickerMixin<T extends StatefulWidget> on State<T> {
  Country? country;

  Future<void> initCountry({String phoneCode = ''}) async {
    country = CountryParser.parsePhoneCode(phoneCode);
    setState(() {});
  }

  Future<void> countryPicker() async {
    showCountryPicker(
        context: context,
        useSafeArea: true,
        countryListTheme: CountryListThemeData(
         inputDecoration: InputDecoration(
      hintText: 'Search',
      prefixIcon: const Icon(Icons.search),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: const Color(0xFF8C98A8).withValues(alpha:  0.2),
        ),
      ),
    ),
        ),
        onSelect: (country) {
          this.country = country;
          setState(() {});
        });
  }
}
