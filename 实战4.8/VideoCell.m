//
//  VideoCell.m
//  实战4.8
//
//  Created by 杨浩宇 on 15/4/20.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "VideoCell.h"

@interface VideoCell()


@end
@implementation VideoCell

- (IBAction)startToPlay:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(imageTap1:)]) {
        [_delegate  imageTap1:self];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
