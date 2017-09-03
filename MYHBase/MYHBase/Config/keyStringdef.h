//
//  keyStringdef.h
//  touRong
//
//  Created by apple on 13-11-20.
//  Copyright (c) 2013年 Albert. All rights reserved.
//

#ifndef touRong_keyStringdef_h
#define touRong_keyStringdef_h


#define WEAKSELF  typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(self)__strong strongSelf = self;

#define Widescale  ([[UIScreen mainScreen] bounds].size.width/375)

//默认用户中心
#define KEY_GUIDE_VERSION_STR                   @"guide_version_str"        //引导图使用的版本号存到NSUserDefaults
#define APP_LAUNCH_IMAGE_KEY                    @"startLaunchImage"         //广告页
#define SHOW_FENGHUOLUN_OR_NOT                  @"showfenghuolun"           //是否显示风火轮 1.不显示，0显示
#define SHOW_MESSAGE_OF_BACK                    @"showmessageofback"        //底层是否显示返回回来的信息。 1.不显示 0 显示
#define APP_ACCOUNTINFO_ID_KEY                  @"com.shentouli.identity"  //用户账户密码信息保存key
#define KEY_ACCOUNT_LOGIN                       @"account_login"            //用户是否登录
#define KEY_PUSH_TAG                            @"push_tag"                 //push消息标记(YES,新消息  NO,无新消息)
#define KEY_WHETHER_JUMP                        @"Whether_jump"               //收到消息的时候是否跳转
#define KEY_MESSAGE_MARK                        @"syetem_Message_Mark"         //系统消息是否标记小红点
#define KEY_ASK_MARK                            @"ask_mark"                    //独家分析（问财）是否标记小红点
#define KEY_TRADECIRCLE_MARK                    @"Trade_circle_mark"           //交易圈是否标记小红点
#define KEY_ACTIVITIES_MARK                     @"activities_mark"              //我的页面是否有未读消息数
#define KEY_CHANGE_HEAD_OR_NAME                 @"change_head_or_name"              //修改名称或者头像的
#define KEY_CHANGE_RANK_PAIMING                 @"change_rank_paiming"              //盈利排名修改
#define KEY_LINE_PUSH_TAG                       @"push_line_tag"                 //push消息标记(YES,新消息  NO,无新消息)
#define APP_USE_IS_FIRST                        @"first_qidong"                //首次启动
#define APP_POP_ALERT                           @"pop_alert"                   //瀑布式弹窗
#define APP_INTERNAL_SHARE                      @"app_internal_share"           //内部分享的key，用通知，分享到交易圈
#define APP_TRANSACTION_HISTORY                 @"Transaction_history"               //交易历史首次点进
#define APP_SYSTEMMESSAGE_COUNT                 @"app_system_message_outlogin"    //未登录时的系统消息数


#define APP_NEWS_TITLES                         @"app_news_titles"  //资讯栏的标题，保存在本地
#define APP_NEWS_TITLES_BEIXUAN                 @"app_news_titles_beixuan"  //资讯栏的备选标题，保存在本地
#define APP_FONT_ZHENGWEN                       @"app_font_zhengwen"        //正文的字号
#define KEY_COLLECTION_BIAOZHI                  @"Collection_biaozhi"   //是否收藏，反向传值
#define APP_SHARE_DATA                          @"app_share_data"  //保存需要分享的东西
#define APP_SHENGLIULIANG                        @"app_shengliuliang"  //省流量 yes省流量模式开启   NO 未开启
#define APP_TUISONG                             @"app_tuisong"  //推送设置 yes推送开启   NO 未开启
#define APP_LOADIMAGE                           @"app_loadimage"  //点击加载图片   NO 不加载
#define KEY_LOGIN_DISSMIS                       @"loginDissmis"//登录注册dismm掉
#define KEY_LOGIN_DISSMIS_SYSTEM                 @"loginDissmis_system"//登录注册dismm掉在system
#define KEY_SHARE_SUCCESS                        @"share_success"//分享成功
#define KEY_START_AD_CUN                        @"read_start_ad"//读取启动广告

#define KEY_PAY_VERIFYORDER                        @"ali_pay_verifyoder"//支付完成后验证所需要的订单号

#endif
