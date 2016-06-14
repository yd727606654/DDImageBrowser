//
//  UIImage+DDFrame.m
//  DDImageBrowser
//
//  Created by mac on 16/6/14.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "UIImage+DDFrame.h"

@implementation UIImage(DDFrame)
- (CGRect)dd_centerScreenFrame{
    CGRect frame;
    CGSize imageSize = self.size;
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    frame = CGRectMake(0,
                       (screenSize.height-imageSize.height*screenSize.width/imageSize.width)/2,
                       screenSize.width,
                       imageSize.height*screenSize.width/imageSize.width);
    if (frame.size.height > screenSize.height) {
        frame.origin.y = 0.0f;
    } else {
        frame.origin.y = (screenSize.height - frame.size.height) / 2.0;
    }
    return frame;
}
@end
