//
//  OtherTableViewController.m
//  实战4.8
//
//  Created by 杨浩宇 on 15/4/21.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "OtherTableViewController.h"
#import "WebViewController.h"

@interface OtherTableViewController ()



@end

@implementation OtherTableViewController

static NSString *otherSourceCell = @"otherSourceCell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:otherSourceCell];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSLog(@"%lu",(unsigned long)self.otherResourceList.count);
    return [self.otherResourceList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:otherSourceCell forIndexPath:indexPath];
    
    cell.textLabel.text = self.otherResourceList[indexPath.row];
    
    return cell;
}

#pragma mark - Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WebViewController *webVC = [[WebViewController alloc]init];
    webVC.otherSourcePath = self.otherResourceList[indexPath.row];
    [self.navigationController pushViewController:webVC animated:YES];
}


@end
