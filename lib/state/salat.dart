import 'package:flutter/material.dart';
import 'package:neda/modele/salat.dart';

class SalatTimesProvider extends ChangeNotifier {
  Salat? _salatTimes;

  Salat? get salatTimes => _salatTimes;

  void setSalatTimes(Salat? times) {
    _salatTimes = times;
    notifyListeners();
  }
}
