import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class InputFormatterUtil {
  static List<MaskTextInputFormatter>? maskInput({String? mask, Map<String, RegExp>? filter}) => [
        MaskTextInputFormatter(
          mask: mask,
          filter: filter,
          type: MaskAutoCompletionType.eager,
        )
      ];

  static TextInputFormatter thousandsSeparatorInputSeparator = ThousandsSeparatorInputFormatter();
}

class ThousandsSeparatorInputFormatter implements TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Remove all non-numeric characters except the decimal point
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Check if there's more than one decimal point
    if (newText.indexOf('.') != newText.lastIndexOf('.')) {
      // If there's more than one decimal point, remove the last one
      newText = newText.substring(0, newText.lastIndexOf('.'));
    }

    // Split the text into integer and fractional parts
    List<String> parts = newText.split('.');

    // Format the integer part with commas for thousands separator
    if (parts[0].isNotEmpty) {
      parts[0] = NumberFormat("#,###").format(int.parse(parts[0]));
    }

    // Join the integer and fractional parts with a decimal point
    if (parts.length == 2) {
      newText = '${parts[0]}.${parts[1]}';
    } else {
      newText = parts[0];
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
