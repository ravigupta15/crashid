class AddressFormatter {
  static String formatBusinessAddress({
    String? address,
    String? street,
    String? houseNumber,
    String? postalCode,
    String? city,
  }) {
    final parts = <String>[
      if (address?.isNotEmpty ?? false) address ?? '',
      if (street?.isNotEmpty ?? false) street ?? '',
      if (houseNumber?.isNotEmpty ?? false) houseNumber ?? '',
      if (postalCode?.isNotEmpty ?? false) postalCode ?? '',
      if (city?.isNotEmpty ?? false) city ?? '',
    ];
    
    return parts.join(', ');
  }

  static String formatBillingAddress({
    String? address,
    String? street,
    String? houseNumber,
    String? postalCode,
    String? city,
  }) {
    return formatBusinessAddress(
      address: address,
      street: street,
      houseNumber: houseNumber,
      postalCode: postalCode,
      city: city,
    );
  }

  /// Formats any address parts into a single full address string
  static String format({
    required List<String?> addressParts,
  }) {
    return addressParts
        .where((part) => part?.isNotEmpty ?? false)
        .cast<String>()
        .join(', ');
  }
}
