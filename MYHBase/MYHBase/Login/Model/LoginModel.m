//
//  LoginModel.m
//  STLPro
//
//  Created by naonaodawang on 16/4/28.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "LoginModel.h"
//#import "RYunManager.h"
#import "JPUSHService.h"
@implementation LoginModel


+ (instancetype)currentLoginModel
{
    static id login = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        login = [[self alloc] init];
    });
    
    return login;
}

-(void)getDataWithUrlStr:(NSString *)url
                    dict:(NSDictionary *)dict
       ComplationHandler:(ResultLoginModelBlock)complationBlock
            errorHandler:(ResultErrorBlock)errorBlock
{
    [[HttpRequest currentHttpRequest] postPath:url
                                        params:dict
                                   resultBlock:^(id responses,MsgModel * msgModel){
      
        NSLog(@"responses %@",responses);
        
//        if ([url isEqualToString:URL_LOGIN_ACCOUNT]) {
            if (msgModel.status == 200) {
                NSError * error;
                
                NSDictionary * data = responses[@"data"];
                
                LoginModel * loginModel = [[LoginModel alloc]initWithDictionary:data error:&error];
                
                
                [[UserModel currentUser]saveLoginState:YES];//登陆成功，状态置为yes;
               
                [[UserModel currentUser]saveUserInfo:loginModel];//成功了，保存一下用户信息字典
               
                complationBlock(loginModel);

//                    //保存用户的融云ID,昵称，头像url到数据库
//                    [[FMDBManager sharedManager]insertIntoTab:loginModel.imNo RYuserName:loginModel.nickname RYuserIcon:[Tools checkNullValueForString:loginModel.icon]];

                
                  
                    NSSet *set1 = [[NSSet alloc] initWithObjects:@"tag1",@"tag2",@"tag0",@"ios",nil];
                    [JPUSHService setTags:set1 alias:[[UserModel currentUser]getUserInfo].mId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
                        NSLog(@"极光注册%d",iResCode);
                    }];
             }
            else{
                errorBlock(msgModel);
            }
            
//        }
        
        
    }];

}

@end
