import 'package:flutter/material.dart';

class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  final Size size;

  MySliverPersistentHeaderDelegate({this.child, this.size});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: child,
      width: size.width,
      height: size.height,
    );
  }

  @override
  double get maxExtent => size.height;

  @override
  double get minExtent => size.height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return this != oldDelegate;
  }
}
