//
//  ImageViewController.m
//  实战4.8
//
//  Created by 杨浩宇 on 15/4/13.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () <UIScrollViewDelegate>

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加scrollView控件，在当前屏幕区域初始化
    //注意UIScreen代表当前屏幕对象，其applicationFrame是当前屏幕内容区域
    _scrollView =[[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame];
    //_scrollView.backgroundColor=[UIColor redColor];
    _scrollView.contentMode=UIViewContentModeScaleAspectFit;
    [self.view addSubview:_scrollView];
    
    
    //添加图片控件
    UIImage *image=[UIImage imageNamed:@"桌面"];
    _imageView=[[UIImageView alloc]initWithImage:image];//initWithImage: , 作用 adjusts the frame of the receiver to match the size of the specified image
    [_scrollView addSubview:_imageView];

    //contentSize必须设置,否则无法滚动，当前设置为图片大小
    _scrollView.contentSize= _imageView.frame.size;
    
    //实现缩放：同时还要实现viewForZoomingInScrollView方法
    _scrollView.minimumZoomScale=0.6;
    _scrollView.maximumZoomScale=3.0;
    //设置代理
    _scrollView.delegate=self;
    
    
    //边距，不属于内容部分，内容坐标（0，0）指的是内容的左上角不包括边界
    //_scrollView.contentInset=UIEdgeInsetsMake(10, 20, 10, 20);
    
    //显示滚动内容的指定位置
    //_scrollView.contentOffset=CGPointMake(10, 0);
    
    //隐藏滚动条
    _scrollView.showsHorizontalScrollIndicator=NO;
    _scrollView.showsVerticalScrollIndicator=NO;
    
    //禁用弹簧效果
    //_scrollView.bounces=NO;
}

#pragma mark 实现缩放视图代理方法，不实现此方法无法缩放
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDecelerating");
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    NSLog(@"scrollViewWillBeginDragging");
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"scrollViewDidEndDragging");
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    NSLog(@"scrollViewWillBeginZooming");
}
-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale{
    NSLog(@"scrollViewDidEndZooming");
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"scrollViewDidScroll");
//}

#pragma mark 当图片小于屏幕宽高时缩放后让图片显示到屏幕中间
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    CGSize originalSize=_scrollView.bounds.size;
    CGSize contentSize=_scrollView.contentSize;
    CGFloat offsetX=originalSize.width>contentSize.width?(originalSize.width-contentSize.width)/2:0;
    CGFloat offsetY=originalSize.height>contentSize.height?(originalSize.height-contentSize.height)/2:0;
    
    _imageView.center=CGPointMake(contentSize.width/2+offsetX, contentSize.height/2+offsetY);
}

@end
