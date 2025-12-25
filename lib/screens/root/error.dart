import 'package:flutter/material.dart';
import 'package:neda/lib.dart';

Widget noDataFoundException(BuildContext context) => Center(
  widthFactor: 1,
  child: Text(
    "أسفاً لا بيانات هنا - حاول الاتصال بالانترنت لتحديث البيانات",
    style: TextStyle(
      fontSize: FontSize.small,
      color: Theme.of(context).colorScheme.error,
    ),
    textAlign: TextAlign.center,
  ),
);
