//
//  AvatarURL.h
//  STLPro
//
//  Created by maia on 16/4/27.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AvatarURL : NSObject
+(NSURL*)avatarWithStr:(NSString *)icon;


+(NSString*)backStrWithStr:(NSString *)icon;

@end
