//
//  DDImageBrowerModel.h
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DDImageBrowerModel : NSObject

@property (nonatomic, strong) UIImage *thumImage;
@property (nonatomic, strong) UIImageView *thumImageView;
@property (nonatomic, copy) NSString *oriURL;

@end
