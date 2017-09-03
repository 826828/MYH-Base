//
//  MITimeManage.h
//  Pets
//
//  Created by m3w4 on 15/8/3.
//  Copyright (c) 2015年 XuShi Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MITimeManage : NSObject

+(NSInteger)ResultWithFromDate:(NSString * )fromDate WithType:(NSInteger)type;
+(NSString*)getStringWithDate:(NSDate*)date;
+(NSDate*)getDateWithString:(NSString*)date;
+(NSString *)translation:(NSString *)arebic;
+(NSString *)getAge:(NSString *)str;
+(NSString*)getStringWithDateMonth:(NSDate*)date;
+(NSString*)getStringWithDateHour:(NSDate*)date;

+(NSInteger)ResultWithFromStartDate:(NSString * )fromDate WithEndDate:(NSString*)endDate;
+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)startTime timeStringFormat:(NSString *)endTime;

+(NSString*)timeInterValue:(NSString*)time;
+(NSString*)dateAndTimeInterValue:(NSString*)time;
+(NSInteger)ResultsWithFromDate:(NSString * )fromDate WithType:(NSInteger)type;


+(NSString *)translationStyleWith:(NSString *)str;

+(int)ResultsWithNowDateWithType:(NSInteger)type;
+(NSString*)birthWithAge:(NSString*)age;
+ (NSString *)updateTimeWithTimeStamp:(double)timeStamp;
+(NSString *)uploadImgWithKey:(NSInteger)icon;


+ (double)getMinStartTimeStamp:(double)startTimeStamp endStamp:(double)endStamp;

+ (NSInteger)getTokenTimeWithTimeStamp:(NSString *)timeStamp;
+ (NSString*)randomStringWithLength:(int)len;


+(NSString *)changeTimeWithStamp:(double)Stamp type:(NSInteger)type;


+(double)getTimeStamp:(NSDate *)date;

/**
 *  判断今天和上一天是否为同一天是否为同一天
 *
 *  @param todayStamp 今天
 *  @param yesStamp     上一天
 *
 *  @return bool
 */
+ (BOOL)diffTodayStamp:(double)todayStamp yesStamp:(double)yesStamp;
/**
 *  根据时间戳判断星期
 *
 *  @param data 时间戳
 *
 *  @return 星期
 */
+ (NSString *)getWeekDayFordate:(double)timeStamp;

@end
