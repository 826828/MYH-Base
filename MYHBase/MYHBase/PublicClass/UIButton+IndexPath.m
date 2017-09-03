//
//  UIButton+IndexPath.m
//  SIXGOD
//
//  Created by maia on 2016/10/21.
//  Copyright © 2016年 ShenTouLi. All rights reserved.
//

#import "UIButton+IndexPath.h"
#import <objc/runtime.h>
static const void *tagKey = &tagKey;

@implementation UIButton (IndexPath)

-(NSIndexPath * )indexPath{
    return objc_getAssociatedObject(self, tagKey);
}
-(NSString *)isChange{
    return objc_getAssociatedObject(self, tagKey);
}
-(void)setIndexPath:(NSIndexPath *)indexPath{

    objc_setAssociatedObject(self, tagKey, indexPath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(void)setIsChange:(NSString *)isChange{
    
    objc_setAssociatedObject(self, tagKey, isChange, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
