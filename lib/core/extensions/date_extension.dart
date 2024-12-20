//
// import 'package:intl/intl.dart';
// import 'package:zuberi/extensions/int_extension.dart';
//
import 'package:intl/intl.dart';

extension DateExtension on DateTime{

  format(String newPattern){
    return DateFormat(newPattern).format(this);
  }

  timeFormat(String newPattern){
    return DateFormat(newPattern).add_jm().format(this);
  }



}