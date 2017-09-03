//
//  Tools.h
//  ZhiHuiRuiAn
//
//  Created by 杨慧魏 on 14-10-9.
//  Copyright (c) 2014年 su. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Tools : NSObject

// 获取广告号
+(NSString *)getIdfa;

//vendor标识符
+(NSString *)getIdfv;

+(NSInteger)getTimeStamp; //获取当前时间戳

// 获取mac地址
+ (NSString *)getMacAddress;

/*!  * 获取当前ios版本  返回float*/
+(float)getOSVersions;

/*!  * 获取当前ios版本名称  */
+(id)getOSName;

/*!  * 获取当前ios model */
+(id)getOSModel;
/*!  *检查手机号*/
+(BOOL)checkNumbers:(NSString *)number;
/*!  *检查是否为空，返回处理后的字段*/
+ (NSString *)checkNullValueForString:(id)object;

/*!  *检查是否为空，是就返回--,为了在label中显示*/
+ (NSString *)checkData:(id)object;

/*!  *检查textfeild是否为空*/
+ (BOOL)checkTextFeildNil:(id)object;
/*!  *检查有关账户金额数据是否为空，返回处理后的字段*/
+ (NSString *)checkMoneyDataForString:(id)object;
/*!  *检查评论或者热度是否过万，返回处理后的字段*/
+ (NSString *)whetherPastThousands:(NSString*)object;
/**
 *  固定高度，返回宽度
 *
 *  @param content 内容
 *  @param size    文本大小
 *  @param height  固定高度
 *
 *  @return 计算后的宽度
 */
+ (CGFloat)widthWithContent:(NSString*)content contentSize:(CGFloat)size heightFixed:(CGFloat)height;

/**
 *  固定宽度，返回高度
 *
 *  @param content 内容
 *  @param size    文本大小
 *  @param width   固定宽度
 *
 *  @return 返回计算后的高度
 */
+ (CGFloat)heightWithContent:(NSString*)content contentSize:(CGFloat)size widthFixed:(CGFloat)width;


/**
 *  取数组里最长的数据
 *
 *  @param sourceArr 源数据
 *
 *  @return 返回字符串
 */
+(NSString *)maxValueWithSourceArr:(NSMutableArray *)sourceArr;

/**
 *  根据路径获取文件大小
 *
 *  @param path 路径
 *
 *  @return 缓存大小
 */
+(double)sizeWithFilePath:(NSString *)path;
/**
 *  清除文件缓存
 *
 *  @param dirPath 文件路径
 *
 *  @return 是否清除成功
 */
+(BOOL)clearCachesFromDirectoryPath:(NSString *)dirPath;


+(BOOL)isFileExist:(NSString *)fileName;

+(BOOL)createFolder:(NSString *)folderName;

+(BOOL)saveFileToDocument:(NSString *)fileName fileData:(NSData *)data;

+(BOOL)saveFileToCaches:(NSString *)fileName fileData:(NSData *)data;

/*! * @discussion 获取宽度因子，用于简单适配iphone6 and iphone plus
 
 * @param nil
 
 * @return float
 
 */
+(float)widthFactor;

/*! * @discussion 获取高度因子，用于简单适配iphone6 and iphone plus
 
 * @discussion 暂时无用

 * @param nil
 
 * @return float
 
 */
+(float)heightFactor;
+(float)heightFactor6P;

/*! * @discussion 将NSInteger 类型的index转化为一，二汉字
 
 * @param index: NSInteger类型数字
 
 * @return NSString
 
 */
+(NSString *)changeNum:(NSInteger)index;

/*! * @discussion 返回一个横向移动的动画
 
 * @param time: 动画间隔时间 
 
 * @param x: 横向移动距离
 
 * @return CABasicAnimation 的一个实例
 
 */
+(CABasicAnimation *)moveX:(float)time X:(NSNumber *)x;//横向移动

/*! * @discussion 返回一个纵向移动的动画
 
 * @param time: 动画间隔时间
 
 * @param y: 纵向移动距离
 
 * @return CABasicAnimation 的一个实例
 
 */
+(CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y; //纵向移动


@end


#import <UIKit/UIKit.h>
@interface UILabel(MyLayel)

/*! * @discussion 获取label的宽高
 
 * @param maxSize: size范围 
 
 * @param fontSize: font大小
 
 * @param string: label内容
 
 * @return return CGSize
 
 */
-(CGSize )adaptHeight:(CGSize)maxSize
             FontSize:(int )fontSize
            labelText:(NSString *)string;

/*! * @discussion 设置边框宽度和颜色
 
 * @param width: 边框宽度
 
 * @param color: 边框颜色
 
 * @return 无
 
 */
-(void)showboardwithWidth:(float)width
           withBoardColor:(UIColor *)color;

/*!  * @discussion //快速创建label ,backgroundColor is clearColor
 
 * @param frame:CGRect label frame
 * @param color:UIColor
 * @param textAlignment:NSTextAlignment default is NULL
 * @param text:NSString text
 * @param font:UIFont font
 
 * @return label
 
 */

+(UILabel *)labelWithFrame:(CGRect)frame
        withTextColor:(UIColor *)color
    withTextAlignment:(NSTextAlignment) textAlignment
             withText:(NSString *)text withfont:(UIFont *)font;

@end

@interface UIImage(MyImage)
+(UIImage *)imageWithContentFileFromCaches:(NSString *)fileName;
+(UIImage *)imageWithContentFileFromBuddle:(NSString *)fileName;
@end

@interface UIButton (MyButton)
-(void)showboardwithWidth:(float)width withBoardColor:(UIColor *)color;

//快速创建有背景图片的按钮
+(UIButton *)buttonWithFrame:(CGRect)frame
             withNormalImage:(UIImage *)normalimage
             withSelectImage:(UIImage *)selectImage
                   withTouch:(SEL)selector
                  withTarget:(id)target;
@end

@interface UIColor (MyColor)
//RGB:0-255
+ (UIColor *)colorWithRedNumber:(float)red greenNumber:(float)green blueNumber:(float)blue alpha:(float)alpha;

@end

@interface UIView (MyView)
//draw  board
-(void)showboardwithWidth:(float)width withBoardColor:(UIColor *)color;

@end


@interface UIImage (fixOrientation)
- (UIImage *)fixOrientation;
@end


