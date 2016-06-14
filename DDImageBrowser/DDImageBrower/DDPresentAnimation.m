//
//  DDPresentAnimation.m
//  DDImageBrowser
//
//  Created by mac on 16/6/13.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDPresentAnimation.h"
#import "DDImageBrowerController.h"
#import "DDImageBrowerModel.h"
#import "SDWebImageManager.h"
#import "UIImage+DDFrame.h"
@implementation DDPresentAnimation


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext{
    return .3f;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    DDImageBrowerController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
    
    DDImageBrowerModel *imageModel = toVC.imageBrowerModels[toVC.currentIndex];
    UIImageView *selectView = [imageModel thumImageView];
    UIView *containerView = [transitionContext containerView];
    CGRect imageFrame = [containerView convertRect:selectView.bounds fromView:selectView];
    
    UIView *backView = [[UIView alloc] initWithFrame:finalFrame];
    backView.alpha = 0.3;
    backView.backgroundColor = [UIColor blackColor];
    [containerView addSubview:backView];
    
    UIImageView *imagev = [[UIImageView alloc] init];
    imagev.contentMode = UIViewContentModeScaleAspectFill;
    imagev.clipsToBounds = YES;
    [containerView addSubview:imagev];
    
    __block CGRect endFrame;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    // no cache
    
    if (![manager cachedImageExistsForURL:[NSURL URLWithString:imageModel.oriUrl]] && ![manager diskImageExistsForURL:[NSURL URLWithString:imageModel.oriUrl]]) {
        imagev.image = selectView.image;
        imagev.frame = imageFrame;
        [transitionContext completeTransition:YES];
        [backView removeFromSuperview];
        [imagev removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];

    }else{
        [manager downloadImageWithURL:[NSURL URLWithString:imageModel.oriUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            if (!image) {
                //TODO:
                imagev.image = selectView.image;
                imagev.frame = imageFrame;
                [transitionContext completeTransition:YES];
                [backView removeFromSuperview];
                [imagev removeFromSuperview];
                [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
            }else{
                endFrame = [image dd_centerScreenFrame];
                imagev.image = image;
                
                imagev.frame = imageFrame;
                NSTimeInterval duration = [self transitionDuration:transitionContext];
                
                [UIView animateWithDuration:duration animations:^{
                    imagev.frame = endFrame;
                    backView.alpha = 1;
                } completion:^(BOOL finished) {
                    [transitionContext completeTransition:YES];
                    [backView removeFromSuperview];
                    [imagev removeFromSuperview];
                    [[UIApplication sharedApplication].keyWindow addSubview:toVC.view];
                }];
            }
            
        }];
    }
    
    
    
}
@end
