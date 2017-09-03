//
//  HttpRequest.h
//  STLPro
//
//  Created by maia on 16/4/22.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
@class MsgModel;

typedef void (^ResultHttpBlock)(id response,MsgModel *model);
typedef void (^ResultHttpErrorBlock)(id response);

@interface HttpRequest : AFHTTPRequestOperationManager
+ (instancetype)currentHttpRequest;

-(void)postPath:(NSString *)path params:(NSDictionary *)params resultBlock:(ResultHttpBlock)resultBlock;

@end
@interface MsgModel : NSObject
@property(assign,nonatomic)NSInteger status;
@property(strong,nonatomic)NSString * message;
@end
