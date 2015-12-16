//
//  ViewController.m
//  ShoppingCart
//
//  Created by jacky on 15/12/13.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "ViewController.h"
#import "HZYShoppingCell.h"
#import "HZYShoppingCartViewController.h"
#import "HZYShoppingItem.h"
#import "Masonry.h"
#import "HZYShoppingCart.h"

@interface ViewController ()<HZYShoppingCellDelegate>

//购物车
@property (strong, nonatomic) UIButton *shoppingCartBtn;
//商品数目
@property (nonatomic,strong) UIButton *bubble;
//购物的内容
@property (nonatomic,strong) HZYShoppingCart *shoppingCart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addSubviews];
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.shoppingCart.listAllItems.count) {
        self.bubble.hidden = YES;
    }else{
        [self.bubble setTitle:[NSString stringWithFormat:@"%ld",self.shoppingCart.listAllItems.count] forState:UIControlStateNormal];
    }
}

#pragma mark - 子控件

- (void)addSubviews
{
    [self addCart];
    [self addBubble];
}

- (void)addCart
{
    //加载购物车按钮
    self.shoppingCartBtn = [[UIButton alloc] init];
    [self.shoppingCartBtn setImage:[UIImage imageNamed:@"shoppingCart"] forState:UIControlStateNormal];
    [self.shoppingCartBtn addTarget:self action:@selector(cartClick:) forControlEvents:UIControlEventTouchUpInside];
    self.shoppingCartBtn.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBarButtonItem *img = [[UIBarButtonItem alloc] initWithCustomView:self.shoppingCartBtn];
    self.navigationItem.rightBarButtonItem = img;
    
    [self.shoppingCartBtn sizeToFit];
}

- (void)addBubble
{
    //添加气泡
    [self.bubble setBackgroundImage:[UIImage imageNamed:@"bubble"] forState:UIControlStateNormal];
    [self.bubble setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.bubble.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.shoppingCartBtn addSubview:self.bubble];
    self.bubble.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.bubble.center = CGPointMake(0, 0);
    [self.bubble sizeToFit];
    self.bubble.hidden = YES;
    self.bubble.layer.anchorPoint = CGPointMake(1, 1);
    self.bubble.userInteractionEnabled = NO;
}

#pragma mark - 响应事件

//跳转到购物车查看界面
- (void)cartClick:(id)sender {
    [self.navigationController pushViewController:[[HZYShoppingCartViewController alloc] init] animated:YES];
}


/**
 * 按钮动画
 */
- (void)cartAniamtion{
    
    CAKeyframeAnimation *anim = [[CAKeyframeAnimation alloc] init];
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(0),@(M_PI_4 * 0.25),@(0),@(-M_PI_4 * 0.25),@(0)];
    anim.duration = 0.25;
    
    [self.shoppingCartBtn.imageView.layer addAnimation:anim forKey:nil];
}

/**
 * 气泡动画
 */
- (void)bubbleAnimation{
    CASpringAnimation *anim = [[CASpringAnimation alloc] init];
    anim.keyPath = @"transform.scale";
    anim.fromValue = @(0.01);
    anim.toValue = @(1);
    anim.duration = 0.5;
    [self.bubble.layer addAnimation:anim forKey:nil];
}


#pragma mark - tableView Delegate

/**
 * 禁用cell的选中效果
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HZYShoppingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shoppingCell"];
    
    cell.label.text = [NSString stringWithFormat:@"苹果%ld代",indexPath.row];
    cell.delegate = self;
    
    return cell;
}

/**
 * cell代理
 */
- (void)shoppingCellBuyClick:(HZYShoppingCell *)cell
{
    //动画
    [self cartAniamtion];
    
    if (self.shoppingCart.cart[cell.label.text] != nil) {
        [self.shoppingCart.cart[cell.label.text] addItem];
        return;
    }
    
    //没有则新建商品并加入到数组中
    HZYShoppingItem *item = [HZYShoppingItem itemWithName:cell.label.text];
    [self.shoppingCart.cart setValue:item forKey:cell.label.text];
    
    [self.bubble setTitle:[NSString stringWithFormat:@"%ld",self.shoppingCart.listAllItems.count] forState:UIControlStateNormal];
    self.bubble.hidden = NO;
    [self.bubble sizeToFit];
    [self bubbleAnimation];
}

#pragma mark - 懒加载
-(HZYShoppingCart *)shoppingCart
{
    if (_shoppingCart == nil) {
        _shoppingCart = [HZYShoppingCart sharedShoppingCart];
    }
    return _shoppingCart;
}

- (UIButton *)bubble
{
    if (_bubble == nil) {
        _bubble = [[UIButton alloc] init];
    }
    return _bubble;
}

@end
