//
//  QiniuUploadModel.h
//  STLPro
//
//  Created by maia on 16/4/27.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QiniuSDK.h"
#import "AuthTokenModel.h"

@interface QiniuUploadModel : NSObject
@property(nonatomic,strong)NSString * token;
//获取七牛上传token
+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (void)getQiniuUploadToken:(void(^)(NSString*token))success failure:(void(^)())failure;
/**
 
 *上传图片
 
 *
 
 *@param image需要上传的image
 
 *@param progress上传进度block
 
 *@param success成功block返回url地址
 
 *@param failure失败block
 
 */

+ (void)uploadImage:(UIImage*)image icon:(NSInteger)icon progress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)())failure;

/**
 *  上传多张图片,按队列依次上传
 *
 *  @param imageArray 图片数组
 *  @param progress   进度
 *  @param success    成功
 *  @param failure    失败
 */
+ (void)uploadImages:(NSArray*)imageArray icon:(NSInteger)icon progress:(void(^)(CGFloat))progress success:(void(^)(NSArray*))success failure:(void(^)())failure;


@end
