//
//  TabBarItem.m
//  STLPro
//
//  Created by maia on 16/4/5.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = FontWithSize(10);
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self setTitleColor:TextColor999 forState:UIControlStateNormal]; //正常颜色
        [self setTitleColor:NavBarBgColor forState:UIControlStateSelected]; //选中状态颜色
//        _pointLb = [[UILabel alloc]initWithFrame:CGRectMake((ScreenWidth/4+23)/2+4 ,10, 8, 8)];
//        _pointLb.layer.masksToBounds = YES;
//        _pointLb.layer.cornerRadius = 4;
//        [_pointLb setBackgroundColor:[UIColor colorWithRedNumber:237 greenNumber:72 blueNumber:50 alpha:255]];
//        [self addSubview:_pointLb];

    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake((contentRect.size.width - 23) / 2, 7, 23, 23);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(0, 34, contentRect.size.width, 12);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
