//
//  Tools.m
//  ZhiHuiRuiAn
//
//  Created by 杨慧魏 on 14-10-9.
//  Copyright (c) 2014年 su. All rights reserved.
//

#import "Tools.h"
#import "AppDelegate.h"
#import <AdSupport/ASIdentifierManager.h>
#include <sys/socket.h>
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>

@implementation Tools

+(NSString *)getIdfa
{
    NSString *getidfa= [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    return  getidfa;
}

+(NSString *)getIdfv
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}


// 获取mac地址
+ (NSString *)getMacAddress
{
    int                 mgmtInfoBase[6];
    char                *msgBuffer = NULL;
    size_t              length;
    unsigned char       macAddress[6];
    struct if_msghdr    *interfaceMsgStruct;
    struct sockaddr_dl  *socketStruct;
    NSString            *errorFlag = NULL;
    
    
    mgmtInfoBase[0] = CTL_NET;
    mgmtInfoBase[1] = AF_ROUTE;
    mgmtInfoBase[2] = 0;
    mgmtInfoBase[3] = AF_LINK;
    mgmtInfoBase[4] = NET_RT_IFLIST;
    
    if ((mgmtInfoBase[5] = if_nametoindex("en0")) == 0)
        errorFlag = @"if_nametoindex failure";
    else
    {
        
        if (sysctl(mgmtInfoBase, 6, NULL, &length, NULL, 0) < 0)
            errorFlag = @"sysctl mgmtInfoBase failure";
        else
        {
            
            if ((msgBuffer = malloc(length)) == NULL)
                errorFlag = @"buffer allocation failure";
            else
            {
                
                if (sysctl(mgmtInfoBase, 6, msgBuffer, &length, NULL, 0) < 0)
                    errorFlag = @"sysctl msgBuffer failure";
            }
        }
    }
    
    if (errorFlag != NULL)
    {
        NSLog(@"Error: %@", errorFlag);
        return errorFlag;
    }
    
    
    interfaceMsgStruct = (struct if_msghdr *) msgBuffer;
    
    
    socketStruct = (struct sockaddr_dl *) (interfaceMsgStruct + 1);
    
    
    memcpy(&macAddress, socketStruct->sdl_data + socketStruct->sdl_nlen, 6);
    
    
    NSString *macAddressString = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                                  macAddress[0], macAddress[1], macAddress[2],
                                  macAddress[3], macAddress[4], macAddress[5]];
    
    free(msgBuffer);
    
    return macAddressString;
}

+(float)getOSVersions
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
+(NSInteger)getTimeStamp
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    return [timeSp integerValue];
}
+(id)getOSName
{
    return [[UIDevice currentDevice] systemName];
}

+(id)getOSModel
{
    return [[UIDevice currentDevice] model];
}

+ (BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingFormat:@"/%@",fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}

+(BOOL)createFolder:(NSString *)folderName
{
    if (![self isFileExist:folderName]) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *strPath = [documentDirectory stringByAppendingPathComponent:folderName];
        NSError *error=nil;
        return [[NSFileManager defaultManager] createDirectoryAtPath:strPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
    return YES;
}

+(BOOL)saveFileToCaches:(NSString *)fileName fileData:(NSData *)data
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [data writeToFile:[NSString stringWithFormat:@"%@/%@",documentDirectory,fileName] atomically:YES];
}

+(BOOL)saveFileToDocument:(NSString *)fileName fileData:(NSData *)data
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [data writeToFile:[NSString stringWithFormat:@"%@/%@",documentDirectory,fileName] atomically:YES];
}

+(float)widthFactor
{
    if ([[UIScreen mainScreen] bounds].size.height <= 568) {
        return 1.0;
    }else
    {
        return [[UIScreen mainScreen] bounds].size.height/568;
    }
}

+(float)heightFactor
{
    if ([[UIScreen mainScreen] bounds].size.width <= 320) {
        return 1.0;
    }else
    {
        return [[UIScreen mainScreen] bounds].size.width/320;
    }
}

+(float)heightFactor6P
{
    if ([[UIScreen mainScreen] bounds].size.width == 414) {
        return 1.0;
    }else
    {
        return [[UIScreen mainScreen] bounds].size.width/414;
    }
}

+(NSString *)changeNum:(NSInteger)index
{
    NSString *numstring = nil;
    switch (index) {
        case 1:
            numstring = @"一";
            break;
        case 2:
            numstring = @"二";
            break;
        case 3:
            numstring = @"三";
            break;
        case 4:
            numstring = @"四";
            break;
        case 5:
            numstring = @"五";
            break;
        case 6:
            numstring = @"六";
            break;
        case 7:
            numstring = @"七";
            break;
        case 8:
            numstring = @"八";
            break;
        case 9:
            numstring = @"九";
            break;
            
        default:
            break;
    }
    return numstring;
}
/**
 *  根据文字长度计算高度
 *
 *  @param content 评论内容
 *
 *  @return 高度
 */
+ (CGFloat)heightWithContent:(NSString*)content contentSize:(CGFloat)size widthFixed:(CGFloat)width
{
    
    CGSize boundSize = CGSizeMake(width, CGFLOAT_MAX);
     // 至少要有一行的高度
    CGFloat height = [content boundingRectWithSize:boundSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : FontWithSize(size) } context:nil].size.height;
    return height;
}
/**
  *  根据文字长度计算宽度
  *
  *  @param content 评论内容,字号大小，高度固定
  *
  *  @return 宽度
  */
+ (CGFloat)widthWithContent:(NSString*)content contentSize:(CGFloat)size heightFixed:(CGFloat)height
{
    
    CGSize boundSize = CGSizeMake(CGFLOAT_MAX, height);
    
    
    CGFloat width = [content boundingRectWithSize:boundSize options:NSStringDrawingTruncatesLastVisibleLine  | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{ NSFontAttributeName : FontWithSize(size) } context:nil].size.width;
    return width;
    
}


+(NSString *)maxValueWithSourceArr:(NSMutableArray *)sourceArr{
    NSString * sourceStr;
    for (id  obj  in sourceArr) {
        NSString * objStr = obj;
        if (sourceStr.length < objStr.length) {
            sourceStr = objStr;
        }
        else{
            sourceStr = sourceStr;
        }

    }
    return sourceStr;
}

//横向移动
+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue = x;
    
    animation.duration = time;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}

//纵向移动
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y
{
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue = y;
    
    animation.duration = time;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
    
}

//判断字符串
+ (NSString *)checkNullValueForString:(id)object
{
    if([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if(!object)
    {
        return @"";
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *)object;
        if ([string isEqualToString:@"(null)"])
        {
            return @"";
        }
        else if ([string isEqualToString:@"null"])
        {
            return @"";
        }
        else
        {
            return [NSString stringWithFormat:@"%@",string];
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",object];
    }
    else
    {
        return @"";
    }
}
+ (NSString *)checkData:(id)object
{
    if([object isKindOfClass:[NSNull class]])
    {
        return @"--";
    }
    else if(!object)
    {
        return @"--";
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *)object;
        if ([string isEqualToString:@"(null)"])
        {
            return @"--";
        }
        else if ([string isEqualToString:@"null"])
        {
            return @"--";
        }
        else
        {
            return [NSString stringWithFormat:@"%@",string];
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",object];
    }
    else
    {
        return @"--";
    }
}

/*!  *检查评论或者热度是否过万，返回处理后的字段*/

+ (NSString *)whetherPastThousands:(NSString*)object
{
    double  retu ;
    if ([object doubleValue] >= 10000.0) {
        
        retu = [object doubleValue]/10000.0;
    }else
    {
        return object;

    }
    return [NSString stringWithFormat:@"%.1f万",retu];

}


//判断数据字符串
+ (NSString *)checkMoneyDataForString:(id)object
{
    if([object isKindOfClass:[NSNull class]])
    {
        return @"-";
    }
    else if(!object)
    {
        return @"-";
    }
    else if ([object isKindOfClass:[NSString class]])
    {
        NSString *string = (NSString *)object;
        if ([string isEqualToString:@"(null)"])
        {
            return @"-";
        }
        else if ([string isEqualToString:@"null"])
        {
            return @"-";
        }
        else
        {
            return [NSString stringWithFormat:@"%@",string];
        }
    }
    else if ([object isKindOfClass:[NSNumber class]])
    {
        return [NSString stringWithFormat:@"%@",object];
    }
    else
    {
        return @"-";
    }
}


+(BOOL)checkTextFeildNil:(id)object
{
    if ([object isKindOfClass:[UITextField class]]) {
        UITextField * tFeild = (UITextField *)object;
        if (tFeild.text.length == 0 || tFeild.text == nil ||[tFeild.text isEqualToString:@""]) {
            return NO;
        }else
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL)checkNumbers:(NSString *)number{

    if (number == nil || [number  isEqual: @""]) {
        return NO;
    }
    else if (number.length != 11){
    
        return NO;
    }
    else if (![[number substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"]){
    
        return NO;
    }
    else{
    
        return YES;
    }
}

+(double)sizeWithFilePath:(NSString *)path{
    // 1.获得文件夹管理者
    NSFileManager *manger = [NSFileManager defaultManager];
    // 2.检测路径的合理性
    BOOL dir = NO;
    BOOL exits = [manger fileExistsAtPath:path isDirectory:&dir];
    if (!exits) return 0;
    // 3.判断是否为文件夹
    if (dir) { // 文件夹, 遍历文件夹里面的所有文件
        // 这个方法能获得这个文件夹下面的所有子路径(直接\间接子路径)
        NSArray *subpaths = [manger subpathsAtPath:path];
        int totalSize = 0;
        for (NSString *subpath in subpaths) {
            NSString *fullsubpath = [path stringByAppendingPathComponent:subpath];
            BOOL dir = NO;
            [manger fileExistsAtPath:fullsubpath isDirectory:&dir];
            if (!dir) { // 子路径是个文件
                NSDictionary *attrs = [manger attributesOfItemAtPath:fullsubpath error:nil];
                totalSize += [attrs[NSFileSize] intValue];
            }
        }
        return totalSize / (1024 * 1024.0);
    } else { // 文件
        NSDictionary *attrs = [manger attributesOfItemAtPath:path error:nil];
        return [attrs[NSFileSize] intValue] / (1024.0 * 1024.0);
    }
}

+(BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath{
    //获得全部文件数组
    NSArray *fileAry =  [self getAllFileNames:dirPath];
    //遍历数组
    BOOL flag = NO;
    for (NSString *fileName in fileAry) {
        NSString *filePath = [dirPath stringByAppendingPathComponent:fileName];
        flag = [self clearCachesWithFilePath:filePath];
        if (!flag)
            break;
    }
    
    return flag;
}
+ (NSArray *)getAllFileNames:(NSString *)dirPath{
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:dirPath error:nil];
    return files;
}
+ (BOOL)clearCachesWithFilePath:(NSString *)path{
    NSFileManager *mgr = [NSFileManager defaultManager];
    return [mgr removeItemAtPath:path error:nil];
}

@end

@implementation UILabel (MyLayel)

-(CGSize )adaptHeight:(CGSize)maxSize
             FontSize:(int )fontSize
            labelText:(NSString *)string
{
    CGSize namemaxSize = maxSize;
//    CGSize nameSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize]
//                         constrainedToSize:namemaxSize
//                             lineBreakMode:NSLineBreakByTruncatingTail];
   CGSize nameSize = [string boundingRectWithSize:namemaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;

    return nameSize;
}

-(void)showboardwithWidth:(float)width
           withBoardColor:(UIColor *)color
{
    CALayer *layer = self.layer;
    layer.borderWidth = width;
    layer.borderColor = color.CGColor;
    
}

+(UILabel *)labelWithFrame:(CGRect)frame
             withTextColor:(UIColor *)color
         withTextAlignment:(NSTextAlignment)textAlignment
                  withText:(NSString *)text
                  withfont:(UIFont *)font
{
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    
    label.textAlignment = textAlignment;
    label.backgroundColor = [UIColor clearColor];
    if (color) {
        label.textColor = color;
    }
    
    if (text.length)
        label.text = text;
    
    if(font)
        label.font = font;
    return label;
}

@end

@implementation UIImage (MyImage)

+(UIImage *)imageWithContentFileFromCaches:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    
    return [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@/%@",documentDirectory,fileName]];
}

+(UIImage *)imageWithContentFileFromBuddle:(NSString *)fileName
{
    NSArray *array = [fileName componentsSeparatedByString:@"."];
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[array objectAtIndex:0] ofType:[array objectAtIndex:1]]];
}

@end

@implementation UIButton (MyButton)

-(void)showboardwithWidth:(float)width
           withBoardColor:(UIColor *)color
{
    CALayer *layer = self.layer;
    layer.borderWidth = width;
    layer.borderColor = color.CGColor;

}

+(UIButton *)buttonWithFrame:(CGRect)frame
             withNormalImage:(UIImage *)normalimage
             withSelectImage:(UIImage *)selectImage
                   withTouch:(SEL)selector
                  withTarget:(id)target
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    if (normalimage) {
        [button setBackgroundImage:normalimage forState:UIControlStateNormal];
    }
    if (selectImage) {
        [button setBackgroundImage:selectImage forState:UIControlStateSelected];
    }
    if (selector && target) {
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    return button;
}

@end

@implementation UIColor (MyColor)

+ (UIColor *)colorWithRedNumber:(float)red
                    greenNumber:(float)green
                     blueNumber:(float)blue
                          alpha:(float)alpha
{
   return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha/255.0f];
}

@end

@implementation UIView (MyView)

-(void)showboardwithWidth:(float)width
           withBoardColor:(UIColor *)color
{
    CALayer *layer = self.layer;
    layer.borderWidth = width;
    layer.borderColor = color.CGColor;
    
}

@end

@implementation UIImage (fixOrientation)
- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
