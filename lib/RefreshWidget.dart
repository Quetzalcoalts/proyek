import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final AsyncSnapshot onRefresh;
  const RefreshWidget({Key? key, required this.child, required this.onRefresh})
      : super(key: key);

  @override
  State<RefreshWidget> createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: widget.child, onRefresh: widget.onRefresh.data);
  }
}
