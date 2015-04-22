//
//  VideoCell.h
//  实战4.8
//
//  Created by 杨浩宇 on 15/4/20.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VideoCell;

@protocol VideoCellDelegate <NSObject>

-(void) imageTap1:(VideoCell *) cell;

@end

@interface VideoCell : UITableViewCell
@property (assign,nonatomic) id<VideoCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIImageView *playIconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
