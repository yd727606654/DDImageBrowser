//
//  DDImageScrollView.m
//  DDImageBrowser
//
//  Created by mac on 16/3/11.
//  Copyright © 2016年 dongdong. All rights reserved.
//

#import "DDImageScrollView.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImage+DDFrame.h"
@interface DDImageScrollView ()<UIScrollViewDelegate,UIActionSheetDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL doubleTape;

@end

@implementation DDImageScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _imageView = [[UIImageView alloc] init];
        self.clipsToBounds = YES;
        self.maximumZoomScale = 2;
        self.minimumZoomScale = 1;
        self.delegate = self;
        [self addSubview:_imageView];
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideViewAnimates:)];
        tap.delaysTouchesBegan = YES;
        tap.numberOfTapsRequired = 1;
        [self addGestureRecognizer: tap];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:longPress];
    }
    return self;
}

-(void)setImageModel:(DDImageBrowerModel *)imageModel{
    
    if (imageModel.oriImage) {
        _imageView.image = imageModel.oriImage;
        CGRect imageViewFrame = [imageModel.oriImage dd_centerScreenFrame];
        _imageView.frame = imageViewFrame;
        self.contentSize = _imageView.bounds.size;
        return;
    }
    
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    // no cache
    _imageView.frame = CGRectZero;
    
    UIImage *placeholderImage = imageModel.thumImageView ? imageModel.thumImageView.image : [UIImage imageNamed:@"empty_image"];
    if (![manager cachedImageExistsForURL:[NSURL URLWithString:imageModel.oriUrl]] && ![manager diskImageExistsForURL:[NSURL URLWithString:imageModel.oriUrl]]) {

            CGSize size = placeholderImage.size;
            _imageView.frame = CGRectMake((self.bounds.size.width - size.width)/2,
                                          (self.bounds.size.height - size.height)/2,
                                          size.width,
                                          size.height);
//            _imageView.image = placeholderImage;

    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:imageModel.oriUrl] placeholderImage:placeholderImage options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        if (image) {
            imageModel.oriImage = image;
            if (cacheType == SDImageCacheTypeNone) {
                [UIView animateWithDuration:.3f animations:^{
                    CGRect imageViewFrame = [image dd_centerScreenFrame];
                    _imageView.frame = imageViewFrame;
                } completion:^(BOOL finished) {
                    
                }];
                
            }else{
                CGRect imageViewFrame = [image dd_centerScreenFrame];
                _imageView.frame = imageViewFrame;
            }
        }
        
       self.contentSize = _imageView.bounds.size;
    }];
    
}

- (void)handleLongPress:(UIGestureRecognizer *)press
{
    if (press.state == UIGestureRecognizerStateBegan) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"保存图片", nil];
        [action showInView:self];
    }
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    UIAlertView *alertV = [[UIAlertView alloc] init];
    alertV.title = @"提示";
    [alertV addButtonWithTitle:@"取消"];
    
    if (!error) {
        alertV.message = @"已保存到相册";
    }else{
        if ([ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusDenied) {
            
            alertV.message = @"无法保存\n请在手机的“设置-隐私-照片”选项中,允许团队访问您的照片";
        }else{
            alertV.message = @"已保存到相册";
            
        }
        
    }
    [alertV show];
}

- (void)setImageViewFrame:(CGSize)size
{
    CGRect imageViewFrame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-size.height*[UIScreen mainScreen].bounds.size.width/size.width)/2, [UIScreen mainScreen].bounds.size.width, size.height*[UIScreen mainScreen].bounds.size.width/size.width);
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    if (imageViewFrame.size.height > screenBounds.size.height) {
        imageViewFrame.origin.y = 0.0f;
    } else {
        imageViewFrame.origin.y = (screenBounds.size.height - imageViewFrame.size.height) / 2.0;
    }
    
    _imageView.frame = imageViewFrame;
    self.contentSize = _imageView.bounds.size;
    
}
- (void)handleDoubleTap:(UIGestureRecognizer *)tap{
    _doubleTape = YES;
    CGPoint touchPoint = [tap locationInView:self];
    if (self.zoomScale == self.maximumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        [self zoomToRect:CGRectMake(touchPoint.x, touchPoint.y, 1, 1) animated:YES];
    }
}
- (void)hideViewAnimates:(UIGestureRecognizer *)tap{
    _doubleTape = NO;
    [self performSelector:@selector(hideDelegate) withObject:nil afterDelay:0.2];
    
}
- (void)hideDelegate{
    if (_doubleTape){
        return;
    }
    self.zoomScale = 1;
    [[NSNotificationCenter defaultCenter] postNotificationName:DDDismissNotification object:nil];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGRect imageViewFrame = _imageView.frame;
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    if (imageViewFrame.size.height > screenBounds.size.height) {
        imageViewFrame.origin.y = 0.0f;
    } else {
        imageViewFrame.origin.y = (screenBounds.size.height - imageViewFrame.size.height) / 2.0;
    }
    _imageView.frame = imageViewFrame;
}


@end
