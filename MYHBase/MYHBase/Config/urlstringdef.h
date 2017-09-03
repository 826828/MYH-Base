
//  urlstringdef.h
//  touRong
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 Albert. All rights reserved.
//

#define URL_HOST @"https://interface.ddwp.hangzhoushentou.com"//测试环境
//#define URL_HOST @"http://jp.api.666news.cn"//今评正式环境

#define QiNiuBaseUrl @"http://7xta17.com1.z0.glb.clouddn.com/"

//market/memberorder
#define ABOUTUSLOGO  @"aboutddwp"//Upload_pic 滴滴微盘
#define TYPE_VERSION @"/1"//滴滴微盘:"/1" 舟山大宗:"/2";大连贵金属‘3’
#define ENVIRONMET 1 //1是正式环境，0是测试环境 (暂时用来区分融云的生产和开发环境，当然也可以用于其他判断)
//友盟
#define KEY_SPREAD_CHANNEL   @""   //推广渠道("" 为app store; IOSWebsite为网站越狱版)

static NSString *channel = @"Publish channel";
static BOOL isProduction = YES; //如果是生产环境应该设置为YES。开发环境可以设置为NO。
//Master Secret   6d938a1b7b55d5749f15aec3



#pragma mark - 接口
//启动页广告
#define URL_START_AD  @"/startupPageAd/pageAd"
//获取七牛token
#define URL_QINIU_TOKEN   @"/auth/qntoken"
//短信接口
#define URL_ACCESS_TOKEN @"/interface/auth/apitoken"
#define URL_SENDSMS_TOKEN @"/interface/auth/sendsms"
#define URL_VERIFY_TOKEN @"/interface/auth/smsverify"


