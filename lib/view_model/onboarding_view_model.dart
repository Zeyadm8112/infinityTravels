import 'package:flutter/cupertino.dart';

class OnBoardingViewModel extends ChangeNotifier{
    int currentIndex=0 ;

    changeScreenIndex(int value){
      currentIndex=value;
      notifyListeners();

    }





}