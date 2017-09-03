//
//  AccessTokenManage.h
//  DIDIDisk
//
//  Created by naonaodawang on 16/12/30.
//  Copyright © 2016年 shentouli. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccessTokenManage : NSObject

//获取短信验证所需要的token
+(void)getAccessToken;
@end
