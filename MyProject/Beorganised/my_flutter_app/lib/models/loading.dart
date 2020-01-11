import 'package:flutter/material.dart';

class Loading extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
 
  Loading();
 
  void switchLoading(){
    _isLoading = !_isLoading;
    notifyListeners();
  }
}