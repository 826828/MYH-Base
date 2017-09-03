//
//  QiniuUploadModel.m
//  STLPro
//
//  Created by maia on 16/4/27.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "QiniuUploadModel.h"
#import"AFNetworking.h"
#import "QiniuSDK.h"
#import"AFNetworkActivityIndicatorManager.h"
#import "MITimeManage.h"
#import "QiniuUploadHelper.h"

@implementation QiniuUploadModel
//给图片命名

+ (NSString*)getDateTimeString

{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];

    return timeSp;
    
}
//  压缩图片

+(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}
//上传单张图片

+ (void)uploadImage:(UIImage*)image icon:(NSInteger)icon progress:(QNUpProgressHandler)progress success:(void(^)(NSString*url))success failure:(void(^)())failure {
    [QiniuUploadModel getQiniuUploadToken:^(NSString*token) {
        
        UIImage * dataImg = [QiniuUploadModel OriginImage:image scaleToSize:CGSizeMake(image.size.width/4, image.size.height/4)];
        NSData*data =UIImageJPEGRepresentation(dataImg,0.5);
        
        if(!data) {
            
            if(failure) {
                
                failure();
                
            }
            
            return;
            
        }
        NSString * keyName =[MITimeManage uploadImgWithKey:icon];
        QNUploadOption*opt = [[QNUploadOption alloc]initWithMime:nil
                              
                                                progressHandler:progress
                              
                                                         params:nil
                              
                                                       checkCrc:NO
                              
                                             cancellationSignal:nil];
        
        QNUploadManager*uploadManager = [[QNUploadManager alloc] init];
        
        [uploadManager putData:data
         
                           key:keyName
         
                         token:token
         
                      complete:^(QNResponseInfo*info,NSString*key,NSDictionary*resp) {
                          if(info.statusCode==200&& resp) {
                              NSString*url= [NSString stringWithFormat:@"%@", resp[@"key"]];
                              if(success) {
                                  
                                  success(url);
                                  
                              }
                              
                          }
                          
                          else{
                              
                              if(failure) {
                                  failure();
                                  
                              }
                              
                          }
                          
                      }option:opt];
        
    }failure:^{
        
    }];
    
}
//上传多张图片

+ (void)uploadImages:(NSArray*)imageArray icon:(NSInteger)icon progress:(void(^)(CGFloat))progress success:(void(^)(NSArray*))success failure:(void(^)())failure

{
    NSMutableArray*array = [[NSMutableArray alloc]init];
    
    __block CGFloat totalProgress =0.0f;
    
    __block CGFloat partProgress =1.0f/ [imageArray count];
    
    __block NSUInteger currentIndex =0;
    
    QiniuUploadHelper*uploadHelper = [QiniuUploadHelper sharedUploadHelper];
    
    __weak typeof(uploadHelper) weakHelper = uploadHelper;
    
    uploadHelper.singleFailureBlock= ^() {
        
        failure();
        
        return;
        
    };
    
    uploadHelper.singleSuccessBlock= ^(NSString*url) {
        
        [array addObject:url];
        
        totalProgress += partProgress;
        
        progress(totalProgress);
        
        currentIndex++;
        
        if([array count] == [imageArray count]) {
            
            success([array copy]);
            
            return;
            
        }else{
                        
            [QiniuUploadModel uploadImage:imageArray[currentIndex] icon:icon progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
            
        }
        
    };
    
    [QiniuUploadModel uploadImage:imageArray[0] icon:icon progress:nil success:weakHelper.singleSuccessBlock failure:weakHelper.singleFailureBlock];
    
}

//获取七牛的token

+ (void)getQiniuUploadToken:(void(^)(NSString*))success failure:(void(^)())failure {
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString *timeSp = [defaults valueForKey:@"httpTokenTime"];
    if ([MITimeManage getTokenTimeWithTimeStamp:timeSp] > 3600) {
        [[AuthTokenModel currentAuthTokenModel] getDataWithUrlStr:URL_QINIU_TOKEN dict:nil ComplationHandler:^(id response){
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
            [defaults setObject:response forKey:@"httpToken"];
            [defaults setObject:timeSp forKey:@"httpTokenTime"];
            [defaults synchronize];
            success(response);
        } errorHandler:^(MsgModel *model){
            failure();
        }];

    }
    else{
        NSString *token = [defaults valueForKey:@"httpToken"];
        success(token);
    }
}



@end
