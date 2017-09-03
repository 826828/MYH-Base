//
//  UITableView+EmptyData.h
//  STLPro
//
//  Created by maia on 16/4/28.
//  Copyright © 2016年 XMYStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (EmptyData)
//添加一个方法
- (void) tableViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;
- (void) tableViewMyCollection:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount typeName:(NSString *)type;
@end
