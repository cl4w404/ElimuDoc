import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CustomBannerAd extends StatefulWidget {
  const CustomBannerAd({Key? key}) : super(key: key);

  @override
  State<CustomBannerAd> createState() => _CustomBannerAdState();
}

class _CustomBannerAdState extends State<CustomBannerAd> {
  BannerAd? bannerAd;
  bool isBannerAdLoaded = false;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    bannerAd = BannerAd(
      size: AdSize.banner,
      //banner id
      //adUnitId: "ca-app-pub-7995558881059154/2797695055",
      adUnitId: "ca-app-pub-7995558881059154/5408185835",
      listener: BannerAdListener(onAdFailedToLoad: (ad, error) {
        print("Ad Failed to Load");
        ad.dispose();
      }, onAdLoaded: (ad) {
        print("Ad Loaded");
        setState(() {
          isBannerAdLoaded = true;
        });
      }),
      request: const AdRequest(),
    );
    bannerAd!.load();
  }

  @override
  Widget build(BuildContext context) {
    return isBannerAdLoaded
        ? SizedBox(
      width: double.infinity,
      height: 50,
      child: AdWidget(
        ad: bannerAd!,
      ),
    )
        : SizedBox();
  }
}