//
//  UMengManager.m
//  touRong
//
//  Created by naonao on 15/9/8.
//  Copyright (c) 2015年 Albert. All rights reserved.
//

#import "UMengManager.h"
#import "MobClick.h"
#import "MobClickSocialAnalytics.h"




@implementation UMengManager
+ (void)umengTrack
{
        [MobClick setLogEnabled:NO];//开启debug模式，上线的时候注销掉
        [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
        [MobClick startWithAppkey:[AppKeyTargesManage getUMengKey] reportPolicy:(ReportPolicy) REALTIME channelId:KEY_SPREAD_CHANNEL];
//        [MobClick updateOnlineConfig];  //在线参数配置
    
    
}


+ (void)umengTrackConnect
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString * appKey = [AppKeyTargesManage getUMengKey];
        NSString * deviceName = [[[UIDevice currentDevice] name] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString * mac = [Tools getMacAddress];
        NSString * idfa = [Tools getIdfa];
        NSString * idfv = [Tools getIdfv];
        NSString * urlString = [NSString stringWithFormat:@"http://log.umtrack.com/ping/%@/?devicename=%@&mac=%@&idfa=%@&idfv=%@", appKey, deviceName, mac, idfa, idfv];
        [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL: [NSURL URLWithString:urlString]] delegate:nil];
    });
}


@end
