// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import "FLTDeviceInfoPlusPlugin.h"
#import <sys/utsname.h>
#import "UICKeyChainStore.h"

@implementation FLTDeviceInfoPlusPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel =
      [FlutterMethodChannel methodChannelWithName:@"dev.fluttercommunity.plus/device_info"
                                  binaryMessenger:[registrar messenger]];
  FLTDeviceInfoPlusPlugin* instance = [[FLTDeviceInfoPlusPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getIosDeviceInfo" isEqualToString:call.method]) {
    UIDevice* device = [UIDevice currentDevice];
    struct utsname un;
    uname(&un);

    result(@{
      @"name" : [device name],
      @"systemName" : [device systemName],
      @"systemVersion" : [device systemVersion],
      @"model" : [device model],
      @"localizedModel" : [device localizedModel],
      @"identifierForVendor" : [[device identifierForVendor] UUIDString],
      @"deviceIdCommon" : [self getDeviceId],
      @"isPhysicalDevice" : [self isDevicePhysical],
      @"utsname" : @{
        @"sysname" : @(un.sysname),
        @"nodename" : @(un.nodename),
        @"release" : @(un.release),
        @"version" : @(un.version),
        @"machine" : @(un.machine),
      }
    });
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (NSString*)getDeviceId {
  NSString *uuid = [UICKeyChainStore stringForKey:@"uuid"];

  if ( !uuid ) {
    NSString *uuidString = [[NSUUID UUID] UUIDString];

    [UICKeyChainStore setString:uuidString forKey:@"uuid"];

    uuid = [UICKeyChainStore stringForKey:@"uuid"];

  }

  return uuid;
}

// return value is false if code is run on a simulator
- (NSString*)isDevicePhysical {
#if TARGET_OS_SIMULATOR
  NSString* isPhysicalDevice = @"false";
#else
  NSString* isPhysicalDevice = @"true";
#endif

  return isPhysicalDevice;
}

@end
