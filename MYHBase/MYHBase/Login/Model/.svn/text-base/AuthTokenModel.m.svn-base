//
//  AuthTokenModel.m
//  STLPro
//
//  Created by naonaodawang on 16/4/26.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "AuthTokenModel.h"

@implementation AuthTokenModel

+ (instancetype)currentAuthTokenModel
{
    static id authToken = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        authToken = [[self alloc] init];
    });
    
    return authToken;
}

- (void)getDataWithUrlStr:(NSString *)url
                     dict:(NSDictionary * )dict
        ComplationHandler:(ResultAuthModelBlock)complationBlock
             errorHandler:(ResultErrorBlock)errorBlock
{
    [[HttpRequest currentHttpRequest] postPath:url params:dict resultBlock:^(id responses,MsgModel * msgModel){
       
        if ([url isEqualToString:URL_QINIU_TOKEN]) {
         
            if (msgModel.status == 200) {
                NSDictionary * data =responses[@"data"];
                NSString * token = [data objectForKey:@"token"];
                complationBlock(token);
            }
            else{
                errorBlock(msgModel);
            }
        }
        else if([url isEqualToString:URL_ACCESS_TOKEN])
        {
            if (msgModel.status == 200) {
                NSDictionary * data =responses[@"data"];
                NSString * token = data[@"token"];
                [[UserModel currentUser] saveAccessToken:token];
                complationBlock(token);
            }else
            {
                errorBlock(msgModel);
            }
        }
        else if([url isEqualToString:URL_SENDSMS_TOKEN])
        {
            if (msgModel.status == 200) {
                NSDictionary * data =responses[@"data"];
                
                complationBlock(data);
            }else
            {
                errorBlock(msgModel);
            }
        }
        else if([url isEqualToString:URL_VERIFY_TOKEN])
        {
            if (msgModel.status == 200) {
                NSDictionary * data =responses[@"data"];
                
                complationBlock(data);
            }else
            {
                errorBlock(msgModel);
            }
        } else if([url isEqualToString:URL_START_AD])
        {
            if (msgModel.status == 200) {
                NSDictionary * data =responses[@"data"];
                
                complationBlock(data);
            }else
            {
                errorBlock(msgModel);
            }
        }

    }];
}



@end
