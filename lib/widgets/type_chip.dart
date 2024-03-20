import 'package:flutter/material.dart';

import '../utils/string_utils.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(capitalize(type),style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
    );
  }
}
