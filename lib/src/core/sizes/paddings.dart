import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Paddings {

  Paddings._();

  static final EdgeInsets p2 = EdgeInsets.all(2.r);
  static final EdgeInsets p4 = EdgeInsets.all(4.r);
  static final EdgeInsets p6 = EdgeInsets.all(6.r);
  static final EdgeInsets p8 = EdgeInsets.all(8.r);
  static final EdgeInsets p12 = EdgeInsets.all(12.r);
  static final EdgeInsets p10 = EdgeInsets.all(10.r);
  static final EdgeInsets p16 = EdgeInsets.all(16.r);
  static final EdgeInsets p20 = EdgeInsets.all(20.r);
  static final EdgeInsets p24 = EdgeInsets.all(24.r);
  static final EdgeInsets p28 = EdgeInsets.all(28.r);
  static final EdgeInsets p30 = EdgeInsets.all(30.r);
  static final EdgeInsets p32 = EdgeInsets.all(32.r);
  static final EdgeInsets p36 = EdgeInsets.all(36.r);
  static final EdgeInsets p40 = EdgeInsets.all(40.r);
  static final EdgeInsets p44 = EdgeInsets.all(44.r);
  static final EdgeInsets p48 = EdgeInsets.all(48.r);
  static final EdgeInsets p52 = EdgeInsets.all(52.r);
  static final EdgeInsets p56 = EdgeInsets.all(56.r);
}

extension Symmetric on EdgeInsets {
  EdgeInsets get horizontally {
    return EdgeInsets.symmetric(horizontal: left);
  }

  EdgeInsets get vertically {
    return EdgeInsets.symmetric(vertical: top);
  }

  EdgeInsets get onlyLeft {
    return EdgeInsets.only(left: left);
  }

  EdgeInsets get onlyRight {
    return EdgeInsets.only(right: right);
  }

  EdgeInsets get onlyBottom {
    return EdgeInsets.only(bottom: bottom);
  }

  EdgeInsets get onlyTop {
    return EdgeInsets.only(top: top);
  }

  EdgeInsets get exceptTop {
    return EdgeInsets.only(
      bottom: bottom,
      left: left,
      right: right,
    );
  }

  EdgeInsets get exceptBottom {
    return EdgeInsets.only(
      top: top,
      left: left,
      right: right,
    );
  }
}
