//
//  CJChuanShanJia.m
//  youzhekou
//
//  Created by 陈俊 on 2019/10/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import "CJChuanShanJia.h"

@implementation CJChuanShanJia
RCT_EXPORT_MODULE();
RCT_EXPORT_METHOD(init:(NSDictionary *) config){
  [BUAdSDKManager setLoglevel:(BUAdSDKLogLevelDebug)];
  [BUAdSDKManager setAppID:[config objectForKey:@"appId"]];
  self.splashId = [config objectForKey:@"splashId"];
  self.interstitialId = [config objectForKey:@"interstitialId"];
  
  if(self.interstitialId) {
    self.interstitialAd = [[BUNativeExpressInterstitialAd alloc] initWithSlotID:self.interstitialId imgSize:[BUSize sizeBy:BUProposalSize_Interstitial600_600] adSize:CGSizeMake(300, 450)];
    self.interstitialAd.delegate = self;
    [self.interstitialAd loadAdData];
  }
}

//开屏广告部分...
RCT_REMAP_METHOD(showSplash,
                 showSplashWithResolver:(RCTPromiseResolveBlock)resolve
                 rejecter:(RCTPromiseRejectBlock)reject) {
  self.splashResolve = resolve;
  self.splashReject = reject;
  if(!self.splashId) {
    return reject(@"400", @"没有splashId无法显示", nil);
  }
  dispatch_async(dispatch_get_main_queue(), ^{
    CGRect frame = [UIScreen mainScreen].bounds;
    BUSplashAdView *splashView = [[BUSplashAdView alloc] initWithSlotID:self.splashId frame:frame];
    splashView.backgroundColor = [UIColor clearColor];
    splashView.delegate = self;
    UIWindow *keyWindow = [UIApplication sharedApplication].windows.firstObject;
    [splashView loadAdData];
    [keyWindow.rootViewController.view addSubview:splashView];
    splashView.rootViewController = keyWindow.rootViewController;
  });
}
- (void)splashAdDidLoad:(BUSplashAdView *)splashAd {}
- (void)splashAd:(BUSplashAdView *)splashAd didFailWithError:(NSError * _Nullable)error {
  //[splashAd removeFromSuperview];
  self.isFail = true;
}
- (void)splashAdWillVisible:(BUSplashAdView *)splashAd {}
- (void)splashAdDidClick:(BUSplashAdView *)splashAd {}
- (void)splashAdDidClose:(BUSplashAdView *)splashAd {
  [UIView animateWithDuration:0.2
                   animations:^{splashAd.alpha = 0.0;}
                   completion:^(BOOL finished){
                     [splashAd removeFromSuperview];
                     if(self.isFail) {
                       self.splashReject(@"400", @"开屏广告拉取失败", nil);
                     } else {
                       self.splashResolve(nil);
                     }
                   }];
}
- (void)splashAdWillClose:(BUSplashAdView *)splashAd {}

//插屏广告部分
RCT_REMAP_METHOD(showInt,
                 showIntWithResolver:(RCTPromiseResolveBlock)resolve
                 showIntWithRejecter:(RCTPromiseRejectBlock)reject) {
    if(!self.interstitialId) {
        return reject(@"400", @"没有interstitialId.无法展示插屏广告.", nil);
    }
    self.interstitialResolve = resolve;
    self.interstitialReject = reject;
    BOOL isValid = self.interstitialAd.isAdValid;
    if(isValid) {
        [self.interstitialAd showAdFromRootViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    } else {
        self.interstitialReject(@"400", @"穿山甲插屏广告还未准备好.", nil);
    }
}
- (void)nativeExpresInterstitialAdDidLoad:(BUNativeExpressInterstitialAd *)interstitialAd{
    
}
- (void)nativeExpresInterstitialAd:(BUNativeExpressInterstitialAd *)interstitialAd didFailWithError:(NSError * __nullable)error {}
- (void)nativeExpresInterstitialAdRenderSuccess:(BUNativeExpressInterstitialAd *)interstitialAd {
  
}

/**
 This method is called when a nativeExpressAdView failed to render.
 @param error : the reason of error
 */
- (void)nativeExpresInterstitialAdRenderFail:(BUNativeExpressInterstitialAd *)interstitialAd error:(NSError * __nullable)error {
  self.interstitialReject(@"400", @"穿山甲插屏广告渲染失败.", nil);
}
@end