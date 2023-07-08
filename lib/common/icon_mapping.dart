import 'package:flutter/material.dart';

class IconMapping {
  static Map<String, IconData> iconMapping = {
    'work': Icons.work,
    'business': Icons.business,
    'hobby': Icons.draw,
    'person': Icons.person,
    'other': Icons.check_box_outline_blank_sharp,
    'common': Icons.commit_outlined,
  };

  static const String work = 'work';
  static const String business = 'business';
  static const String hobby = 'hobby';
  static const String person = 'person';
  static const String other = 'other';
  static const String common = 'common';

  static List icons = [work, business, hobby, person, other, common];
}
