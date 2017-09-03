//
//  UserModel.h
//  STLPro
//
//  Created by maia on 16/4/5.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LoginModel.h"
#import "KeychainItemWrapper.h"
@interface UserModel : NSObject
+ (instancetype)currentUser;

/**
 *  是否显示提示小红点
 *
 *  @param isNew yes显示no不展示
 */
-(void)sendNewMessage:(NSDictionary *)isNewDict;
/**
 *  保存账号
 *
 *  @param account 账号
 */
-(void)saveAccount:(NSString *)account;

/**
 *  取得上次登录成功时保存的账号
 *
 *  @return 账号
 */
-(NSString *)getAccount;

/**
 *  保存密码
 *
 *  @param password 密码
 */
-(void)savePassword:(NSString *)password;

/**
 *  取得上次登录成功时保存的密码
 *
 *  @return 密码
 */
-(NSString *)getPassword;
//清除密码，同时也会清除账号
-(void)removePassword;

/**
 *  保存第三方登陆用户ID
 *
 *  @param userID
 */
-(void)saveThirdPartyLoginUserID:(NSString *)userID;
/**
 *  取得上次登录成功时保存的第三方登陆ID
 *
 *  @return ID
 */
-(NSString *)getThirdPartyLoginUserID;
-(void)removeThirdLoginUserID;
/**
 *  保存是否登录
 *
 *  @param bool
 */
-(void)saveLoginState:(BOOL)loginState;

/**
 *  取得是否登录
 *
 *  @return state
 */
-(BOOL)getLoginState;

/**
 *  保存用户登录时后台返回的用户信息
 *
 *  @param LoginModel
 */
-(void)saveUserInfo:(id)loginInfo;
/**
 *  取得用户登录后的信息
 *
 *  @return loginModel
 */
-(LoginModel *)getUserInfo;
//移除用户信息
-(void)removeUserInfo;

/**
 *  保存融云token
 *
 *  @param token
 */
-(void)saveRongYToken:(NSString *)token;
/**
 *  取得上次登录成功时保存的第三方登陆ID
 *
 *  @return ID
 */
-(NSString *)getRongYToken;
-(void)removeRongYToken;
/**
 *  保存账号
 *
 *  @param account 账号
 */
-(void)saveAccessToken:(NSString *)accessToken;

/**
 *  取得上次登录成功时保存的账号
 *
 *  @return 账号
 */
-(NSString *)getAccessToken;
-(void)removeAccessToken;


@end
