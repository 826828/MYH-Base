//
//  QiniuUploadHelper.h
//  STLPro
//
//  Created by maia on 16/4/27.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QiniuUploadHelper : NSObject
@property(copy,nonatomic)void(^singleSuccessBlock)(NSString*);

@property(copy,nonatomic)void(^singleFailureBlock)();

+ (instancetype)sharedUploadHelper;

@end
