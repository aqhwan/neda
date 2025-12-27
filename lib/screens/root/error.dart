import 'package:flutter/material.dart';
import 'package:neda/lib.dart';

Widget noDataFoundException(BuildContext context) => Center(
  widthFactor: 1,
  child: Text(
    "جاري تحديث البيانات , تآكد من الاتصال بالإنترنت",
    style: TextStyle(
      fontSize: FontSize.small,
      color: Theme.of(context).colorScheme.error,
    ),
    textAlign: TextAlign.center,
  ),
);
