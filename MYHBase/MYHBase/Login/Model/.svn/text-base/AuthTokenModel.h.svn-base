//
//  AuthTokenModel.h
//  STLPro
//
//  Created by naonaodawang on 16/4/26.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "JSONModel.h"
typedef void (^ResultAuthModelBlock)(id response);

typedef void (^ResultErrorBlock)( MsgModel *model);
@interface AuthTokenModel : JSONModel

+ (instancetype)currentAuthTokenModel;

- (void)getDataWithUrlStr:(NSString *)url
                     dict:(NSDictionary * )dict
        ComplationHandler:(ResultAuthModelBlock)complationBlock
             errorHandler:(ResultErrorBlock)errorBlock;
@end
