//
//  DDDismissAnimation.h
//  DDImageBrowser
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,DDDismissType) {
    DDDismissTypeLikeWechat,
    DDDismissTypeLikeTwitter,
};

@interface DDDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) DDDismissType type;
@end
