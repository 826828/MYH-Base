//
//  ShareSDKManager.m
//  touRong
//
//  Created by Hui on 15/8/31.
//  Copyright (c) 2015年 Albert. All rights reserved.
//

#import "ShareSDKManager.h"
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIEditorViewStyle.h>
#import <ShareSDKExtension/ShareSDK+Extension.h>
#import <MOBFoundation/MOBFoundation.h>
#import <SMS_SDK/Extend/SMSSDK+AddressBookMethods.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <SMS_SDK/SMSSDK.h>



@implementation ShareSDKManager

static SSUIShareActionSheetController *sharedSDKObject = nil;

+(void)shareSDKConnectResigter
{
    [SMSSDK registerApp:[AppKeyTargesManage getSMSSDKKey] withSecret:[AppKeyTargesManage getSMSSDKSecret]];
    //5.5.0版本开始，使用新的sharesdk的appkey
    [ShareSDK registerApp:[AppKeyTargesManage getShareSDKKey]
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeTencentWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSMS)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeTencentWeibo:
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:[AppKeyTargesManage getWeiboKey]
                                           appSecret:[AppKeyTargesManage getWeiboSecret]
                                         redirectUri:[AppKeyTargesManage getWeiboRectUrl]
                                            authType:SSDKAuthTypeBoth];
                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:[AppKeyTargesManage getWeChatKey]
                                       appSecret:[AppKeyTargesManage getWeChatSecret]];
                 break;
//             case SSDKPlatformTypeTencentWeibo:
//                 [appInfo SSDKSetupTencentWeiboByAppKey:@"801485713"
//                                              appSecret:@"4376d4e299437591d59634ab52bfdbb8"
//                                            redirectUri:@"https://www.xinhehui.com"];
//                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:[AppKeyTargesManage getQQAppId]
                                      appKey:[AppKeyTargesManage getQQKey]
                                    authType:SSDKAuthTypeBoth];
                 break;
             default:
                 break;
         }
     }];
    [SMSSDK enableAppContactFriends:NO];
}


+ (void)shareSDKCancelConnect
{
    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSMS];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeSinaWeibo];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeTencentWeibo];

}


+ (void)shareSDKHiddenView
{
    if (sharedSDKObject != nil) {
        [sharedSDKObject dismiss];
    }
}


+ (void)newfenxiangcaidanWithContent:(NSString *)content
                        withImageUrl:(id)imageUrl
                          withObject:(id)object
                           withTitle:(NSString *)titleName
                             withurl:(NSString *)shareurl
{
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSString * img = [NSString stringWithFormat:@"%@",imageUrl];
    if (imageUrl != nil && img.length > 0) {
        [imageArray addObject:imageUrl];
    }else{
       [imageArray addObject:[UIImage imageNamed:ABOUTUSLOGO]];
    }
    //创建分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    

    [shareParams SSDKSetupShareParamsByText:content
                                     images:imageArray
                                        url:[NSURL URLWithString:shareurl]
                                      title:titleName
                                       type:SSDKContentTypeAuto];
    
    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"Circle"]
                                                                                  label:@"交易圈"
                                                                                onClick:^{
                                                                                    
                                                                                    //自定义item被点击的处理逻辑
                                                                                    NSLog(@"=== 自定义item被点击 ===");
                                                                          
                                                                                    NSMutableDictionary * mutDict = [NSMutableDictionary dictionaryWithCapacity:10];
                                                                                    [mutDict setObject:content forKey:@"conten"];
                                                                                    if (imageArray.count > 0) {
                                                                                        [mutDict setObject:imageArray forKey:@"images"];//要分享的图片
          
                                                                                    }
                                                                                    [mutDict setObject:object forKey:@"object"];//要传的参数
                                                                                    

                                                                                    [mutDict setObject:shareurl forKey:@"url"];//分享出去的url
                                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:APP_INTERNAL_SHARE object:mutDict];

                                                                                }];
    
    NSArray *items = @[item,
                       @(SSDKPlatformSubTypeWechatSession),
                       @(SSDKPlatformSubTypeWechatTimeline),
                        @(SSDKPlatformSubTypeWechatFav),
                       
                       @(SSDKPlatformSubTypeQQFriend),
                       @(SSDKPlatformSubTypeQZone),
                       @(SSDKPlatformTypeSinaWeibo),
                       @(SSDKPlatformTypeSMS)
                      ];
    //2、分享（可以弹出我们的分享菜单和编辑界面）
    [shareParams SSDKEnableUseClientShare];

    UIView * views = [[UIView alloc]initWithFrame:CGRectMake( 0, 0, 30, 30)];
    [views setBackgroundColor:[UIColor redColor]];
    sharedSDKObject = [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                               items:items
                                         shareParams:shareParams
                                 onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                     
                                     switch (state) {
                                         case SSDKResponseStateSuccess:
                                         {
                                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                                 message:nil
                                                                                                delegate:nil
                                                                                       cancelButtonTitle:@"确定"
                                                                                       otherButtonTitles:nil];
                                             [alertView show];
                                             break;
                                         }
                                         case SSDKResponseStateFail:
                                         {
                                             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                             message:[NSString stringWithFormat:@"请稍后重试"]
                                                                                            delegate:nil
                                                                                   cancelButtonTitle:@"OK"
                                                                                   otherButtonTitles:nil];
                                             [alert show];
                                             break;
                                         }
                                         default:
                                             break;
                                     }
                                 }
                       ];

}

//单个分享
+ (void)OneshareWithContent:(NSString *)content
               withImageUrl:(NSString *)imageUrl
                  withTitle:(NSString *)titleName
                   withtype:(SSDKPlatformType)typestyle
{
    //创建分享内容
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:content
                                     images:@[imageUrl]
                                        url:[NSURL URLWithString:@"https://www.baidu.com"]
                                      title:titleName
                                       type:SSDKContentTypeAuto];
    [ShareSDK share:typestyle
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                     message:nil
                                                                    delegate:nil
                                                           cancelButtonTitle:@"确定"
                                                           otherButtonTitles:nil];
                 [alertView show];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                 message:[NSString stringWithFormat:@"%@",error]
                                                                delegate:nil
                                                       cancelButtonTitle:@"OK"
                                                       otherButtonTitles:nil];
                 [alert show];
                 break;
             }
             default:
                 break;
         }
         
     }];
}

#pragma mark - 自定义UI分享
+(void)theCustomToShareWithContent:(NSString *)content
                      withImageUrl:(NSMutableArray*)images
                          withTitle:(NSString *)titleName
                           withurl:(NSString *)shareurl
                          withtype:(SSDKPlatformType)typestyle
                   withContentType:(SSDKContentType)contentType

{
 
    if (images.count == 0) {
        [images addObject:[UIImage imageNamed:ABOUTUSLOGO]];
    }
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKEnableUseClientShare];

    [shareParams SSDKSetupShareParamsByText:content
                                     images:images //传入要分享的图片
                                        url:[NSURL URLWithString:shareurl]
                                      title:titleName
                                       type:contentType];
    
    if(typestyle ==  SSDKPlatformTypeCopy)
    {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = shareurl;
        [SVProgressHUD showInfoWithStatus:@"复制成功"];
 
    }else
    {
   
        
        if(![ShareSDK hasAuthorized:typestyle])
        {
            [SVProgressHUD dismiss];
        }
     //进行分享
    [ShareSDK share:typestyle //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"shareStateSuccess" object:nil];


         switch (state) {
             case SSDKResponseStateSuccess:
             {
                 [SVProgressHUD showSuccessWithStatus:@"分享成功"];

                 [[NSNotificationCenter defaultCenter]postNotificationName:KEY_SHARE_SUCCESS object:nil];
                 break;
             }
             case SSDKResponseStateFail:
             {
                 [SVProgressHUD showErrorWithStatus:@"分享失败"];
                 NSLog(@"%@",error);
                 break;
             }
             default:
                 [SVProgressHUD dismiss];

                 break;
         }

         
         // 回调处理....}];
     }];
     }
}


#pragma mark - 第三方登陆
+(void)shareSDKLogin:(SSDKPlatformType)type
{
    if ([ShareSDK hasAuthorized:type]) {
        NSLog(@"授权");
    }else
    {
        NSLog(@"未授权");
    }
    [ShareSDK getUserInfo:type
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             NSLog(@"icon==%@",user.icon);
             
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}

#pragma mark - 判断有没有安装微信客户端
+(BOOL)isInstallWechatApplicationWithType:(SSDKPlatformType)platformType
{
    
    if (platformType == SSDKPlatformSubTypeWechatSession || platformType == SSDKPlatformSubTypeWechatTimeline) {
        
        BOOL isinstall = [ShareSDK isClientInstalled:platformType];
        
        if (!isinstall) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"抱歉，您还未安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
        return isinstall;
    }else{
        return YES;
    }
}


@end
