//
//  LoginModel.h
//  STLPro
//
//  Created by naonaodawang on 16/4/28.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "JSONModel.h"
//#import "AuthTokenModel.h"
@class MsgModel;
typedef void (^ResultLoginModelBlock)(id response);

typedef void (^ResultErrorBlock)(MsgModel *model);
@interface LoginModel : JSONModel<NSCoding>

@property(nonatomic,strong)NSString <Optional>* mId;
@property(nonatomic,strong)NSString <Optional>* token;
@property(nonatomic,strong)NSString <Optional>* nickname;
@property(nonatomic,strong)NSString <Optional>* phone;
@property(nonatomic,strong)NSString <Optional>* icon;
@property(nonatomic,strong)NSString <Optional>* msgNo;//消息数
@property(nonatomic,strong)NSString <Optional>* phoneBind;//绑定手机号
@property(nonatomic,strong)NSString <Optional>* balance;//个人资产
@property(nonatomic,strong)NSString <Optional>* ticketNum;//滴滴券数量
@property(nonatomic,assign)BOOL isGod;//是否是大神


+ (instancetype)currentLoginModel;

- (void)getDataWithUrlStr:(NSString *)url
                     dict:(NSDictionary * )dict
        ComplationHandler:(ResultLoginModelBlock)complationBlock
             errorHandler:(ResultErrorBlock)errorBlock;


@end
