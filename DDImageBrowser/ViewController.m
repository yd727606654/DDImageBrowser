//
//  ViewController.m
//  DDImageBrowser
//
//  Created by mac on 16/3/10.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "ViewController.h"
#import "DDImageBrower.h"
#import "UIImageView+WebCache.h"
//#import "UIImageView+DDExtension.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imagev1;
@property (weak, nonatomic) IBOutlet UIImageView *imageV2;
@property (weak, nonatomic) IBOutlet UIImageView *imageV3;

@end

@implementation ViewController
NSString *image1 = @"http://7xkcd8.com1.z0.glb.clouddn.com/0AD381B4-A28D-4F3C-8F8F-55A98635F789?imageView2/0/w/100/h/100";
NSString *image2 = @"http://7xkcd8.com1.z0.glb.clouddn.com/E3CBA831-AE5C-41F4-A8A2-4BEB8A476F54?imageView2/0/w/100/h/100";
NSString *image3 = @"http://7xk9ph.com1.z0.glb.clouddn.com/83319791-D820-4CDF-B98E-E2E14673557B?imageView2/2/w/200/h/200";
- (void)viewDidLoad {
    [super viewDidLoad];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapView:)];
    
 
    [self.imagev1 sd_setImageWithURL:[NSURL URLWithString:image1] placeholderImage:[UIImage imageNamed:@"default_small_circle"]];
     [self.imageV2 sd_setImageWithURL:[NSURL URLWithString:image2] placeholderImage:[UIImage imageNamed:@"default_small_circle"]];
     [self.imageV3 sd_setImageWithURL:[NSURL URLWithString:image3] placeholderImage:[UIImage imageNamed:@"default_small_circle"]];
    [self.imagev1 addGestureRecognizer:tap];
    [self.imageV2 addGestureRecognizer:tap];
    [self.imageV3 addGestureRecognizer:tap];

}
- (void)tapView:(UITapGestureRecognizer *)tap{
    [DDImageBrower showImageUrls:@[image1,image2,image3] OriImageViews:@[self.imagev1,self.imageV2,self.imageV3] Index:1];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
