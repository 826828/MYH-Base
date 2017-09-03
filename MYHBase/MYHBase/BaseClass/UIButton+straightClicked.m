//
//  UIButton+straightClicked.m
//  XYuanTiKu
//
//  Created by 李少博 on 14/7/13.
//  Copyright (c) 2015年 XiongYing Tec. All rights reserved.
//

#import "UIButton+straightClicked.h"
static const char kbutonTime;
static const char kbuttonBlock;

#define PADDING     5

static void *AdsorbEnableKey = &AdsorbEnableKey;

@implementation UIButton (straightClicked)

- (void)addAcionWithLimitTime:(CGFloat)timeLimit controlEvents:(UIControlEvents)controlEvents usingBlock:(UIControlActionBlock)block{
    if (!timeLimit) {
        timeLimit = 0.5;
    }
    [self addTarget:self action:@selector(btnClicked:) forControlEvents:controlEvents];
    objc_setAssociatedObject(self, &kbuttonBlock,block , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &kbutonTime,@(timeLimit), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)btnClicked:(UIButton*)sender{
     CGFloat timeLimit = [objc_getAssociatedObject(self, &kbutonTime) floatValue];
    [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(todoSomethingWhenBtnClicked:) object:self];
    [self performSelector:@selector(todoSomethingWhenBtnClicked:) withObject:self afterDelay:timeLimit];
}
- (void)todoSomethingWhenBtnClicked:(UIButton*)sender{
  UIControlActionBlock block = (UIControlActionBlock)objc_getAssociatedObject(self,& kbuttonBlock);
    if (block) {
      block(sender);
    }
}

- (void)dealloc
{
    objc_removeAssociatedObjects(self);
}

@end
