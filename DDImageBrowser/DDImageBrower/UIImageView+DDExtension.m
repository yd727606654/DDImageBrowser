//
//  UIImageView+DDExtension.m
//  DDChatTableView
//
//  Created by mac on 16/3/9.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "UIImageView+DDExtension.h"
#import <objc/runtime.h>
@implementation UIImageView(DDExtension)

-(void)setImageUrl:(NSString *)imageUrl
{
    [self setupEvent];
    objc_setAssociatedObject(self, @selector(imageUrl), imageUrl, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)imageUrl{
    return objc_getAssociatedObject(self, @selector(imageUrl));
}


- (void)setupEvent{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImageView)];
    [self addGestureRecognizer:tap];
}

- (void)tapImageView{
//    NSLog(@"%@",self.ori);
}
@end
