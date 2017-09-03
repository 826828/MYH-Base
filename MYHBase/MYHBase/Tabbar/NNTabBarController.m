//
//  TTTabBarController.m
//  TTNews
//
//  Created by 瑞文戴尔 on 16/3/25.
//  Copyright © 2016年 瑞文戴尔. All rights reserved.
//

#import "NNTabBarController.h"
#import "NNNavigationController.h"
#import "TabBarItem.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MyViewController.h"
@interface NNTabBarController ()
{
    NSMutableArray* VCArr;
    NSArray* titleArr;
}
@property (nonatomic, assign) BOOL isShakeCanChangeSkin;

@end

@implementation NNTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    titleArr = @[ @"首页", @"消息", @"我的"];
    
    HomeViewController *vc1 = [[HomeViewController alloc] init];
    NNNavigationController *nav1 = [[NNNavigationController alloc] initWithRootViewController:vc1];
    
    
    MessageViewController *vc2 = [[MessageViewController alloc] init];
    
    NNNavigationController *nav2 = [[NNNavigationController alloc] initWithRootViewController:vc2];
    
    
    MyViewController *vc3 = [[MyViewController alloc] init];
    NNNavigationController *nav3 = [[NNNavigationController alloc] initWithRootViewController:vc3];
    
    
    vc1.navigationItem.title =  titleArr[0];
    vc2.navigationItem.title =  titleArr[1];
    vc3.navigationItem.title =  titleArr[2];

    
    
    VCArr = [[NSMutableArray alloc] initWithObjects:nav1, nav2, nav3, nil];
    self.viewControllers = VCArr;
    //    [DKNightVersionManager sharedManager].themeVersion = DKThemeVersionNormal;
    
    [self setupBasic];
//    [self getAccessToken];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pointNew:) name:@"pointNewAppear" object:nil];
//
//    if( [[UserModel currentUser] getLoginState])
//    {
//        NSSet *set1 = [[NSSet alloc] initWithObjects:@"tag1",@"tag2",@"tag0",@"ios",nil];
//        [JPUSHService setTags:set1 alias:[[UserModel currentUser]getUserInfo].mId fetchCompletionHandle:^(int iResCode, NSSet *iTags, NSString *iAlias) {
//            NSLog(@"极光注册标签%d",iResCode);
//        }];
//    }
//    [self getStartAD];
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    if ([self compareTime] && [[UserModel currentUser]getLoginState]) {
//            MoreSetView* Setview = [[MoreSetView alloc]initWithType:MoreSetViewType_Set];
//    
//            [Setview showLoginView];
        }

    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    [[NSUserDefaults standardUserDefaults]setObject:timeSp forKey:APP_POP_ALERT];

}

-(void)setupBasic {
    
    self.tabBar.translucent = YES;
    self.tabBar.barTintColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
    
    NSArray* picArr = @[
                        @"jiaoyi",
                        @"miji",
                        @"wode"
                        ];
    NSArray* picSelectedArr = @[
                                @"jiaoyi1",
                                @"miji1",
                                @"wode1",
                                ];
    
    for (int i = 0; i < 3; i++) {
        TabBarItem* item = [TabBarItem buttonWithType:UIButtonTypeCustom];
        item.frame = CGRectMake(ScreenWidth / 3 * i, 0, ScreenWidth / 3, 49);
        item.backgroundColor = [UIColor clearColor];
        [item setTitle:titleArr[i] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:picArr[i]] forState:UIControlStateNormal];
        [item setImage:[UIImage imageNamed:picSelectedArr[i]] forState:UIControlStateSelected];
        item.tag = 100 + i;
        if (i == 0) {
            item.selected = YES;
        }
        //        NSLog(@"ifReadOnly value: %@" ,[[NSUserDefaults standardUserDefaults]boolForKey:@"EnterAagin"]?@"YES":@"NO");
        item .pointLb.hidden = YES;
        [item addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }
    
}
#pragma mark - 点击tabar切换
- (void)clickAction:(UIButton*)btn
{
    for (UIView* view in btn.superview.subviews) {
        if ([view isKindOfClass:[TabBarItem class]]) {
            TabBarItem* item = (TabBarItem*)view;
            item.selected = NO;
        }
    }
    
    self.selectedIndex = btn.tag - 100;
    btn.selected = YES;
}


#pragma mark - 推送跳转，小红点显示的监听方法
-(void)pointNew:(NSNotification *)notes{
    
    NSDictionary * isNewDict = [notes object];
    //    BOOL isNew =[[isNewDict objectForKey:KEY_PUSH_TAG] boolValue];//看看是关闭还是开启小红点
    BOOL isJump =[[isNewDict objectForKey:KEY_WHETHER_JUMP] boolValue]; //看看是不是需要跳转,app在前台推送的时候不需要跳转，但是一样要获取数据
    
    NSString * itemStr = [NSString stringWithFormat:@"%@",[isNewDict objectForKey:@"pushType"]];
//        if ([itemStr isEqualToString:@"circle"]) {
//    
//            TabBarItem * itme = (TabBarItem *)[self.tabBar viewWithTag:102];
//            itme.pointLb.hidden = !isNew;
//            [[NSUserDefaults standardUserDefaults]setBool:isNew forKey:@"EnterAagin"];//关闭app后再次进来时tab的小红点是否要显示
//        }else if([itemStr isEqualToString:@"system"]||[itemStr isEqualToString:@"rongyun"])
//        {
//            TabBarItem * itme = (TabBarItem *)[self.tabBar viewWithTag:103];
//            itme.pointLb.hidden = !isNew;
//            [[NSUserDefaults standardUserDefaults]setBool:isNew forKey:@"MineItem"];//关闭app后再次进来时tab的小红点是否要显示
//        }
    
    if (isJump) {
        if ([itemStr isEqualToString:@"html"])
        {
//            UINavigationController * nav_now = [VCArr objectAtIndex:self.selectedIndex];
//            
//            BannerModel * model = [isNewDict objectForKey:@"bannerModel"];
//            
//            ShareModel * shareModel = [[ShareModel alloc]init];
//            shareModel.shareImage = model.shareImage;
//            shareModel.shareUrl = model.shareUrl;
//            shareModel.shareTitle = model.shareTitle;
//            shareModel.shareDescription = model.shareDescription;
//            NSData *data = [FastCoder dataWithRootObject:shareModel];
//            [[NSUserDefaults standardUserDefaults]setObject:data forKey:APP_SHARE_DATA];
//            
//            WebViewVC * webView = [[WebViewVC alloc]init];
//            webView.shareUrl = model.shareUrl;
//            webView.source = @"shouYe";
//            webView.url = [NSURL URLWithString:model.baLinks];
//            [nav_now pushViewController:webView animated:YES];
            
        }else if ([itemStr isEqualToString:@"LoginNow"])
        {
            
//            MoreSetView* Setview = [[MoreSetView alloc]initWithType:MoreSetViewType_Set];
//            
//            [Setview showLoginView];
            
//            LoginViewController * VC = [[LoginViewController alloc]init];
//            VC.source = nil;
//            NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:VC];
//            [self.selectedViewController presentViewController:nav animated:YES completion:nil];

            
            
        }else if ([itemStr isEqualToString:@"goShouYe"])
        {
            
            UINavigationController * nav_now = [VCArr objectAtIndex:self.selectedIndex];
//
//            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_LOGIN_DISSMIS object:nil];
//            
            if(nav_now.viewControllers.count>0)  [nav_now popToRootViewControllerAnimated:NO];
//
//            if (self.selectedIndex != 2) {
//                
                TabBarItem * itme = (TabBarItem *)[self.tabBar viewWithTag:100];
                itme.selected = YES;
                TabBarItem * itme1 = (TabBarItem *)[self.tabBar viewWithTag:(self.selectedIndex+100)];
                itme1.selected = NO;
//            }
//            
            self.selectedIndex = 0;
            
        }else if ([itemStr isEqualToString:@"system"])
        {
            
//            UINavigationController * nav_now = [VCArr objectAtIndex:self.selectedIndex];
//            
//            [[NSNotificationCenter defaultCenter] postNotificationName:KEY_LOGIN_DISSMIS_SYSTEM object:nil];
//            
//            if(nav_now.viewControllers.count>0)  [nav_now popToRootViewControllerAnimated:NO];
//            
//            
//            if (self.selectedIndex != 3) {
//                TabBarItem * itme = (TabBarItem *)[self.tabBar viewWithTag:103];
//                itme.selected = YES;
//                
//                TabBarItem * itme1 = (TabBarItem *)[self.tabBar viewWithTag:(self.selectedIndex+100)];
//                itme1.selected = NO;
//            }
//            
//            self.selectedIndex = 3;
            
        }
        else
        {
            //                TabBarItem * itme = (TabBarItem *)[self.tabBar viewWithTag:typeItem];
            //                itme.selected = YES;
            //                TabBarItem * itme1 = (TabBarItem *)[self.tabBar viewWithTag:(self.selectedIndex+100)];
            //                itme1.selected = NO;
            //                self.selectedIndex = 2;
        }
        
        
        
    }
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

#pragma mark  - 获取启动页广告
-(void)getStartAD
{
    
//    [[AuthTokenModel currentAuthTokenModel]getDataWithUrlStr:URL_START_AD dict:@{
//                                                                                 SHOW_FENGHUOLUN_OR_NOT:@"1",
//                                                                                 SHOW_MESSAGE_OF_BACK:@"1"}
//                                           ComplationHandler:^(NSDictionary* response) {
//                                               
//                                               NSArray  * arr = [NSArray arrayWithObjects:[AvatarURL avatarWithStr:[response objectForKey:@"image"]], nil];
//                                               [XHLaunchAd downLoadImageAndCacheWithURLArray:arr];
//
//                                               [[NSUserDefaults standardUserDefaults]setObject:response forKey:KEY_START_AD_CUN];
//                                               
//                                           } errorHandler:^(MsgModel *model) {
//                                               NSLog(@"%@",model);
//                                           }];
}
#pragma mark - 判断时间是否超过6小时
-(BOOL)compareTime
{
    NSString * timeMark = [[NSUserDefaults standardUserDefaults]objectForKey:APP_POP_ALERT];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    long time =  [timeSp longLongValue]-[timeMark longLongValue];
    if (timeMark.length == 0) {
        return NO;
    }
    if (time > 7200*3) {
        return YES;
    }
    return NO;
}


-(void)dealloc {
    
}
-(void)didReceiveMemoryWarning {
    
}
@end
