extension ConcatenateAsterisk on String {
  String get concatenateAsterisk {
    return "$this *";
  }
}

extension ConcatenateColumn on String {
  String get concatenateColumn {
    return "$this:";
  }
}

extension ConcatenateExclamation on String {
  String get concatenateExclamation {
    return "$this!";
  }
}

extension ConcatenateComma on String {
  String get concatenateComma {
    return "$this,";
  }
}


extension ConcatenateDash on String {
  String get concatenateDash {
    return "$this-";
  }
}

extension ConcatenatePercentage on String {
  String get concatenatePercentage {
    return "$this%";
  }
}

extension ConcatenateSpace on String {
  String get concatenateSpace {
    return "$this ";
  }
}

extension ConcatenateNewLine on String {
  String get concatenateNewline {
    return "$this\n";
  }
}

extension ConcatenateBrackets on String {
  String get concatenateBrackets {
    return "($this)";
  }
}

extension ConcatenateQuestionMarkEnglish on String {
  String get concatenateQuestionMarkEnglish {
    return "$this?";
  }
}

extension ConcatenateDollarSign on String {
  String get concatenateDollarSign {
    return "\$$this";
  }
}

extension ConcatenateHash on String {
  String get concatenateHash {
    return "#$this";
  }
}

extension ConcatenateQuestionMarkArabic on String {
  String get concatenateQuestionMarkArabic {
    return "$this؟";
  }
}

extension Validation on String? {
  bool get isNullOrEmpty =>
      (this != null && this!.trim().isNotEmpty) ? false : true;

  bool get isNotNullOrNotEmpty =>
      (this != null && this!.trim().isNotEmpty) ? true : false;
}

extension StringConversion on String? {
  double get convertStringToDouble {
    if (this == null) return 0;
    return double.tryParse(this!) ?? 0.0;
  }

  int get convertStringToInt {
    if (this == null || this!.isEmpty) return 0;
    double? result = double.tryParse(this!);
    return result?.toInt() ?? 0;
  }
}

extension StringExtension on String {
  String get capitalize {
    return this.isEmpty ? '' : "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

enum MediaType {
  image,
  video,
  unknown,
}

extension MediaStringExtension on String {
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png'];
  static const List<String> videoExtensions = ['mp4'];

  MediaType getMediaType() {
    String extension = split('.').last.toLowerCase();
    if (imageExtensions.contains(extension)) {
      return MediaType.image;
    } else if (videoExtensions.contains(extension)) {
      return MediaType.video;
    }
    return MediaType.unknown;
  }

  bool isImage() {
    return getMediaType() == MediaType.image;
  }

  bool isVideo() {
    return getMediaType() == MediaType.video;
  }
}
