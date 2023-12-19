import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension StringExt on String? {
  bool isMobileNumberValid() {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (this?.isEmpty == true) {
      return false;
    } else if (regExp.hasMatch(this ?? '')) {
      return true;
    }

    return false;
  }

  bool get isNumeric => num.tryParse(this ?? "") != null;

  num? get toNumeric => num.tryParse(this ?? "");

  int? get toInt => int.tryParse(this ?? "");

  String? get numberExtracted {
    if (this == null) return null;

    String value = this!.trim();
    var splittedDot = value.split('.');
    if (splittedDot.length > 2) {
      value = "${splittedDot[0]}.${(splittedDot..removeAt(0)).join("")}";
    }

    return value.replaceAll(RegExp(r'[^0-9.]'), "");
  }

  // String get moneyFormat {
  //   const defaultReturnValue = "0.00";
  //   // if this null or empty => return defaultReturnValue
  //   if (this == null || this?.isEmpty == true) return defaultReturnValue;

  //   // if this is not numeric => return defaultReturnValue
  //   // if (!isNumeric) return defaultReturnValue;

  //   // unwrap this value
  //   final strValue = this?.trim() ?? "0";

  //   // validate numValue, for case NaN, Infinity, null
  //   final strNumberExtracted = strValue.numberExtracted ?? "";
  //   if (strNumberExtracted.isEmpty) return defaultReturnValue;

  //   //check is negative
  //   bool isNegative = strValue[0] == '-';

  //   // get number value from this
  //   final numValue = strNumberExtracted.toNumeric ?? 0;

  //   // get decimal of number
  //   String decimalStr = "";
  //   final splittedStrValue = strNumberExtracted.split(".");
  //   if (splittedStrValue.length == 2) {
  //     decimalStr = splittedStrValue[1];
  //   }

  //   // get format decimal
  //   final formatDecimal =
  //       decimalStr.isEmpty ? "" : ".${"#" * decimalStr.length}";

  //   String result =
  //       NumberFormat("#,###$formatDecimal", "en_US").format(numValue);

  //   if (numValue == 0) {
  //     result = "0.00";
  //   }

  //   return isNegative ? "-$result" : result;
  // }

  String get moneyFormatNomal {
    const defaultReturnValue = "0";
    // if this null or empty => return defaultReturnValue
    if (this == null || this?.isEmpty == true) return defaultReturnValue;

    // if this is not numeric => return defaultReturnValue
    // if (!isNumeric) return defaultReturnValue;

    // unwrap this value
    final strValue = this?.trim() ?? "0";

    // validate numValue, for case NaN, Infinity, null
    final strNumberExtracted = strValue.numberExtracted ?? "";
    if (strNumberExtracted.isEmpty) return defaultReturnValue;

    //check is negative
    bool isNegative = strValue[0] == '-';

    // get number value from this
    final numValue = strNumberExtracted.toNumeric ?? 0;

    // get decimal of number
    String decimalStr = "";
    final splittedStrValue = strNumberExtracted.split(".");
    if (splittedStrValue.length == 2) {
      decimalStr = splittedStrValue[1];
    }

    // get format decimal
    final formatDecimal =
        decimalStr.isEmpty ? "" : ".${"#" * decimalStr.length}";

    String result =
        NumberFormat("#,###$formatDecimal", "en_US").format(numValue);

    return isNegative ? "-$result" : result;
  }

  String get moneyFormat {
    const defaultReturnValue = "0.00";
    // if this null or empty => return defaultReturnValue
    if (this == null || this?.isEmpty == true) return defaultReturnValue;

    // if this is not numeric => return defaultReturnValue
    // if (!isNumeric) return defaultReturnValue;

    // unwrap this value
    final strValue = this?.trim() ?? "0";

    // validate numValue, for case NaN, Infinity, null
    final strNumberExtracted = strValue.numberExtracted ?? "";
    if (strNumberExtracted.isEmpty) return defaultReturnValue;

    //check is negative
    bool isNegative = strValue[0] == '-';

    // get number value from this
    final numValue = strNumberExtracted.toNumeric ?? 0;

    // get format decimal
    final formatDecimal = "0.${"0" * 2}";

    String result =
        NumberFormat("#,##$formatDecimal", "en_US").format(numValue);

    if (numValue == 0) {
      result = "0.00";
    }

    return isNegative ? "-$result" : result;
  }

  String get moneyFormatTwoDecimal {
    const defaultReturnValue = "0.00";
    // if this null or empty => return defaultReturnValue
    if (this == null || this?.isEmpty == true) return defaultReturnValue;

    // if this is not numeric => return defaultReturnValue
    // if (!isNumeric) return defaultReturnValue;

    // unwrap this value
    final strValue = this?.trim() ?? "0";

    // validate numValue, for case NaN, Infinity, null
    final strNumberExtracted = strValue.numberExtracted ?? "";
    if (strNumberExtracted.isEmpty) return defaultReturnValue;

    //check is negative
    bool isNegative = strValue[0] == '-';

    // get number value from this
    final numValue = strNumberExtracted.toNumeric ?? 0;

    // get format decimal
    final formatDecimal = "0.${"0" * 2}";

    String result =
        NumberFormat("#,##$formatDecimal", "en_US").format(numValue);

    if (numValue == 0) {
      result = "0.00";
    }

    return isNegative ? "-$result" : result;
  }

  String get moneyFormatOneId {
    return moneyFormat.contains("-")
        ? "(${moneyFormat.replaceAll("-", "")})"
        : moneyFormat;
  }

  String get debitPossitiveShape {
    final temp = (num.tryParse(this ?? "0") ?? 0).toInt();

    if (temp > 0) return "0";

    return temp.abs().toString();
  }

  String? get keepOnlyAsciiReadable {
    if (this == null) return this;

    String result = "";
    for (final charInAscii in this!.runes) {
      if (charInAscii > 31 && charInAscii < 127) {
        result += String.fromCharCode(charInAscii);
      }
    }

    return result;
  }

  String? get camelCaseToLowerUnderscore {
    if (this == null) return this;
    if (this!.isEmpty) return this;

    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');
    try {
      return this!
          .replaceAllMapped(exp, (Match m) => ('_${m.group(0)}'))
          .toLowerCase();
    } catch (e) {
      return this;
    }
  }

  String? get upperUnderscoreToSentence {
    if (this == null) return this;
    if (this!.isEmpty) return this;

    var arr = this?.split("_").join(" ").split("");
    var newArr = [];
    bool skipNext = false;
    for (int index = 0; index < (arr?.length ?? 0); index++) {
      final item = arr?[index];
      if (index == 0) {
        newArr.add(arr?[0].toUpperCase());
      } else if (!skipNext) {
        newArr.add(arr?[index].toLowerCase());
      }
      if (item == " ") {
        newArr.add(arr?[index + 1].toUpperCase());
        skipNext = true;
      } else {
        skipNext = false;
      }
    }

    return newArr.join();
  }

  String? get cardFormatHide {
    if ((this?.length ?? 0) <= 10) return this;
    var inputText = this;
    if (inputText?.isEmpty == true) return "";

    inputText = (inputText?.substring(0, 6) ?? "") +
        List.generate((inputText?.length ?? 10) - 10, (index) => "X").join() +
        (inputText?.substring((inputText.length) - 4) ?? "");

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();

    return string;
  }

  String? get cardFormatFull {
    var inputText = this;
    if (inputText == null || inputText.isEmpty) return "";

    var bufferString = StringBuffer();
    for (int i = 0; i < inputText.length; i++) {
      bufferString.write(inputText[i]);
      var nonZeroIndexValue = i + 1;
      if (nonZeroIndexValue % 4 == 0 && nonZeroIndexValue != inputText.length) {
        bufferString.write(' ');
      }
    }

    var string = bufferString.toString();

    return string;
  }

  String? get parseCardNumber {
    var inputText = this;

    return inputText?.replaceAll(" ", "");
  }

  String? get capitalizeFirstofEach {
    if (this == null) return this;

    return this!
        .replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map(
          (str) => str.isNotEmpty
              ? '${str[0].toUpperCase()}${str.substring(1)}'
              : '',
        )
        .join(" ");
  }

  String get maskedString {
    if (this == null || this?.isEmpty == true) return "";
    final String firstLetter = this!.substring(0, 1);
    final String lastLetter = this!.substring(this!.length - 1);
    final String middlePart = "*" * (this!.length - 2);
    return firstLetter + middlePart + lastLetter;
  }

  String get card4Number {
    if (this == null || this?.isEmpty == true) return "";

    return "**** ${this?.substring((this?.length ?? 4) - 4, this?.length)}";
  }

  String get card4NumberWithType {
    if (this == null || this?.isEmpty == true) return "";
    final String name = this!.split(" ").first;

    return "$name | **** ${this?.substring(max((this?.length ?? 4) - 4, 0), this?.length)}";
  }

  String get card4NumberWithTypeExtended {
    try {
      if (this == null || this?.isEmpty == true) return "";
      final String name = this!.split(" ").first;

      final String cardNumber =
          this!.split(" ").last.replaceAll('X', '*').replaceAll('x', '*');

      return "$name | ${cardNumber.substring(0, 4)} ${cardNumber.substring(4, 6)}**** "
          "${this?.substring(max((this?.length ?? 4) - 4, 0), this?.length)}";
    } catch (_) {
      return card4NumberWithType;
    }
  }

  bool get isNullOrEmptyString {
    if (this == null) return true;
    if (this == '') return true;

    return false;
  }

  String get fromYMDtoDMYFormat {
    if (isNullOrEmptyString || this!.length < 8) return "";

    return "${this!.substring(6, 8)}/${this!.substring(4, 6)}/${this!.substring(0, 4)}";
  }

  String get toCapitalized {
    if (this == null || this?.isEmpty == true) return "";

    return this!.isNotEmpty
        ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
        : '';
  }

  String get toTitleCase {
    if (this == null || this?.isEmpty == true) return "";

    return this!.isNotEmpty
        ? this!
            .split(" ")
            .map((str) => str[0].toUpperCase() + str.substring(1))
            .join(" ")
        : '';
  }

  String get toCamelizedFirst {
    if (this == null || this?.isEmpty == true) return "";

    return this!.isNotEmpty
        ? '${this![0].toLowerCase()}${this!.substring(1)}'
        : '';
  }

  String get moneyShortcutVnd {
    if (this == null || this?.isEmpty == true) return '';

    int value = this!.trim().toInt ?? 0;

    return value / 1000000 < 1000
        ? "${(value / 1000000).round().toString()} triệu"
        : "${(value / 1000000000).round().toString()} tỷ";
  }

  String get hiddenMoney {
    return this?.split("").map((e) => e != "," ? "*" : " ").join() ?? "*";
  }
}

extension StringPhoneX on String? {
  bool isPhoneNumber() {
    if (this == null) return false;
    if (this!.length != 10) return false;
    for (String headString in phoneNumberPrefix) {
      if (this!.startsWith(headString)) return true;
    }

    return false;
  }

  static List<String> phoneNumberPrefix = [
    '032', '033', '034', '035', '036', '037', '038', '039', '096', '097', '098',
    '086', //viettel
    '081', '082', '083', '084', '085', '088', '091', '094', //vinaphone
    '090', '093', '089', '070', '076', '077', '078', '079', //mobiphone
    '092', '056', '058', // VN mobile
    '099', '059', //Gmobile
    '055', //reddi
    '087', '055', '052',
  ];
}

String yMdDateParser(String? yyyyMMddInput, String? splitString) {
  if (yyyyMMddInput == null ||
      splitString == null ||
      yyyyMMddInput.length != 8) {
    return "-";
  }
  final String year = yyyyMMddInput.substring(0, 4);
  final String month = yyyyMMddInput.substring(4, 6);
  final String day = yyyyMMddInput.substring(6, 8);

  return "$day$splitString$month$splitString$year";
}

String roundBalanceWithCurrency(double balance, String? currency) {
  return currency == null || currency == ""
      ? balance.toStringAsFixed(0)
      : balance.toString();
}

// validate password 1 uppercase letter, 1 special characters, 1 number
Map<String, int> checkPasswordValid(String password) {
  // Define regular expressions for uppercase letter, special character, and number
  final lowercaseRegex = RegExp(r'[a-z]');
  final uppercaseRegex = RegExp(r'[A-Z]');
  final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":;{}|<>\-+=]');
  final numberRegex = RegExp(r'[0-9]');

  // Check if the password contains at least one uppercase letter, special character, and number
  int lowercaseCount = lowercaseRegex.allMatches(password).length;
  int uppercaseCount = uppercaseRegex.allMatches(password).length;
  int specialCharCount = specialCharRegex.allMatches(password).length;
  int numberCount = numberRegex.allMatches(password).length;

  return {
    'lowercaseCount': lowercaseCount,
    'uppercaseCount': uppercaseCount,
    'specialCharCount': specialCharCount,
    'numberCount': numberCount,
  };
}

extension CardStringExtension on String {
  String get parseValidThrough {
    if (length < 4) {
      return this;
    }

    String year = substring(0, 2);
    String month = substring(2, 4);

    return "$month/$year";
  }
}

String trimSpaceText(String value, TextEditingController controller) {
  String newValue = value.replaceAll(' ', '');
  if (newValue != value) {
    controller.value = controller.value.copyWith(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }
  return controller.text;
}
