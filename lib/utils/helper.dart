import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Helper {
  static List<DropdownMenuItem> getDropdownMenuItem(
    List<Map<String, dynamic>> items, {
    String valueKey = 'value',
    String labelKey = 'label',
    bool Function(Map<String, dynamic> obj)? filter,
  }) {
    var list = items;

    if (filter != null) {
      list = list.where(filter).toList();
    }

    return list
        .map<DropdownMenuItem<String>>(
          (e) => DropdownMenuItem(
            value: e[valueKey],
            child: Text(e[labelKey]),
          ),
        )
        .toList();
  }

  static Size get templateSize {
    var width = (1.sw - 300).abs();
    var height = 1.sh.abs();

    if (width < height) {
      height = width * 1600 / 1650;
    } else {
      width = height * 1650 / 1600;
    }

    return Size(width, height);
  }
}
