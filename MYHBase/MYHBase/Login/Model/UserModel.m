//
//  UserModel.m
//  STLPro
//
//  Created by maia on 16/4/5.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "UserModel.h"
static NSString *const kKeyThirdID = @"ThirdID";
static NSString *const kKeyLoginState = @"LoginState";
static NSString *const kKeyUserInfo = @"UserInfo";
static NSString *const kKeyRYToken = @"rytoken";
static NSString *const kKeyAccessToken = @"AccessToken";

@implementation UserModel
+ (instancetype)currentUser
{
    static id user = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[self alloc] init];
    });
    
    return user;
}

-(void)sendNewMessage:(NSDictionary *)isNewDict{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pointNewAppear" object:isNewDict];

}
/**
 *  保存账号
 *
 *  @param account 账号
 */
-(void)saveAccount:(NSString *)account
{
    
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:APP_ACCOUNTINFO_ID_KEY
                                                                       accessGroup:nil];
    [wrapper resetKeychainItem];
    if(account != nil){
        [wrapper setObject:account
                    forKey:CFBridgingRelease(kSecAttrAccount)];
    }
}

/**
 *  取得上次登录成功时保存的账号
 *
 *  @return 账号
 */
-(NSString *)getAccount
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:APP_ACCOUNTINFO_ID_KEY
                                                                    accessGroup:nil];
    NSString *account = [wrapper objectForKey:CFBridgingRelease(kSecAttrAccount)];
    return account;
}
/**
 *  保存密码
 *
 *  @return nil
 */
-(void)savePassword:(NSString *)password
{

    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:APP_ACCOUNTINFO_ID_KEY
                                                                       accessGroup:nil];
    if(password != nil){
        [wrapper setObject:password
                    forKey:CFBridgingRelease(kSecValueData)];
    }
}
/**
 *  取得上次登录成功时保存的密码
 *
 *  @return 密码
 */
-(NSString *)getPassword
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:APP_ACCOUNTINFO_ID_KEY
                                                                       accessGroup:nil];
    NSString *passWord = [wrapper objectForKey:CFBridgingRelease(kSecValueData)];
    return passWord;
}
/**
 *  清除密码
 *
 *  @return nil
 */
-(void)removePassword
{
    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:APP_ACCOUNTINFO_ID_KEY
                                                                       accessGroup:nil];
    NSString *password = [wrapper objectForKey:CFBridgingRelease(kSecValueData)];
    if ([Tools checkNullValueForString:password].length > 0) {
        [wrapper resetKeychainItem];
    }
}

//保存第三方登录的userID
-(void)saveThirdPartyLoginUserID:(NSString *)userID
{
    [[NSUserDefaults standardUserDefaults]setObject:userID forKey:kKeyThirdID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//获取第三方登录得userID
-(NSString *)getThirdPartyLoginUserID
{
    NSString * thirdID = [[NSUserDefaults standardUserDefaults]objectForKey:kKeyThirdID];
    return thirdID;
}
//移除第三方登陆
-(void)removeThirdLoginUserID
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyThirdID];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//保存用户是否登陆
-(void)saveLoginState:(BOOL)loginState
{
    [[NSUserDefaults standardUserDefaults]setBool:loginState forKey:kKeyLoginState];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//获取用户是否登陆
-(BOOL)getLoginState
{
    BOOL state = [[NSUserDefaults standardUserDefaults]boolForKey:kKeyLoginState];
    return state;
}
//用户信息
-(void)saveUserInfo:(id)loginInfo
{
    
//    将用户数据归档
    NSMutableData *userInfoData = [[NSMutableData alloc] initWithCapacity:100];
    NSKeyedArchiver *userInfoArchiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:userInfoData];
    [userInfoArchiver encodeObject:loginInfo forKey:kKeyUserInfo];
    [userInfoArchiver finishEncoding];
    // 用户信息
    [[NSUserDefaults standardUserDefaults] setObject:userInfoData forKey:kKeyUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
//获取用户信息
-(LoginModel *)getUserInfo
{
    if ([self getLoginState]) {
        // 反归档获取用户信息
        NSData *userInfoData = [[NSUserDefaults standardUserDefaults] objectForKey:kKeyUserInfo];
        // 将解档回来的用户信息重新赋值
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:userInfoData];
        
        LoginModel *userModel = [unarchiver decodeObjectForKey:kKeyUserInfo];
        
        return userModel;

    }
    return nil;
}
//移除用户信息
-(void)removeUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyUserInfo];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

//融云token存储
-(void)saveRongYToken:(NSString *)token
{
    [[NSUserDefaults standardUserDefaults]setObject:token forKey:kKeyRYToken];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
-(NSString *)getRongYToken
{
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:kKeyRYToken];
    return token;
}
-(void)removeRongYToken
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyRYToken];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
/**
 *  保存账号
 *
 *  @param account 账号
 */
-(void)saveAccessToken:(NSString *)accessToken{
    [[NSUserDefaults standardUserDefaults]setObject:accessToken forKey:kKeyAccessToken];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

/**
 *  取得上次登录成功时保存的账号
 *
 *  @return 账号
 */
-(NSString *)getAccessToken{
    NSString * token = [[NSUserDefaults standardUserDefaults]objectForKey:kKeyAccessToken];
    return token;
    
}
-(void)removeAccessToken{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyAccessToken];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

@end
