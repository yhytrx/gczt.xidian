//
//  ListOfCourseTableViewController.m
//  实战4.1
//
//  Created by 杨浩宇 on 15/4/8.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "ListOfCourseTableViewController.h"
#import "ChapterOfCourseTableViewController.h"

@interface ListOfCourseTableViewController ()

@end

@implementation ListOfCourseTableViewController
#pragma mark - TableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChapterOfCourseTableViewController *chapterOfCourse = [[ChapterOfCourseTableViewController alloc]initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:chapterOfCourse animated:YES];
}

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    //注册一个可复用的cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.navigationItem.title = @"课程列表" ;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    
    cell.textLabel.text = @"工程制图";
    cell.detailTextLabel.text = @"机电工程学院 2015年4月";
    cell.imageView.image = [UIImage imageNamed:@"gct"];
    
    return cell;
}

#warning 如何代码设置cell的一些东西？
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置每行的高度
    return 60;
}



@end
