//
//  UITableView+EmptyData.m
//  STLPro
//
//  Created by maia on 16/4/28.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import "UITableView+EmptyData.h"
#import "Masonry.h"
@implementation UITableView (EmptyData)
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount
{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UIView * backView = [UIView new];
        [backView sizeToFit];
        self.backgroundView = backView;
        UIImageView * imgView = [UIImageView new];
        [imgView setImage:[UIImage imageNamed:@"zanwupinglun"]];
//        imgView.frame = CGRectMake(66, self.frame.size.height/2 -(self.frame.size.width - 132)/2, self.frame.size.width - 132, self.frame.size.width - 132);
        [backView addSubview:imgView];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@125);
            make.width.equalTo(@110);
        }];
        UILabel *messageLabel = [UILabel new];
//        messageLabel.frame = CGRectMake(0, self.frame.size.height/2 -(self.frame.size.width - 300)/2+(self.frame.size.width - 300),self.frame.size.width, 30);
        messageLabel.text = message;
        messageLabel.font = FontWithSize(14);
        messageLabel.textColor = [UIColor lightGrayColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [backView addSubview:messageLabel];
        [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgView.mas_bottom);
            make.height.equalTo(@30);
            make.centerX.equalTo(self);
        }];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}
- (void) tableViewMyCollection:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount typeName:(NSString *)type
{
    float height,width;
    
    if ([type isEqualToString:@"NaoNao"])
    {
        height = 38;
        width = 229;
    } 
    else
    {
        height = 41;
        width = 161;
    }
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        UIView * backView = [UIView new];
        [backView sizeToFit];
        self.backgroundView = backView;
        UIImageView * imgView = [UIImageView new];
        [imgView setImage:[UIImage imageNamed:message]];
        [backView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.mas_equalTo(self).with.offset(-height);
//            make.height.mas_equalTo(height);
//            make.width.mas_equalTo(width);
        }];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
}

@end
