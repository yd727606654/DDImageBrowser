//
//  ViewController.m
//  DDImageBrowser
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#import "DDImageBrowerController.h"
#import "DDImageBrowerModel.h"
#import "DDPresentAnimation.h"
#import "DDDismissAnimation.h"

//#import "UIImageView+DDExtension.h"
@interface ViewController ()< UIViewControllerTransitioningDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imagev1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;
//@property (nonatomic, strong) DDPresentAnimation *presentAnimation;
//@property (nonatomic, strong) DDDismissAnimation *dismissAnimation;
@end

@implementation ViewController

NSString *tubimage1 = @"http://7xkcd8.com1.z0.glb.clouddn.com/0AD381B4-A28D-4F3C-8F8F-55A98635F789?imageView2/0/w/100/h/100";
NSString *tubimage2 = @"http://7xkcd8.com1.z0.glb.clouddn.com/E3CBA831-AE5C-41F4-A8A2-4BEB8A476F54?imageView2/0/w/100/h/100";
NSString *tubimage3 = @"http://7xk9ph.com1.z0.glb.clouddn.com/83319791-D820-4CDF-B98E-E2E14673557B?imageView2/2/w/100/h/100";


NSString *image1 = @"http://7xkcd8.com1.z0.glb.clouddn.com/0AD381B4-A28D-4F3C-8F8F-55A98635F789?imageView2/0/w/400/h/400";
NSString *image2 = @"http://7xkcd8.com1.z0.glb.clouddn.com/E3CBA831-AE5C-41F4-A8A2-4BEB8A476F54?imageView2/0/w/200/h/10000";
NSString *image3 = @"http://7xk9ph.com1.z0.glb.clouddn.com/83319791-D820-4CDF-B98E-E2E14673557B?imageView2/2/w/1000/h/200";
- (void)viewDidLoad {
    [super viewDidLoad];

//  _presentAnimation = [DDPresentAnimation new];
//    _dismissAnimation = [DDDismissAnimation new];
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
     UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
     UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    self.imagev1.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV2.contentMode = UIViewContentModeScaleAspectFill;
    self.imageV3.contentMode = UIViewContentModeScaleAspectFill;
    
    self.imageV3.clipsToBounds = YES;
     self.imagev1.clipsToBounds = YES;
     self.imageV2.clipsToBounds = YES;
    
    [self.imagev1 sd_setImageWithURL:[NSURL URLWithString:tubimage1] placeholderImage:[UIImage imageNamed:@"empty_image"]];
     [self.imageV2 sd_setImageWithURL:[NSURL URLWithString:tubimage2] placeholderImage:[UIImage imageNamed:@"empty_image"]];
     [self.imageV3 sd_setImageWithURL:[NSURL URLWithString:tubimage3] placeholderImage:[UIImage imageNamed:@"empty_image"]];
    self.imagev1.tag = 0;
    self.imageV2.tag = 1;
    self.imageV3.tag = 2;
    [self.imagev1 addGestureRecognizer:tap1];
    [self.imageV2 addGestureRecognizer:tap2];
    [self.imageV3 addGestureRecognizer:tap3];

}
- (void)tapView:(UITapGestureRecognizer *)tap{
    DDImageBrowerController *vc = [[DDImageBrowerController alloc] init];
    vc.imageBrowerModels = [NSMutableArray array];
    vc.currentIndex = tap.view.tag;
  
    NSArray *urls =   @[image1,image2,image3];
    NSArray *images = @[self.imagev1,self.imageV2,self.imageV3];
    for (int i = 0; i < urls.count; i++) {
        DDImageBrowerModel *browerModel = [[DDImageBrowerModel alloc] init];
        browerModel.thumImageView = images[i];
        browerModel.oriUrl = urls[i];
        
        [vc.imageBrowerModels addObject:browerModel];
    }
    DDImageBrowerModel *browerModel = [[DDImageBrowerModel alloc] init];
    browerModel.oriUrl = @"http://7xmdkk.com1.z0.glb.clouddn.com/252C997E-F7E8-40F1-8376-A30230AF36C0";
    [vc.imageBrowerModels addObject:browerModel];
    [self presentViewController:vc animated:YES completion:nil];
    
}

@end
