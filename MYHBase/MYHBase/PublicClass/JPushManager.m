//
//  JPushManager.m
//  STLPro
//
//  Created by naonaodawang on 16/5/10.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "JPushManager.h"
#import "JPUSHService.h"
#import <AdSupport/AdSupport.h>


@implementation JPushManager

+(void)JPushConnectResigter:(NSDictionary *)launchOptions
{
    //Jpush
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    
//    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
//        JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
//        entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
//        [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
//    } else
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert)
                                              categories:nil];
    }
    else {
        //categories 必须为nil
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                          UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert)
                                              categories:nil];
    }
    //如不需要使用IDFA，advertisingIdentifier 可为nil
    [JPUSHService setupWithOption:launchOptions appKey:[AppKeyTargesManage getJpushKey]
                          channel:channel
                 apsForProduction:isProduction
            advertisingIdentifier:advertisingId];

}

@end
