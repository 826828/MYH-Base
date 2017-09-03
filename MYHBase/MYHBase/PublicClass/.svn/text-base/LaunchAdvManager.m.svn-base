//
//  LaunchAdvManager.m
//  touRong
//
//  Created by Hui on 15/9/24.
//  Copyright (c) 2015年 Albert. All rights reserved.
//

#import "LaunchAdvManager.h"
#import "UIImageView+WebCache.h"
#import "SDImageCache.h"
//#import "SyetemModel.h"
#import "AppKeyTargesManage.h"
#import "UIImage+GIF.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
#define GUIDE_SCROLL_TAG                676  //引导图 scroll tag
#define AD_SCROLL_TAG                   677  //启动广告 scroll tag

@interface LaunchAdvManager()<UIScrollViewDelegate>
@property (nonatomic ,assign)BOOL isRemoveAdv;
@property (strong, nonatomic) MPMoviePlayerController *player;
@property (strong, nonatomic) UIButton *jumpBtn; //跳过btn
@property (strong, nonatomic) UIButton *enterBtn;//视频播放完毕，点击进入;
@property (nonatomic, strong) UIImageView *startPlayerImageView; //播放开始之前imageView

@end

@implementation LaunchAdvManager

#pragma mark
#pragma mark - 启动引导页
-(void)loadGuideView
{
    CGFloat sizeHei = [UIScreen mainScreen].bounds.size.height;
    CGFloat sizeWidth = [UIScreen mainScreen].bounds.size.width;
    
    NSString * targes = [AppKeyTargesManage getTargesID];
    NSMutableArray *guidearr = [[NSMutableArray alloc] initWithCapacity:0];

    if([targes isEqualToString:@"sixgod"]){
        [guidearr addObject:@"Artboard1.png"];
        [guidearr addObject:@"Artboard2.png"];
        [guidearr addObject:@"Artboard3.png"];
    }
    else if ([targes isEqualToString:@"ddwp"]){
        [guidearr addObject:@"Artboard1.png"];
        [guidearr addObject:@"Artboard2.png"];
        [guidearr addObject:@"Artboard3.png"];
        [guidearr addObject:@"Artboard4.png"];

    }

    else if ([targes isEqualToString:@"jpcj"]){
        [guidearr addObject:@"Artboard1.png"];
        [guidearr addObject:@"Artboard2.png"];
//        [guidearr addObject:@"Artboard3.png"];
        
    }

    UIScrollView *guideScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, sizeHei)];
    guideScroll.showsHorizontalScrollIndicator = NO;
    guideScroll.showsVerticalScrollIndicator = NO;
    guideScroll.tag = GUIDE_SCROLL_TAG;
    guideScroll.scrollEnabled = YES;
    guideScroll.pagingEnabled = YES;
    guideScroll.delegate = self;
    guideScroll.bounces  = NO;
    guideScroll.backgroundColor = [UIColor whiteColor];
    
//    UIView *currentMainView = [[[UIApplication sharedApplication] delegate] window];
    UIView *currentMainView = [UIApplication sharedApplication].keyWindow.viewForBaselineLayout;
    [currentMainView addSubview:guideScroll];
    [currentMainView bringSubviewToFront:guideScroll];
    
    NSInteger cnt = guidearr.count;
    for (int i=0; i<cnt; i++)
    {
        UIImageView  *guideimg = [[UIImageView alloc] initWithFrame:CGRectMake(i*sizeWidth, 0, sizeWidth, sizeHei)];
        guideimg.image = [UIImage imageNamed:[guidearr objectAtIndex:i]];
        guideimg.backgroundColor = [UIColor clearColor];
        [guideScroll addSubview:guideimg];

        if (i == cnt-1){
            UIButton *guidebtn = [UIButton buttonWithType:UIButtonTypeCustom];
            guidebtn.backgroundColor = [UIColor clearColor];
            guidebtn.frame = CGRectMake(ScreenWidth*(cnt-1), 0, ScreenWidth, ScreenHeight);
//            if(sizeHei == 480){
//                guidebtn.frame = CGRectMake(sizeWidth*(cnt-1)+(sizeWidth-366.0/2.0)/2.0f,
//                                            sizeHei-120.0/2.0-86.0/2.0,
//                                            366.0/2.0f,
//                                            86.0/2.0f);
//            }else if(sizeHei == 568){
//                guidebtn.frame = CGRectMake(sizeWidth*(cnt-1)+(sizeWidth-408.0/2.0)/2.0,
//                                            sizeHei-148.0/2.0-94.0/2.0,
//                                            408.0/2.0,
//                                            94.0/2.0);
//            }else if (sizeHei == 667){
//                guidebtn.frame = CGRectMake(sizeWidth*(cnt-1)+(sizeWidth-424.0/2.0)/2.0,
//                                            sizeHei-172.0/2.0-96.0/2.0,
//                                            424.0/2.0,
//                                            96.0/2.0);
//            }else{
//                guidebtn.frame = CGRectMake(sizeWidth*(cnt-1)+(sizeWidth-678.0/3.0)/2.0,
//                                            sizeHei-300.0/3.0-153.0/3.0,
//                                            678.0/3.0,
//                                            153.0/3.0);
//            }
            
            [guidebtn addTarget:self
                         action:@selector(beginToUse)
               forControlEvents:UIControlEventTouchUpInside];
            [guideScroll addSubview:guidebtn];
        }
    }
    
    guideScroll.contentSize = CGSizeMake(sizeWidth*cnt, sizeHei);
}

#pragma mark - 播放视频引导页
/** 播放器 */

- (void)SetupVideoPlayer
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlaybackStart)
                                                 name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                               object:nil];//开始播放
    // movieplayer播放之前放上启动页图片 防止闪动黑色
  
    
    UIView *currentMainView = [UIApplication sharedApplication].keyWindow.viewForBaselineLayout;
    
    NSString *myFilePath = [[NSBundle mainBundle]pathForResource:@"GuidePage"ofType:@"mp4"];
    NSURL *movieURL = [NSURL fileURLWithPath:myFilePath];
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:movieURL];
    [currentMainView addSubview:self.player.view ];
    self.player.shouldAutoplay = YES;
    [self.player setControlStyle:MPMovieControlStyleNone];
    self.player.repeatMode = MPMovieRepeatModeNone;
    [self.player.view setFrame:CGRectMake(0, 0,ScreenWidth, ScreenHeight)];
    self.player.scalingMode = MPMovieScalingModeAspectFill;

    UIImageView *startPlayerImageView;
    NSString * targes = [AppKeyTargesManage getTargesID];
    if([targes isEqualToString:@"zsdz"]){
        startPlayerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zsdz_videostar"]];
    } else {
        startPlayerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dlzs_videostar"]];
    }
    startPlayerImageView.frame = [UIScreen mainScreen].bounds;
    [self.player.view addSubview:startPlayerImageView];
    self.startPlayerImageView = startPlayerImageView;
    
//    self.player.view.alpha = 0;
//    [UIView animateWithDuration:3 animations:^{
//        self.player.view.alpha = 1;
        [self.player prepareToPlay];
//    }];
     _jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
    [_jumpBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _jumpBtn.frame = CGRectMake(ScreenWidth - 80, 30, 60, 30);
    _jumpBtn.backgroundColor = [UIColor whiteColor];
    _jumpBtn.alpha = 0.6;
    _jumpBtn.hidden = YES;
    [_jumpBtn addTarget:self action:@selector(jumpClick) forControlEvents:UIControlEventTouchUpInside];
    [currentMainView addSubview:_jumpBtn];
    
    
    _enterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _enterBtn.backgroundColor = [UIColor clearColor];
    _enterBtn.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _enterBtn.userInteractionEnabled = NO;
    [_enterBtn addTarget:self
                 action:@selector(jumpClick)
       forControlEvents:UIControlEventTouchUpInside];
    [self.player.view addSubview:_enterBtn];
    
    
    
}

//开始播放
- (void)moviePlaybackStart
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.startPlayerImageView removeFromSuperview];
        self.startPlayerImageView = nil;
        _jumpBtn.hidden = NO;
        [NSTimer scheduledTimerWithTimeInterval:16
                                         target:self
                                       selector:@selector(btnCanUse)
                                       userInfo:nil
                                        repeats:NO];
    });
}

#pragma mark - 视频点击跳过 或者播放完毕执行方法
-(void)btnCanUse
{
    _enterBtn.userInteractionEnabled = YES;
    _jumpBtn.hidden = YES;
}
-(void)jumpClick
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:MPMoviePlayerNowPlayingMovieDidChangeNotification
                                                  object:nil];
    NSLog(@"跳过视频播放");
    [self rememberGuideVersion];
    [_jumpBtn removeFromSuperview];
    _jumpBtn = nil;
    [UIView animateWithDuration:1 animations:^{
        self.player.view.alpha = 0;
        CABasicAnimation *animationscale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        
        animationscale.fromValue = [NSNumber numberWithInteger:1];
        animationscale.toValue = [NSNumber numberWithInteger:2];
        animationscale.duration = 1;
        animationscale.repeatCount=1;
        animationscale.autoreverses=YES;
        animationscale.removedOnCompletion=YES;
        [self.player.view.layer addAnimation:animationscale forKey:nil];
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:APP_USE_IS_FIRST];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowXuanFu" object:nil];
    } completion:^(BOOL finished) {
        [self.player.view removeFromSuperview];
        self.player = nil;
        //            AppDelegate *app = XAppDelegate;
        
    }];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

}
#pragma mark
#pragma mark - 启动广告页
//创建启动广告 使用scroll 为了考虑之后出现多张启动广告
-(void)loadAdvView
{
    
    NSString  *name = @"ScreenShot01.gif";
    NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]] pathForResource:name ofType:nil];
    NSData  *imageData = [NSData dataWithContentsOfFile:filePath];
    
    if (!self.loadingImageView) {
        self.loadingImageView = [[UIImageView alloc]init];
    }
    self.loadingImageView.backgroundColor = [UIColor clearColor];
    
    self.loadingImageView.image = [UIImage sd_animatedGIFWithData:imageData];
    self.loadingImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    UIView *currentMainView = [UIApplication sharedApplication].keyWindow.viewForBaselineLayout;
    [currentMainView addSubview:self.loadingImageView];
    [currentMainView bringSubviewToFront:self.loadingImageView];
    
    [NSTimer scheduledTimerWithTimeInterval:7
                                             target:self
                                           selector:@selector(removeAdScrollView)
                                           userInfo:nil
                                            repeats:NO];
}

#pragma mark
#pragma mark - 引导页UIAction 暂时不用
//引导页 开始使用 触发事件
-(void)beginToUse
{
    [self rememberGuideVersion];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    UIView *currentMainView = [UIApplication sharedApplication].keyWindow.viewForBaselineLayout;
    UIScrollView *guideScroll = (UIScrollView *)[currentMainView viewWithTag:GUIDE_SCROLL_TAG];
    if (guideScroll != nil) {
        
        [UIView animateWithDuration:1 animations:^{
            guideScroll.alpha = 0;
            CABasicAnimation *animationscale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            
            animationscale.fromValue = [NSNumber numberWithInteger:1];
            animationscale.toValue = [NSNumber numberWithInteger:2];
            animationscale.duration = 1;
            animationscale.repeatCount=1;
            animationscale.autoreverses=YES;
            animationscale.removedOnCompletion=YES;
            [guideScroll.layer addAnimation:animationscale forKey:nil];
            
            [[NSUserDefaults standardUserDefaults] setBool:NO forKey:APP_USE_IS_FIRST];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowXuanFu" object:nil];
        } completion:^(BOOL finished) {
            [guideScroll removeFromSuperview];
//            AppDelegate *app = XAppDelegate;
         
        }];
    }
}

- (void)handleTapFromAdvView:(UITapGestureRecognizer *)tapGesture
{
    [self removeAdScrollView];
}

#pragma mark
#pragma mark - 定时器动作
- (void)removeAdScrollView
{
    [self.loadingImageView removeFromSuperview];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:APP_USE_IS_FIRST];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"ShowXuanFu" object:nil];
//    if(self.isRemoveAdv == YES) {
//        return;
//    }
//    self.isRemoveAdv = YES;
//    
//    UIView *currentMainView = [UIApplication sharedApplication].keyWindow.viewForBaselineLayout;
//    UIScrollView *adLaunchScroll = (UIScrollView *)[currentMainView viewWithTag:AD_SCROLL_TAG];
//    [UIView animateWithDuration:1 animations:^{
//        adLaunchScroll.alpha = 0;
//        CABasicAnimation *animationscale = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        animationscale.fromValue = [NSNumber numberWithInteger:1];
//        animationscale.toValue = [NSNumber numberWithInteger:2];
//        animationscale.duration = 1;
//        animationscale.repeatCount=1;
//        animationscale.autoreverses=YES;
//        animationscale.removedOnCompletion=YES;
//        [adLaunchScroll.layer addAnimation:animationscale forKey:nil];
//        
//    } completion:^(BOOL finished) {
//        [adLaunchScroll removeFromSuperview];
////        AppDelegate *app = XAppDelegate;
//    }];
}

#pragma mark - 引导页版本号保存
//保存当前版本号存到NSUserDefault
-(void)rememberGuideVersion
{
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString *historyVersion = [[NSUserDefaults standardUserDefaults]objectForKey:KEY_GUIDE_VERSION_STR];
    if (![currentVersion isEqualToString:historyVersion])
    {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:KEY_GUIDE_VERSION_STR];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


#pragma mark - 渠道激活方法
//-(void)qudaoActivation:(NSString *)action
//{
//    NSDictionary *requestDic = [[NSDictionary alloc] initWithObjectsAndKeys:
//                                action,@"actionname",
//                                [Tools getIdfa],@"idfa",
//                                [Tools getMacAddress],@"mac",
//                                [AppKeyTargesManage getAppID],@"appid",
//                                @"1",SHOW_FENGHUOLUN_OR_NOT,nil];
//    [[SyetemModel currentSystemModel]getDataWithUrlStr:URL_QUDAO dict:requestDic ComplationHandler:^(id response) {
//        NSLog(@"激活成功");
//    } errorHandler:^(MsgModel *model) {
//        NSLog(@"激活失败");
//    }];
//}

@end
