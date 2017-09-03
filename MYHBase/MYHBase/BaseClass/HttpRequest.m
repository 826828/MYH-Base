//
//  HttpRequest.m
//  STLPro
//
//  Created by maia on 16/4/22.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "HttpRequest.h"
#import "LoginModel.h"
@implementation HttpRequest
+ (instancetype)currentHttpRequest{
    static id find = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        find = [[self alloc] init];
    });
    
    return find;

}

-(void)postPath:(NSString *)path params:(NSDictionary *)params resultBlock:(ResultHttpBlock)resultBlock{
    
    if (![[params objectForKey:SHOW_FENGHUOLUN_OR_NOT]integerValue]) {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
     }
    LoginModel * usermodel= [[UserModel currentUser] getUserInfo];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/json"];
    sessionManager.requestSerializer.timeoutInterval = 10;//超时时间
    [sessionManager setSecurityPolicy:[self customSecurityPolicy]]; //验证证书
    [sessionManager.requestSerializer setValue:@"iOS" forHTTPHeaderField:@"client-type"];
    //版本号
    NSString *app_Version = [ [[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *app_Version_code = [ [[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    [sessionManager.requestSerializer setValue:app_Version forHTTPHeaderField:@"client-version"];
    [sessionManager.requestSerializer setValue:app_Version_code forHTTPHeaderField:@"client-version-code"];
    [sessionManager.requestSerializer setValue:[Tools getIdfa] forHTTPHeaderField:@"client-device-id"];

    
    if ([[UserModel currentUser] getLoginState] == YES) {
        [sessionManager.requestSerializer setValue:usermodel.token forHTTPHeaderField:@"accessToken"];
        
    }
    NSString *urls;
    if ([path isEqualToString:URL_ACCESS_TOKEN] || [path isEqualToString:URL_SENDSMS_TOKEN] || [path isEqualToString:URL_VERIFY_TOKEN]) {
        if ([[UserModel currentUser] getAccessToken].length>0) {
            [sessionManager.requestSerializer setValue:[[UserModel currentUser] getAccessToken] forHTTPHeaderField:@"STL-AccessToken"];
        }
        
        urls =[NSString stringWithFormat:@"%@%@%@",@"http://114.55.57.244",path,TYPE_VERSION];
        
    }
    else{
        urls=[NSString stringWithFormat:@"%@%@%@",URL_HOST,path,TYPE_VERSION];
    }
   NSString * url = [urls stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    WEAKSELF
    [sessionManager POST:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
//        NSLog(@"%lld", downloadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        MsgModel * model = [[MsgModel alloc]init];
        if (responseObject [@"status"]) {
            model.status = [responseObject [@"status"] integerValue];
        }
        model.message =responseObject [@"message"];
         if (model.status != 200) {
             if (model.status == 405 )
             {
                 
                 [weakSelf tokenLogin];
            }
             if(![[params objectForKey:SHOW_MESSAGE_OF_BACK]integerValue])
             {
                 // 不传的话，输出错误信息
                 [SVProgressHUD showErrorWithStatus:model.message];

             } 
             resultBlock(responseObject,model);
             
        }
        else{
            if(![[params objectForKey:SHOW_MESSAGE_OF_BACK]integerValue])
            {
                //如果是 0 ,不显示信息。如果是1，留着前台显示
                [SVProgressHUD dismiss];
            }
            resultBlock(responseObject,model);

        }


    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@", error);
        NSLog(@"================%@", task.response);

        NSString *errorMessage ;
        
        MsgModel * model = [[MsgModel alloc]init];
        model.status = error.code;
        model.message =errorMessage;
        
        if (error.code == NSURLErrorTimedOut) {
            //网络连接超时
            [[NSNotificationCenter defaultCenter]postNotificationName:@"NSURLErrorTimedOut" object:nil];
            [SVProgressHUD showErrorWithStatus:@"网络超时"];
            resultBlock(nil,model);
            return;
        }
        if(![[params objectForKey:SHOW_MESSAGE_OF_BACK]integerValue])
        {
            [SVProgressHUD showErrorWithStatus:@"网络不佳"];
        }
        resultBlock(nil,model);

    }];

}

#pragma mark - token失效后登录
-(void)tokenLogin
{
    
    if (![[UserModel currentUser]getLoginState]) {
        return;
    }
    
    NSInteger index = [[NSUserDefaults standardUserDefaults]integerForKey:@"loginCount"];

//    NSString * type = [[NSUserDefaults standardUserDefaults]objectForKey:@"LoginType"];
    
    if(index == 0)
    {
        
//        [[UserModel currentUser]removePassword];
        //    [[UserModel currentUser]removeThirdLoginUserID];
        [[UserModel currentUser]removeUserInfo];
        [[UserModel currentUser]saveLoginState:NO];

        [[NSUserDefaults standardUserDefaults]setInteger:index+1 forKey:@"loginCount"];
        NSMutableDictionary * mutDict = [NSMutableDictionary dictionaryWithCapacity:0];
        [mutDict setObject:@"0" forKey:KEY_PUSH_TAG];//要显示小红点
        [mutDict setObject:@"1" forKey:KEY_WHETHER_JUMP];//需不需要跳转
        [mutDict setObject:@"LoginNow" forKey:@"pushType"];//类型：跳转老师列表
         [[UserModel currentUser] sendNewMessage:mutDict];
    }else
    {
        return;
    }

    
    
//    NSDictionary * dict;
//    if([type isEqualToString:@"4"])
//    {
//        dict = @{@"isShare":@"2",
//                 @"telephone":[[UserModel currentUser]getAccount],
//                 @"password":[[UserModel currentUser]getPassword],
//                 SHOW_FENGHUOLUN_OR_NOT:@"1"};
//    }else
//    {
//        dict = @{@"isShare":type,
//                 @"uid":[[UserModel currentUser]getThirdPartyLoginUserID],
//                 @"icon":[UserModel currentUser].getUserInfo.icon,
//                 @"nickname":[UserModel currentUser].getUserInfo.nickname,
//                 SHOW_FENGHUOLUN_OR_NOT:@"1"
//                 };
//    }
//        //token失效的时候，自动登录
//    
//        [[UserModel currentUser]removePassword];
//        [[UserModel currentUser]removeUserInfo];
//        [[UserModel currentUser]saveLoginState:NO];
//    if (index < 2 ) {
//        
//         [[NSUserDefaults standardUserDefaults]setInteger:index+1 forKey:@"loginCount"];
//        [[LoginModel currentLoginModel]getDataWithUrlStr:URL_LOGIN_ACCOUNT dict:dict ComplationHandler:^(id response) {
//             if([type isEqualToString:@"4"])
//              {
//                [[UserModel currentUser]saveAccount:[dict objectForKey:@"telephone"]];
//                [[UserModel currentUser]savePassword:[dict objectForKey:@"password"]];
//              }
//        } errorHandler:^(MsgModel *model) {
//            [[UserModel currentUser]saveLoginState:NO];
//        }];
//    }

}


- (AFSecurityPolicy *)customSecurityPolicy
{
    //先导入证书，找到证书的路径
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"ddwp" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    //AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    //如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    NSSet *set = [[NSSet alloc] initWithObjects:certData, nil];
    securityPolicy.pinnedCertificates = set;
    
    return securityPolicy;
}

@end
@implementation MsgModel


@end
