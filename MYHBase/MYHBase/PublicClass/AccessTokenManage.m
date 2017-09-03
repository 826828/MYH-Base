//
//  AccessTokenManage.m
//  DIDIDisk
//
//  Created by naonaodawang on 16/12/30.
//  Copyright © 2016年 shentouli. All rights reserved.
//

#import "AccessTokenManage.h"

@implementation AccessTokenManage



+(void)getAccessToken{
    [[AuthTokenModel currentAuthTokenModel] getDataWithUrlStr:URL_ACCESS_TOKEN dict:@{@"appkey":[AppKeyTargesManage getSMSSDKKey],@"appsecret":[AppKeyTargesManage getSMSSDKSecret],SHOW_FENGHUOLUN_OR_NOT:@"1",SHOW_MESSAGE_OF_BACK:@"1"} ComplationHandler:^(id response){
        
    } errorHandler:^(MsgModel * model){
//        [SVProgressHUD showErrorWithStatus:@"获取token失败"];
        
    }];
    
}
@end
