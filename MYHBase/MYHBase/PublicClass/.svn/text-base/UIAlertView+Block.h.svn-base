//
//  UIAlertView+Block.h
//  DIDIDisk
//
//  Created by maia on 2017/1/10.
//  Copyright © 2017年 shentouli. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^CompleteBlock) (NSInteger buttonIndex);

@interface UIAlertView (Block)
// 用Block的方式回调，这时候会默认用self作为Delegate
- (void)showAlertViewWithCompleteBlock:(CompleteBlock) block;

@end
