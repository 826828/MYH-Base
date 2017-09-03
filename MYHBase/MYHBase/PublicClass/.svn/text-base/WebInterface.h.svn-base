//
//  WebInterface.h
//  Pets
//
//  Created by maia on 15/9/1.
//  Copyright (c) 2015年 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

typedef void (^responsAppraiseErrorBlock)(int a,int b);
@class WebInterface;
@protocol WebInterfaceExports <JSExport>


+(WebInterface *)goLogin;
+(WebInterface * )onLineNum:(NSString*)lineNum;
//+(WebInterface *)getLocalPics:(int)min :(int)max :(int)number;
+(WebInterface * )showMenu:(NSString * )isShowFace;
+(WebInterface * )showAlert;
+(WebInterface * )webShare:(NSString*)shareUrl WithImage:(NSString *)shareImage WithTitle:(NSString*)shareTitle WithDescription:(NSString*)shareDescription;


@end
@interface WebInterface : NSObject<WebInterfaceExports>
@end
