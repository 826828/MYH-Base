//
//  BaseVC.m
//  touRong
//
//  Created by nao on 15/8/21.
//  Copyright (c) 2015年 Albert. All rights reserved.
//

#import "BaseVC.h"
#import "WXApi.h"
#import "LoginViewController.h"
#import "NNNavigationController.h"
@interface BaseVC ()

@end

@implementation BaseVC

- (void)loadView
{
    CGRect mainFrame = [UIScreen mainScreen].bounds;
    UIView *rootView = [[UIView alloc] initWithFrame:mainFrame];
    rootView.backgroundColor = [UIColor whiteColor];
    self.view = rootView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.userInfoModel = [[UserModel currentUser]getUserInfo];

}
- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"toubu"] forBarMetrics:UIBarMetricsDefault];

//    AppDelegate *app = XAppDelegate;
//    [self.navigationController setNavigationBarHidden:NO animated:YES];

//    if ([self.dk_manager.themeVersion isEqualToString:DKThemeVersionNormal]) {
//        self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1.0];
//    } else {
//        self.tabBarController.tabBar.barTintColor = [UIColor colorWithRed:1/255.0 green:1/255.0 blue:11/255.0 alpha:1.0];
//    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark
#pragma mark - 返回按钮
- (void)backClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark
#pragma mark - 显示登录页面
- (void)showLoginVC:(NSString *)source
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        LoginViewController * VC = [[LoginViewController alloc]init];
        VC.source = source;
        NNNavigationController *nav = [[NNNavigationController alloc] initWithRootViewController:VC];
        [self presentViewController:nav animated:YES completion:nil];
    });
  

}

#pragma mark
#pragma mark - AlertShowViewDelegate
- (void)alertViewWillPresent:(UIAlertController *)alertController
{
    [self presentViewController:alertController
                       animated:YES
                     completion:nil];
}

#pragma mark
#pragma mark - HttpBackDelegate
- (void)requestDidFinished:(NSDictionary *)info
{

}

- (void)requestFailed:(NSDictionary *)info
{

}

@end
