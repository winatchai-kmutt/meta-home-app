// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:meta_home_ai/model.dart';

class CustomSwitch extends StatefulWidget {
  final bool isOn;
  final ValueChanged<bool> onChanged;
  final Color? thumbColor;
  final Color? inactiveTrackColor;
  final Color? activeTrackColor;

  const CustomSwitch({
    super.key,
    required this.isOn,
    required this.onChanged,
    this.thumbColor,
    this.inactiveTrackColor,
    this.activeTrackColor,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  late bool _isOn;

  @override
  void initState() {
    super.initState();
    _isOn = widget.isOn;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: _isOn,
      onChanged: (isChanged) {
        widget.onChanged(isChanged);
        setState(() {
          _isOn = isChanged;
        });
      },
      thumbColor: widget.thumbColor ?? Colors.white,
      inactiveThumbColor: widget.thumbColor ?? Colors.white,
      activeTrackColor: widget.activeTrackColor ?? primaryColor,
      inactiveTrackColor:
          widget.inactiveTrackColor ?? Colors.white.withValues(alpha: 0.1),
    );
  }
}
