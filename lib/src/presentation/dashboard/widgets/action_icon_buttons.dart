import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/sizes/paddings.dart';

class ActionIconButton extends StatelessWidget {
  const ActionIconButton({
    super.key,
    this.iconData,
    required this.onTap,
    this.border,
    this.color,
    this.iconColor,
  });

  final IconData? iconData;
  final VoidCallback onTap;
  final BoxBorder? border;
  final Color? color;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: Paddings.p8,
          decoration: BoxDecoration(
            color: color ?? Colors.white,
            border: border,
            borderRadius: BorderRadius.circular(6.r),
          ),
          child: Icon(
            iconData ?? Icons.chevron_left,
            color: iconColor ?? Colors.black,
            size: 18.w,
          ),
        ),
      ),
    );
  }
}
