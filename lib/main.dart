import 'package:flutter/material.dart';
import 'package:appodeal_flutter/appodeal_flutter.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // if you have any problem, please watch the video.
  Appodeal.setAppKeys(
      androidAppKey: 'YOUR APPODEAL APP ID');
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initialize() async {
    await Appodeal.initialize(
        hasConsent: true,
        adTypes: [AdType.BANNER, AdType.INTERSTITIAL, AdType.REWARD],
        testMode: true);

    Appodeal.setBannerCallback((event) {
      if (event == 'onBannerShown') {
        print('banner shown');
      }
    });

    Appodeal.setInterstitialCallback((event) {
      if (event == 'onInterstitialShown') {
        print('intersitial ad called');
      }
    });

        Appodeal.setRewardCallback((event) {
      if (event == 'onRewardedVideoFinished') {
        print('onRewardedVideoFinished ad called');
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () => showBanner(), child: Text('Show Bnner')),
            TextButton(
                onPressed: () => showInter(), child: Text('Show Inters')),
            TextButton(
                onPressed: () => showReward(), child: Text('Show Reward'))
          ],
        ),
      ),
    );
  }

  showBanner() async {
    var isready = await Appodeal.isReadyForShow(AdType.BANNER);
    if (!isready) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('banner ads not ready')));
      return;
    } else {
      await Appodeal.show(AdType.BANNER, placementName: 'banner1');
    }
  }

  showInter() async {
    var isready = await Appodeal.isReadyForShow(AdType.INTERSTITIAL);
    if (!isready) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('inters ads not ready')));
      return;
    } else {
      await Appodeal.show(AdType.INTERSTITIAL, placementName: 'Inter1');
    }
  }

  showReward() async {
    var isready = await Appodeal.isReadyForShow(AdType.REWARD);
    if (!isready) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Rewarded ads not ready')));
      return;
    } else {
      await Appodeal.show(AdType.REWARD, placementName: 'reward1');
    }
  }
}
