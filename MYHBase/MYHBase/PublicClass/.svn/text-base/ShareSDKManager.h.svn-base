//
//  ShareSDKManager.h
//  touRong
//
//  Created by Hui on 15/8/31.
//  Copyright (c) 2015年 Albert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>

@interface ShareSDKManager : NSObject

+(void)shareSDKConnectResigter;
+(void)shareSDKCancelConnect;
+(void)shareSDKHiddenView;
+(void)shareSDKLogin:(SSDKPlatformType)type;

//弹出actionSheet分享
+ (void)newfenxiangcaidanWithContent:(NSString *)content
                        withImageUrl:(id)imageUrl
                          withObject:(id)object
                           withTitle:(NSString *)titleName
                             withurl:(NSString *)shareurl;


//单一分享
+ (void)OneshareWithContent:(NSString *)content
               withImageUrl:(NSString *)imageUrl
                  withTitle:(NSString *)titleName
                   withtype:(SSDKPlatformType)typestyle;


//自定义UI分享
+(void)theCustomToShareWithContent:(NSString *)content
                      withImageUrl:(NSMutableArray*)images
                         withTitle:(NSString *)titleName
                           withurl:(NSString *)shareurl
                          withtype:(SSDKPlatformType)typestyle
                       withContentType:(SSDKContentType)contentType;

@end
