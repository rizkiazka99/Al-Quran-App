import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController scrollController;
  final Duration duration;
  final EdgeInsetsGeometry margin;
  final double height;

  const ScrollToHideWidget({
    Key? key, 
    required this.child, 
    required this.scrollController, 
    this.duration = const Duration(milliseconds: 200),
    this.margin = const EdgeInsets.all(0), 
    this.height = kBottomNavigationBarHeight
  }) : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(listen);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(listen);

    super.dispose();
  }

  void listen() {
    final direction = widget.scrollController.position.userScrollDirection;

    if(direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if(!isVisible) {
      setState(() {
        isVisible = true;
      });
    }
  }

  void hide() {
     if(isVisible) {
      setState(() {
        isVisible = false;
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: widget.margin,
      height: isVisible ? widget.height : 0,
      duration: widget.duration,
      child: Wrap(
        children: [
          widget.child
        ]
      ),
    );
  }
}