//
//  AppKeyTargesManage.h
//  STLPro
//
//  Created by naonaodawang on 16/6/15.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppKeyTargesManage : NSObject
/**
 *  获取友盟的key
 *
 *  @return 友盟注册key
 */
+(NSString *)getUMengKey;

/**
 *  极光推送的key
 *
 *  @return key
 */
+(NSString *)getJpushKey;
/**
 *  融云key
 *
 *  @return key
 */
+(NSString *)getRYunKey;

/**
 *  获取shareSDK的key
 *
 *  @return key
 */
+(NSString *)getShareSDKKey;

/**
 *  获取短信验证的key
 *
 *  @return key
 */
+(NSString *)getSMSSDKKey;

/**
 *  获取短信验证的secret
 *
 *  @return key
 */
+(NSString *)getSMSSDKSecret;
/**
 *  返回QQkey
 *
 *  @return key
 */
+(NSString *)getQQKey;
+(NSString *)getQQAppId;
/**
 *  返回weibo的key
 *
 *  @return key
 */
+(NSString *)getWeiboKey;
+(NSString *)getWeiboSecret;
+(NSString *)getWeiboRectUrl;//回调地址
/**
 *  返回WeChat的key
 *
 *  @return key
 */
+(NSString *)getWeChatKey;
+(NSString *)getWeChatSecret;

/**
 *  获取AppStore的下载地址
 */
+(NSString *)getAppStoreAddress;

/**
 *  获取targesID
 *
 *  @return id
 */
+ (NSString *)getTargesID;
/**
 *  获取APPID
 *
 *  @return id
 */
+ (NSString *)getAppID;
/**
 *  获取JSPatchKey
 *
 *  @return id
 */
+ (NSString *)getJSPatchKey;
/**
 *  获取RSA公钥
 *
 *  @return 公钥值
 */
+ (NSString *)getRSAPublicKey;


/**
 *  系统版本
 */
@end
