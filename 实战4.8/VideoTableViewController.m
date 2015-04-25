//
//  VideoTableViewController.m
//  实战4.8
//
//  Created by 杨浩宇 on 15/4/20.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "VideoTableViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VideoCell.h"

@interface VideoTableViewController () <VideoCellDelegate>
@property (nonatomic,strong) MPMoviePlayerViewController *moviePlayerViewController;
@end

@implementation VideoTableViewController

static NSString *CellIdentifier = @"VideoCell";

-(void) imageTap1:(VideoCell *) cell{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:CellIdentifier bundle:nil] forCellReuseIdentifier:CellIdentifier];
}



#pragma mark - Table view data source
/*
 *  返回cell
 *
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.videoList count];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    VideoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    cell.videoImage.image = [UIImage imageNamed:@"gct"];
    cell.titleLabel.text = self.videoList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

#pragma mark - delegate
/*
 *  用户点击之后
 *
 */
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _moviePlayerViewController=nil;//保证每次点击都重新创建视频播放控制器视图，避免再次点击时由于不播放的问题
#warning get url 应该改在其他地方
    //get url
    NSString *documentDirectory =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask , YES) firstObject];
    NSString *urlStr = [documentDirectory stringByAppendingPathComponent:self.videoList[indexPath.row]];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    // play
    _moviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [self addNotification];
    
    [self presentMoviePlayerViewControllerAnimated:self.moviePlayerViewController];
}

/**
 *  添加通知监控媒体播放控制器状态
 */
-(void)addNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.moviePlayerViewController.moviePlayer];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:self.moviePlayerViewController.moviePlayer];
    
}
/**
 *  播放状态改变，注意播放完成时的状态是暂停
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
    switch (self.moviePlayerViewController.moviePlayer.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"正在播放...");
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停播放.");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止播放.");
            break;
        default:
            NSLog(@"播放状态:%li",self.moviePlayerViewController.moviePlayer.playbackState);
            break;
    }
}
/**
 *  播放完成
 *
 *  @param notification 通知对象
 */
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    NSLog(@"播放完成.%li",self.moviePlayerViewController.moviePlayer.playbackState);
}

@end
