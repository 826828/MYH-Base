//
//  WebInterface.m
//  Pets
//
//  Created by maia on 15/9/1.
//  Copyright (c) 2015年 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "WebInterface.h"
//#import "MoreSetView.h"
//#import "MineModel.h"
#import "FastCoder.h"
@implementation WebInterface
+(WebInterface *)goLogin{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"goLogin" object:nil];
    WebInterface * webInterface = [[WebInterface alloc] init];
    return webInterface;
}

+(WebInterface*)onLineNum:(NSString *)lineNum{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"onLineNum" object:lineNum];
    WebInterface * webInterface = [[WebInterface alloc] init];
    return webInterface;

}
+(WebInterface * )showMenu:(NSString * )isShowFace{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"isShowFace" object:isShowFace];
    WebInterface * webInterface = [[WebInterface alloc] init];
    return webInterface;

}
+(WebInterface * )showAlert
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showAlert" object:nil];
    WebInterface * webInterface = [[WebInterface alloc] init];
    return webInterface;
}

+(WebInterface * )webShare:(NSString*)shareUrl WithImage:(NSString *)shareImage WithTitle:(NSString*)shareTitle WithDescription:(NSString*)shareDescription
{
    
    //保存需要分享的东西
//    ShareModel * shareModel = [[ShareModel alloc]init];
//    shareModel.shareImage = shareImage;
//    shareModel.shareUrl = shareUrl;
//    shareModel.shareTitle = shareTitle;
//    shareModel.shareDescription = shareDescription;
//    NSData *data = [FastCoder dataWithRootObject:shareModel];
//    [[NSUserDefaults standardUserDefaults]setObject:data forKey:APP_SHARE_DATA];
//
//    
//    
//    MoreSetView* Setview = [[MoreSetView alloc]initWithType:MoreSetViewType_Share];
//    
//    [Setview showView];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"malaoerClick" object:webHeight];
    WebInterface * webInterface = [[WebInterface alloc] init];
    return webInterface;
}

//+(WebInterface *)getLocalPics:(int)min :(int)max :(int)number{
//    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"getLocalPics" object:[NSString stringWithFormat:@"%d,%d,%d",min,max,number]];
//    WebInterface * webInterface = [[WebInterface alloc] init];
//    return webInterface;
//
//}


@end
