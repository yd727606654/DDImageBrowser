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
    return 0.3f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    
    DDImageBrowerController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect initialFrame = [transitionContext initialFrameForViewController:fromVC];
    DDImageBrowerModel *imageModel = fromVC.imageBrowerModels[fromVC.currentIndex];
   
    
    
    UIView *containerView = [transitionContext containerView];
    [containerView.superview bringSubviewToFront:containerView];
    [containerView addSubview:toVC.view];
    
    UIView *backView = [[UIView alloc] initWithFrame:initialFrame];
    backView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:backView];
    

    UIImage *placeholderImage = imageModel.thumImageView ? imageModel.thumImageView.image : [UIImage imageNamed:@"empty_image"];
    UIImageView *imagev = [[UIImageView alloc] init];
    CGRect imageViewF;
    if (imageModel.oriImage) {
        imageViewF = [imageModel.oriImage dd_centerScreenFrame];
        imagev.image = imageModel.oriImage;
    }else{
        
        CGSize size = placeholderImage.size;
        imageViewF = CGRectMake((backView.bounds.size.width - size.width)/2,
                                (backView.bounds.size.height - size.height)/2,
                                size.width,
                                size.height);
        imagev.image = placeholderImage;
    }
    
    
    CGRect imageEndFrame;
    if (imageModel.thumImageView) {
        UIView *selectView = [imageModel thumImageView];
        imageEndFrame = [containerView convertRect:selectView.bounds fromView:selectView];
    }
    
    imagev.clipsToBounds = YES;
    imagev.contentMode = UIViewContentModeScaleAspectFill;
    [containerView addSubview:imagev];
    
    
    imagev.frame = imageViewF;
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
   
    [UIView animateWithDuration:duration animations:^{
        
        backView.alpha = 0;
        if (imageModel.thumImageView){
            imagev.frame = imageEndFrame;
        }else{
          imagev.alpha = 0;
        }
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
