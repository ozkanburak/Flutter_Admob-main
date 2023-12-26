import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService{
  static String? get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/2934735716';
    }else{
      return null;
    }
  }
  static String? get interstitialAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/1033173712';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/4411468910';
    }else{
      return null;
    }
  }
  static String? get rewardedAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/5224354917';
    }else if(Platform.isIOS){
      return 'ca-app-pub-3940256099942544/1712485313';
    }else{
      return null;
    }
  }
  static final BannerAdListener bannerAdListener=BannerAdListener(
    onAdLoaded: (ad)=>debugPrint('adloaded'),
    onAdFailedToLoad: (ad,error){
      ad.dispose();
      debugPrint("ad load fail $error");
    },
    onAdOpened: (ad)=>debugPrint("ad open"),
    onAdClosed: (ad)=>debugPrint("ad close"),
  );
}