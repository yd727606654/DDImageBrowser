//
//  DDDismissAnimation.m
//  DDImageBrowser
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDDismissAnimation.h"
#import "DDImageBrowerController.h"
#import "DDImageBrowerModel.h"
#import "SDWebImageManager.h"
#import "UIImage+DDFrame.h"
@implementation DDDismissAnimation

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    DDImageBrowerController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    DDImageBrowerModel *imageModel = fromVC.imageBrowerModels[fromVC.currentIndex];
    UIView *selectView = [imageModel thumImageView];
    
    UIView *containerView = [transitionContext containerView];
    [containerView.superview bringSubviewToFront:containerView];
    [containerView addSubview:toVC.view];
    
    UIView *backView = [[UIView alloc] initWithFrame:initialFrame];
    backView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:backView];
    
    UIImageView *imagev = [[UIImageView alloc] init];
    CGRect imageViewF;
    if (imageModel.oriImage) {
        imageViewF = [imageModel.oriImage dd_centerScreenFrame];
        imagev.image = imageModel.oriImage;
    }else{
        //TODO:
    }
    imagev.clipsToBounds = YES;
    imagev.contentMode = UIViewContentModeScaleAspectFill;
    [containerView addSubview:imagev];
    
    
    imagev.frame = imageViewF;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    CGRect imageEndFrame = [containerView convertRect:selectView.bounds fromView:selectView];
    [UIView animateWithDuration:duration animations:^{
        imagev.frame = imageEndFrame;
        backView.alpha = 0;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
