//
//  CJChuanShanJia.h
//  youzhekou
//
//  Created by 陈俊 on 2019/10/17.
//  Copyright © 2019 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BUAdSDK/BUAdSDKManager.h>
#import <React/RCTBridgeModule.h>
#import <BUAdSDK/BUSplashAdView.h>
#import <BUAdSDK/BUNativeExpressInterstitialAd.h>
#import <BUAdSDK/BUSize.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJChuanShanJia : NSObject <RCTBridgeModule, BUSplashAdDelegate, BUNativeExpresInterstitialAdDelegate>

@property (nonatomic, strong) NSString *splashId;
@property (nonatomic) BOOL isFail;
@property (nonatomic, strong) RCTPromiseResolveBlock splashResolve;
@property (nonatomic, strong) RCTPromiseRejectBlock splashReject;

@property (nonatomic, strong) NSString *interstitialId;
@property (nonatomic, strong) BUNativeExpressInterstitialAd *interstitialAd;

@end

NS_ASSUME_NONNULL_END
