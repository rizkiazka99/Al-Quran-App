import 'package:alquranapp/core/values/colors.dart';
import 'package:alquranapp/core/values/fonts.dart';
import 'package:flutter/material.dart';

class PrimaryButtonBottomNavigationBar extends StatelessWidget {
  final String title;
  final onPressed;

  const PrimaryButtonBottomNavigationBar({
    Key? key, 
    required this.title, 
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton.extended(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor:
              onPressed == null ? backgroundColorPrimary : Colors.green,
          label: Text(
            title,
            style: buttonMd(
                color: onPressed == null ? iconColorPrimary : Colors.white),
          ),
          onPressed: onPressed ?? () {},
        ),
      ),
    );
  }
}