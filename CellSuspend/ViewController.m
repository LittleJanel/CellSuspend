//
//  ViewController.m
//  CellSuspend
//
//  Created by liudonghuan on 15/7/9.
//  Copyright (c) 2015年 liudonghuan. All rights reserved.
//

#import "ViewController.h"
#import "myTableViewCell.h"
@interface ViewController ()
@property(nonatomic,strong)UITableView *mainTableView;
@property(nonatomic,strong)UIView *suspendView;
@end

@implementation ViewController

- (instancetype)init{
    if (self = [super init]) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, 568)];
        _mainTableView.backgroundColor = [UIColor whiteColor];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        [self.view addSubview:_mainTableView];
        _suspendView = [[UIView alloc]initWithFrame:CGRectMake(0, -64, 320, 40)];
        _suspendView.hidden = YES;
        [self.view addSubview:_suspendView];

    }
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    myTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil)
    {
        cell = [[myTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    if (indexPath.row == 3) {
        cell.ifSuspend = YES;
    }
    if (cell.ifSuspend == YES) {
        //观察方式试了下没搞出来
        [cell addObserver:self forKeyPath:@"separatorInset" options:NSKeyValueObservingOptionNew context:nil];
    }
    cell.title.text = [NSString stringWithFormat:@"%@%d-%d",@"cell",indexPath.section,indexPath.row];
    cell.height = 40*indexPath.row;
    return cell;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //这里观察的presentationlayer没有东西，观察不到,动画的时候的presentationlayer是临时创建的
    NSLog(@"change:%@",change);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //目标cell对于tableview的高度
    CGRect rectInTableView = [_mainTableView rectForRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
    //目标cell对于某个view的高度
    CGRect rectInSuperview = [_mainTableView convertRect:rectInTableView toView:_mainTableView];
    //获取需要悬停的cell
    UITableViewCell *cell = [_mainTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:3 inSection:0]];
    UITableViewCell *cellCopy = [self duplicate:cell];
    if ((scrollView.contentOffset.y - rectInTableView.origin.y) > -60 && (scrollView.contentOffset.y - rectInTableView.origin.y)!= 0){
        
        [_suspendView addSubview:cellCopy];
        if (_suspendView.hidden == YES) {
            _suspendView.hidden = NO;
        }
        
        
    }
    if ((scrollView.contentOffset.y - rectInTableView.origin.y) < -60){
        if (_suspendView.hidden == NO) {
            _suspendView.hidden = YES;
            [cellCopy removeFromSuperview];
        }
    }
}

- (UIView*)duplicate:(UIView*)view
{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
