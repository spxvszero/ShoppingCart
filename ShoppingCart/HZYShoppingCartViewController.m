//
//  HZYShoppingCartViewController.m
//  ShoppingCart
//
//  Created by jacky on 15/12/14.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "HZYShoppingCartViewController.h"
#import "HZYShoppingItem.h"
#import "HZYShoppingCartCell.h"
#import "HZYShoppingCart.h"

@interface HZYShoppingCartViewController ()

@property (nonatomic,weak) UIButton *deleteBtn;

@end

@implementation HZYShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubview];
    self.tableView.rowHeight = 100;
    //预估行高，避免有cell未进入编辑状态
    self.tableView.estimatedRowHeight = 20;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 初始化
 */
- (void)addSubview
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(enterEdittingMode)];
}

/**
 * 进入编辑模式
 */
- (void)enterEdittingMode
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelEditting)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(confirmEditting)];
    
    //添加删除按钮
    UIButton *deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 40)];
    [deleteBtn addTarget:self action:@selector(deleteItem) forControlEvents:UIControlEventTouchUpInside];
    [deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
    [deleteBtn setBackgroundColor:[UIColor redColor]];
    [deleteBtn setTintColor:[UIColor whiteColor]];
    [self.view.window addSubview:deleteBtn];
    self.deleteBtn = deleteBtn;
    [UIView animateWithDuration:0.5 animations:^{
        deleteBtn.transform = CGAffineTransformMakeTranslation(0, -deleteBtn.frame.size.height);
    }];
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"editting" object:nil];
    
    //备份
    self.backupCart = [[HZYShoppingCart sharedShoppingCart].cart copy];
}

/**
 * 退出编辑模式
 */
- (void)exitEdittingMode
{
    [UIView animateWithDuration:0.5 animations:^{
        self.deleteBtn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [self.deleteBtn removeFromSuperview];
    }];
    
    [self.tableView endEditing:YES];
    //通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"endEditting" object:nil];
    [self addSubview];
}

//取消编辑，回退
- (void)cancelEditting
{
    [HZYShoppingCart sharedShoppingCart].cart = [self.backupCart mutableCopy];
    [self exitEdittingMode];
    NSIndexSet *section = [[NSIndexSet alloc] initWithIndex:0];
    [self.tableView reloadSections:section withRowAnimation:UITableViewRowAnimationBottom];
}

//确认编辑，覆盖备份
- (void)confirmEditting
{
    self.backupCart = [[HZYShoppingCart sharedShoppingCart].cart copy];
    [self exitEdittingMode];
}

//删除item
- (void)deleteItem
{
    NSLog(@"删除");
    NSMutableArray *deleteArr = [NSMutableArray array];
    for (HZYShoppingItem *item in [[HZYShoppingCart sharedShoppingCart] listAllItems]) {
        if (item.canDelete) {
            [deleteArr addObject:item.iP];
        }
    }
    if (deleteArr.count != 0) {
        [[HZYShoppingCart sharedShoppingCart] cleanCart];
        [self.tableView deleteRowsAtIndexPaths:deleteArr withRowAnimation:UITableViewRowAnimationBottom];
        //为了万恶的动画效果，消耗性能刷新indexPath
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }
}

/**
 * 滚动放弃编辑状态
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.tableView endEditing:YES];
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[HZYShoppingCart sharedShoppingCart] listAllItems].count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HZYShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HZYShoppingCartCell" owner:self options:nil] lastObject];
    }
    
    HZYShoppingItem *item = [[HZYShoppingCart sharedShoppingCart] listAllItems][indexPath.row];
    //为了万恶的动画设置的属性
    item.iP = indexPath;
    cell.item = item;
    
    return cell;
}

- (void)dealloc
{
    NSLog(@"删除了么");
}

@end
