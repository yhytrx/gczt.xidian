//
//  ChapterOfCourseTableViewController.m
//  实战4.1
//
//  Created by 杨浩宇 on 15/4/8.
//  Copyright (c) 2015年 杨浩宇. All rights reserved.
//

#import "ChapterOfCourseTableViewController.h"
#import "Cell1.h"
#import "Cell2.h"
#import "VideoViewController.h"
#import "ImageViewController.h"


@interface ChapterOfCourseTableViewController ()
@property (strong,nonatomic) NSArray *datalist;
@property (strong,nonatomic) NSArray *subtitleArray;
@property (strong,nonatomic) NSArray *plist;
@property (strong,nonatomic) NSIndexPath *selectIndexPath;
@property (nonatomic) BOOL isOpen;
@end

@implementation ChapterOfCourseTableViewController
#pragma mark - 写入plist里的数据
-(NSString *)savePath {
    
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *str = [array firstObject];
    NSString *path = [str stringByAppendingPathComponent:@"data.plist"];
    
    //最后一步：把plist数据写入path中
    [self.plist writeToFile:path atomically:YES];
    NSLog(@"%@",path);
    return path;
}
-(NSArray *) plist {
#warning 需要优化，惰性初始化？
    //if (!_plist) {
        //plist，在这个方法里，定义为一个可变数组
        NSMutableArray *plist = [[NSMutableArray alloc]init];
        
        for (int i = 1; i <= 10; i++) {
            NSArray *content = @[@"章节知识",@"例题解析",@"习题集",@"共享资料"];
            NSString *titleOfChapter = [NSString stringWithFormat:@"第%d章",i ];
            NSDictionary *chapter = @{@"title":titleOfChapter,@"subtitle":self.subtitleArray[i-1],@"content":content };
            
            [plist addObject:chapter];
        }
    //}
    return plist;
}

-(NSArray *)subtitleArray {
    _subtitleArray = @[@"制图的基本知识",@"投影法及点、直线和平面的投影",@"立体、截交线及切口",@"相贯线",@"组合体",@"轴测图",@"机件的各种表达方法",@"标准件",@"常用件",@"零件图"];
    return _subtitleArray;
}

#pragma mark - TableView Delegate
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //当第一个被选中时,即大标题
    if (indexPath.row == 0) {
        //此次选中的，与上次选中的一样吗
        if ([indexPath isEqual:self.selectIndexPath]) {
            //一样
            self.isOpen = NO;
            [self firstSelectIsOpen:NO secondSelectIsOpen:NO];
            self.selectIndexPath = nil;
            //不一样
        } else {
                //不一样的原因是因为这是用户第一次选中某一行吗
            if (!self.selectIndexPath) {
                //是
                self.selectIndexPath = indexPath;
                [self firstSelectIsOpen:YES secondSelectIsOpen:NO];
                //不是
            } else {
                
                [self firstSelectIsOpen:NO secondSelectIsOpen:YES];
            }
        }
    //其他cell被选中
    } else {
        //当content中第一个被选中时，进入播放视频界面
        if (indexPath.row == 1) {
            VideoViewController *videoVC = [[VideoViewController alloc]init];
            [self.navigationController pushViewController:videoVC animated:YES];
        } else if (indexPath.row == 2) {
            ImageViewController *imageVC = [[ImageViewController alloc]init];
            [self.navigationController pushViewController:imageVC animated:YES];
        }
        
    }
}


-(void) firstSelectIsOpen:(BOOL)firstDoInsert
       secondSelectIsOpen:(BOOL)secondDoInsert {
    //如果要被展开，那么 isOpen 的值就为 yes
    //如果不被展开，那么 isOpen 的值就为 no
    self.isOpen = firstDoInsert;
    
    Cell1 *cell = (Cell1 *) [self.tableView cellForRowAtIndexPath:self.selectIndexPath];
    //cell中显示是否展开的图片，跟随 firstDoinsert 的值而变
    [cell changeArrowWithUp:firstDoInsert];

//铺垫工作
    //在第几个section插入
    NSInteger section = self.selectIndexPath.section;
    
    //要展开的这个section，有多少内容需要展示
    NSInteger contentCount = [[[self.datalist objectAtIndex:section] objectForKey:@"content"] count];
        
    //找到一组插入的路径
    //为了调用一次 插入/删除 一组cells的方法
    NSMutableArray *rowToInsert = [[NSMutableArray alloc] init];
    for (NSUInteger i = 1; i <= contentCount; i++) {
            NSIndexPath *indexPathToInsert = [NSIndexPath indexPathForRow:i inSection:section];
            [rowToInsert addObject:indexPathToInsert];
    }
    
        
//开始插入 或 删除
    if (firstDoInsert){
        //一次插入一组cells，内容会从data source方法里找
        [self.tableView insertRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    } else {
        //不展开时，删除cells
        [self.tableView deleteRowsAtIndexPaths:rowToInsert withRowAnimation:UITableViewRowAnimationTop];
    }
    
    if (secondDoInsert) {
        //更新isOpen
        self.isOpen = YES;
//当第二个需要被展开时，更新当前的selectIndexPath，然后调用前面的方法
        //更新selectIndex的地址
        self.selectIndexPath = [self.tableView indexPathForSelectedRow];
        //调用前面方法
        [self firstSelectIsOpen:YES secondSelectIsOpen:NO];
    }
}

#pragma mark - life cycle
- (void) viewDidLoad {
    [super viewDidLoad];

    _datalist = [[NSMutableArray alloc] initWithContentsOfFile:[self savePath]];
    
    self.navigationItem.title = @"章节列表";
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return [self.datalist count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

        //isOpen == YES 时，当前section的行数为 自身题目占用的一行，以及list中东西所要占用的行数
        if (self.isOpen) {
            if (self.selectIndexPath.section == section) {
                return [[[self.datalist objectAtIndex:section] objectForKey:@"content"] count]+1;;
            }
        }
        //isOpen == NO 时，每个section只有一行。
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //设置每行的高度
    if (indexPath.row == 0) {
        return 50;
    } else {
        return 40;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //如果当前有一项是被展开的（不知道是哪一项） &&  且之前记录的，选中的selectIndexPath与当前的询问datasource的cell的路径一样 （是当前这一样是展开的）
    // && 且寻求datasource的cell不是每个section的第一个cell
    if (self.isOpen && self.selectIndexPath.section == indexPath.section&&indexPath.row!=0) {
        static NSString *CellIdentifier = @"Cell2";
        Cell2 *cell = (Cell2*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
#warning  一般是在哪加载？这里用注册可以吗？
        //如果没有，则加载
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        
        NSArray *list = [[self.datalist objectAtIndex:self.selectIndexPath.section] objectForKey:@"content"];
        //因为section中第一行是cell1，所以最后要减去一行
        cell.titleLabel.text = [list objectAtIndex:indexPath.row-1];
        
        return cell;
    } else {
#warning 静态变量可以改内容？
        static NSString *CellIdentifier = @"Cell1";
        Cell1 *cell = (Cell1*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = [[[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil] objectAtIndex:0];
        }
        NSString *title = [[[self.datalist objectAtIndex:indexPath.section] objectForKey:@"title"] stringByAppendingString:@"  "];
        NSString *subtitle = [[self.datalist objectAtIndex:indexPath.section] objectForKey:@"subtitle"];
        cell.titleLabel.text = [title stringByAppendingString:subtitle];
        
        [cell changeArrowWithUp:([self.selectIndexPath isEqual:indexPath]?YES:NO)];
        return cell;
    }

}






@end
