import 'package:addgenerator/ad.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Admob App',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
  

}

class _MyHomePageState extends State<MyHomePage> {
  BannerAd? bannerAd;
  InterstitialAd? interstitialad;
  RewardedAd? rewardedAd;
  int reward=0;
  @override
  void initState(){
    super.initState();
    createbanner();
    createinterstitialad();
    createrewardad();
  }
  void createbanner(){
    bannerAd=BannerAd(size: AdSize.fullBanner,
        adUnitId: AdMobService.bannerAdUnitId!,
        listener: AdMobService.bannerAdListener,
        request: AdRequest())..load();
  }
  void createinterstitialad(){
    InterstitialAd.load(adUnitId: AdMobService.interstitialAdUnitId!, request:AdRequest() , adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad)=>interstitialad=ad,
        onAdFailedToLoad: (LoadAdError)=>interstitialad=null));
  }
  void showinterstitialad(){
    if(interstitialad!=null){
      interstitialad!.fullScreenContentCallback=FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          createinterstitialad();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          createinterstitialad();

      }
      );
      interstitialad!.show();
      interstitialad=null;
    }
  }
  void createrewardad(){
    RewardedAd.load(adUnitId: AdMobService.rewardedAdUnitId!,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad)=>setState(()=>rewardedAd=ad),
            onAdFailedToLoad: (ad)=>setState(()=>rewardedAd=null)));
  }
  void showreward(){
    if(rewardedAd!=null){
      rewardedAd!.fullScreenContentCallback=FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad){
          ad.dispose();
          createrewardad();
        },
        onAdFailedToShowFullScreenContent: (ad,error){
          ad.dispose();
          createrewardad();

      }
      );
rewardedAd!.show(onUserEarnedReward: (ad,rewardad)=>setState(()=>reward++));
rewardedAd=null;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("reward ${reward}"),
            ElevatedButton(onPressed: showinterstitialad, child: Text("InterstialAd")),
            ElevatedButton(onPressed: showreward, child: Text("RewardAd")),
          ])),
      bottomNavigationBar: bannerAd==null?Container():Container(
        margin: EdgeInsets.only(bottom: 14),
        height: 52,
        child:AdWidget(ad: bannerAd!),
      ),
    );
  }
}
