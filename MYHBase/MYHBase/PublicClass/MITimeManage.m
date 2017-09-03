//
//  MITimeManage.m
//  Pets
//
//  Created by m3w4 on 15/8/3.
//  Copyright (c) 2015年 XuShi Technology Co.,Ltd. All rights reserved.
//

#import "MITimeManage.h"
@implementation MITimeManage

+(NSInteger)ResultWithFromDate:(NSString * )fromDate WithType:(NSInteger)type{
     NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDate= [dateFormatter dateFromString:fromDate];
    
    NSDate * to = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:destDate toDate:to options:0];
    if (type ==0) {
        return [d year];

    }
    else if (type==1){
        return [d month];
    }
    else{
        return [d day];
    }
}

+(NSInteger)ResultsWithFromDate:(NSString * )fromDate WithType:(NSInteger)type{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd"];
    NSDate *destDate= [dateFormatter dateFromString:fromDate];
    
    NSDate * to = [NSDate date];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    NSDateComponents *d = [cal components:unitFlags fromDate:destDate toDate:to options:0];
    if (type ==0) {
        return [d year];
        
    }
    else if (type==1){
        return [d month];
    }
    else{
        return [d day];
    }
}

+ (NSInteger)numberOfDaysFromTodayByTime:(NSString *)startTime timeStringFormat:(NSString *)endTime
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startTimeDate= [dateFormatter dateFromString:startTime];
    
    NSDate * endTimeDate = [dateFormatter dateFromString:endTime];

    int timediff = [endTimeDate timeIntervalSince1970]-[startTimeDate timeIntervalSince1970];
    if (timediff <0) {
        return -1;
    }
    else{
        return timediff;

    }
}
+(NSInteger)ResultWithFromStartDate:(NSString * )fromDate WithEndDate:(NSString*)endDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy年MM月dd日"];
    
    NSDate *destDate= [dateFormatter dateFromString:fromDate];
    
    NSDate * to = [dateFormatter dateFromString:endDate];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitMonth ;
    NSDateComponents *d = [cal components:unitFlags fromDate:destDate toDate:to options:0];
    return [d day];
}


+(NSString*)getStringWithDate:(NSDate*)date{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat: @"yyyy-MM-dd"];
    return [format stringFromDate:date];
}
+(NSString*)getStringWithDateMonth:(NSDate*)date{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat: @"MM月dd日"];
    return [format stringFromDate:date];
}
+(NSString*)getStringWithDateHour:(NSDate*)date{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat: @"HH：mm"];
    return [format stringFromDate:date];
}
+(NSDate*)getDateWithString:(NSString*)date{
    NSDateFormatter * format = [[NSDateFormatter alloc]init];
    [format setDateFormat: @"yyyy-MM-dd"];
    return [format dateFromString:date];
}

//数字转化中文
+(NSString *)translation:(NSString *)arebic
{
    NSString *str = arebic;
    
    NSArray *arabic_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0"];
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"零"];
    NSArray *digits = @[@"个",@"十",@"百",@"千",@"万",@"十",@"百",@"千",@"亿",@"十",@"百",@"千",@"兆"];
    NSDictionary *dictionary = [NSDictionary dictionaryWithObjects:chinese_numerals forKeys:arabic_numerals];
    NSMutableArray *sums = [NSMutableArray array];
    for (int i = 0; i < str.length; i ++) {
        NSString *substr = [str substringWithRange:NSMakeRange(i, 1)];
        NSString *a = [dictionary objectForKey:substr];
        NSString *b = digits[str.length -i-1];
        NSString *sum = [a stringByAppendingString:b];
        if ([a isEqualToString:chinese_numerals[9]])
        {
            if([b isEqualToString:digits[4]] || [b isEqualToString:digits[8]])
            {
                sum = b;
                if ([[sums lastObject] isEqualToString:chinese_numerals[9]])
                {
                    [sums removeLastObject];
                }
            }else
            {
                sum = chinese_numerals[9];
            }
            if ([[sums lastObject] isEqualToString:sum])
            {
                continue;
            }
        }
        [sums addObject:sum];
    }
    NSString *sumStr = [sums  componentsJoinedByString:@""];
    NSString *chinese = [sumStr substringToIndex:sumStr.length-1];
    if ([chinese rangeOfString:@"一十"].location !=NSNotFound) {
        chinese=[chinese stringByReplacingOccurrencesOfString:@"一十" withString:@"十"];
    }
    return chinese;
}
+(NSString*)getAge:(NSString *)str{
    NSInteger year =[MITimeManage ResultWithFromDate:str WithType:0];
    NSInteger month =[MITimeManage ResultWithFromDate:str WithType:1];
    if (year==0 && month !=0) {
        return  [NSString stringWithFormat:@"%@个月", [MITimeManage translation:[NSString stringWithFormat:@"%ld",(long)month]]];
    }
    else if (year!=0 && month ==0){
        return [NSString stringWithFormat:@"%@岁", [MITimeManage translation:[NSString stringWithFormat:@"%ld",(long)year]]];
        
    }
    else if(year ==0 && month==0){
        return [NSString stringWithFormat:@"零岁"];
        
    }
    else{
        return  [NSString stringWithFormat:@"%@岁%@个月",[MITimeManage translation:[NSString stringWithFormat:@"%ld",(long)year]], [MITimeManage translation:[NSString stringWithFormat:@"%ld",(long)month]]];
        
    }

}
////+(NSString * get)
//+(NSString * )getSaveKey{
//    /**
//     *	@brief	方式1 由开发者生成saveKey
//     */
//    NSString * str =[NSString stringWithFormat:@"/user/%@/%.f.jpg",[[User currentUser] getAccount],[[NSDate date] timeIntervalSince1970]*1000];
//    return str;
//    
//}
////+(NSString * get)
//+(NSString * )getSaveKeyWithint:(int)i{
//    /**
//     *	@brief	方式1 由开发者生成saveKey
//     */
//    NSString * str =[NSString stringWithFormat:@"/user/%@/%.f.jpg",[[User currentUser] getAccount],[[NSDate date] timeIntervalSince1970]*1000+i];
//    return str;
//    
//}
+(NSString *)translationStyleWith:(NSString *)str{
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat: @"MM-dd HH:mm"];
    NSDate *destDates= [dateFormatters dateFromString:str];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"HH:mm";
    return [dateFormatter stringFromDate:destDates];
}

+(NSString*)timeInterValue:(NSString*)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-M-d";
    long long times = [time longLongValue];
    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:times/1000.0];
    return [dateFormatter stringFromDate:d];
}

+(NSString *)changeTimeWithStamp:(double)Stamp type:(NSInteger)type{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    if (type == 0) {
        dateFormatter.dateFormat = @"HH:mm:ss";

    }
    else if (type == 1){
        dateFormatter.dateFormat = @"yyyy-M-d";

    }
    else if (type == 2){
        dateFormatter.dateFormat = @"yyyy-M-d HH:mm:ss";

    }
    else if (type == 3){
        dateFormatter.dateFormat = @"M-d HH:mm";
    }
    else if (type == 4){
        dateFormatter.dateFormat = @"M-d";
    }
    else if (type == 5){
        dateFormatter.dateFormat = @"yyyy";
    }
    else if (type == 6){
        dateFormatter.dateFormat = @"MM";
    }
    else if (type == 7){
        dateFormatter.dateFormat = @"dd";
    }
    else if(type == 8)
    {
        dateFormatter.dateFormat = @"yyyy年MM月dd日";

    }
    else if(type == 9)
    {
        dateFormatter.dateFormat = @"HH:mm";
        
    }

    else{
        dateFormatter.dateFormat = @"M-d HH:mm";

    }

    NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:Stamp/1000];

    if (type == 999) {
        int year = [MITimeManage ResultsWithNowDateWithType:0];
        int month = [MITimeManage ResultsWithNowDateWithType:1];
        int day = [MITimeManage ResultsWithNowDateWithType:2];
        int nowyear = [[MITimeManage changeTimeWithStamp:Stamp type:5] intValue];
        int nowmonth = [[MITimeManage changeTimeWithStamp:Stamp type:6] intValue];
        int nowday = [[MITimeManage changeTimeWithStamp:Stamp type:7] intValue];
        if (year == nowyear && month == nowmonth && day == nowday) {
            return @"今天";
        }
        else if (year == nowyear && month == nowmonth && day-1 == nowday){
            return @"昨天";
        }
        else{
            return  [dateFormatter stringFromDate:d];
        }
 
    }
    else if (type == 998){
        int year = [MITimeManage ResultsWithNowDateWithType:0];
        int month = [MITimeManage ResultsWithNowDateWithType:1];
        int nowyear = [[MITimeManage changeTimeWithStamp:Stamp type:5] intValue];
        int nowmonth = [[MITimeManage changeTimeWithStamp:Stamp type:6] intValue];
        if (year == nowyear && month == nowmonth ) {
            return @"本月";
        }

        else{
            return  [dateFormatter stringFromDate:d];
        }
    }
    else{
        return  [dateFormatter stringFromDate:d];

    }
}

+(NSString*)birthWithAge:(NSString*)age{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyy";
    NSString * nowDate = [dateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%ld-01-01",[nowDate integerValue]-[age integerValue]];

}

+(NSString*)dateAndTimeInterValue:(NSString*)time{
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSDate *destDates= [dateFormatters dateFromString:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM/dd HH:mm:ss";
    return [dateFormatter stringFromDate:destDates];
}


+(int)ResultsWithNowDateWithType:(NSInteger)type{
    NSDateFormatter *dateFormatters = [[NSDateFormatter alloc] init];
    [dateFormatters setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    NSString * str = [dateFormatters stringFromDate:[NSDate date]];
    NSDate *destDates= [dateFormatters dateFromString:str];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    if (type == 0) {
        dateFormatter.dateFormat = [NSString stringWithFormat:@"yyyy"];
        
    }
    else if(type == 1){
        dateFormatter.dateFormat =[NSString stringWithFormat:@"MM"];
    }
    else if (type == 2){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"dd"];
    }
    else if (type ==3){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"HH"];
    }
    else if (type ==4){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"mm"];
    }
    else if (type ==5){
        dateFormatter.dateFormat = [NSString stringWithFormat:@"ss"];
    }

    return [[dateFormatter stringFromDate:destDates] intValue];

}

+ (double)getMinStartTimeStamp:(double)startTimeStamp endStamp:(double)endStamp{

    NSInteger time = endStamp/1000 - startTimeStamp/1000;
    NSInteger min = time/60;
    return min;
}
+(double)getTimeStamp:(NSDate *)date{
    // 获取当前时时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    double time = [timeSp doubleValue] * 1000;
    return time;

}

/** 通过行数, 返回更新时间 */
+ (NSString *)updateTimeWithTimeStamp:(double)timeStamp {
    // 获取当前时时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    NSInteger time = [timeSp doubleValue] - timeStamp/1000;

    // 秒转小时
    NSInteger hours = time/3600;
    NSInteger second = time;
    
    if (second < 60) {
        return [NSString stringWithFormat:@"%ld秒前",(long)(second <= 0 ? 1:second)];
    }
    else if (second < 3600){
        return [NSString stringWithFormat:@"%ld分钟前",(long)second/60];
    }
    else if (second < 24 * 3600){
        return [NSString stringWithFormat:@"%ld小时前",(long)hours];
    }
    else{
        
         NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"MM-dd HH:mm";
        NSDate *d = [[NSDate alloc]initWithTimeIntervalSince1970:timeStamp/1000];
        return [dateFormatter stringFromDate:d];
        
    }
}

+ (NSString*)randomStringWithLength:(int)len

{
    
    NSString*letters =@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    
    NSMutableString*randomString = [NSMutableString stringWithCapacity: len];
    
    for(int i=0;i<len; i++){
        
        [randomString appendFormat:@"%C", [letters characterAtIndex:arc4random_uniform((int)[letters length])]];
        
    }
    
    return randomString;
    
}

+(NSString *)uploadImgWithKey:(NSInteger)icon{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]* 1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat =@"yyyyMMdd";
    NSString * nowDate = [dateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"app/%@/%@/%@/%@_%@.png",[[UserModel currentUser] getUserInfo].mId,icon == 0? @"images":@"icons",nowDate,timeSp,[MITimeManage randomStringWithLength:8]];
}

+ (NSInteger)getTokenTimeWithTimeStamp:(NSString *)timeStamp {
    // 获取当前时时间戳
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];

    NSInteger time = [timeSp integerValue]  - [timeStamp integerValue];
    
    return time;
}


+ (BOOL)diffTodayStamp:(double)todayStamp yesStamp:(double)yesStamp{
    int todayyear = [[MITimeManage changeTimeWithStamp:todayStamp type:5] intValue];
    int todaymonth = [[MITimeManage changeTimeWithStamp:todayStamp type:6] intValue];
    int todayday = [[MITimeManage changeTimeWithStamp:todayStamp type:7] intValue];

    int yesyear = [[MITimeManage changeTimeWithStamp:yesStamp type:5] intValue];
    int yesmonth = [[MITimeManage changeTimeWithStamp:yesStamp type:6] intValue];
    int yesday = [[MITimeManage changeTimeWithStamp:yesStamp type:7] intValue];
    
    if (todayyear == yesyear && todaymonth == yesmonth && todayday == yesday) {
        return YES;
    }
    else{
        return NO;
    }

}


//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(double)timeStamp
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
   NSDate *newDate = [[NSDate alloc]initWithTimeIntervalSince1970:timeStamp/1000];


    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}
@end
