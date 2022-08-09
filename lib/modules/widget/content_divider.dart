import 'package:alquranapp/core/values/colors.dart';
import 'package:flutter/material.dart';

class ContentDivider extends StatelessWidget {
  const ContentDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dividerColorPrimary,
      height: 2,
      width: MediaQuery.of(context).size.width
    );
  }
}