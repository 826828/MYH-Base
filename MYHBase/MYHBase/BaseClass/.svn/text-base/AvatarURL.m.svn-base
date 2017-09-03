//
//  AvatarURL.m
//  STLPro
//
//  Created by maia on 16/4/27.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "AvatarURL.h"
#import "SDImageCache.h"
@implementation AvatarURL
+(NSURL*)avatarWithStr:(NSString *)icon{
    NSString * iconStr;
    if ([icon rangeOfString:QiNiuBaseUrl].location != NSNotFound) {
        iconStr = icon;
    }
    else if ([icon rangeOfString:@"http"].location != NSNotFound){
    
        iconStr = icon;
    }
    else{
        iconStr = [NSString stringWithFormat:@"%@%@",QiNiuBaseUrl,icon];

    }
    if ([[NSUserDefaults standardUserDefaults]boolForKey:APP_SHENGLIULIANG]) {
        if (![[NSUserDefaults standardUserDefaults]boolForKey:APP_LOADIMAGE]) {
            if (![[SDImageCache sharedImageCache]diskImageExistsWithKey:iconStr]) {
                iconStr = @"hahaha";
            }
        }else
        {
            [[NSUserDefaults standardUserDefaults]setBool:NO forKey:APP_LOADIMAGE];
        }
       
    }
    
    
    return [NSURL URLWithString:iconStr];

}


+(NSString*)backStrWithStr:(NSString *)icon
{
    NSString * iconStr;
    if ([icon rangeOfString:QiNiuBaseUrl].location != NSNotFound) {
        iconStr = icon;
    }
    else if ([icon rangeOfString:@"http"].location != NSNotFound){
        
        iconStr = icon;
    }
    else{
        iconStr = [NSString stringWithFormat:@"%@%@",QiNiuBaseUrl,icon];
        
    }
    return iconStr;
}

@end
