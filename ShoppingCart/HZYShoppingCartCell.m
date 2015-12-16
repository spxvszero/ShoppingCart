//
//  HZYShoppingCartCell.m
//  ShoppingCart
//
//  Created by jacky on 15/12/15.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "HZYShoppingCartCell.h"
#import "HZYShoppingCart.h"


@interface HZYShoppingCartCell ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *itemNumberText;
@property (weak, nonatomic) IBOutlet UIButton *itemAdd;
@property (weak, nonatomic) IBOutlet UIButton *itemRemove;

@end

@implementation HZYShoppingCartCell

- (void)awakeFromNib {
    // Initialization code
    self.itemNumberText.delegate = self;
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(editting) name:@"editting" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitEditting) name:@"endEditting" object:nil];
}

/**
 * 进入编辑模式
 */
- (void)editting
{
    NSLog(@"进入编辑状态");
    
    self.itemNumber.hidden = YES;
    
    self.itemAdd.hidden = NO;
    self.itemRemove.hidden = NO;
    self.itemNumberText.hidden = NO;
    
    self.itemNumberText.text = self.itemNumber.text;
    
    CGAffineTransform trans = CGAffineTransformMakeTranslation(50, 0);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.itemSelect.transform = trans;
        self.itemTitle.transform = trans;
    }];
    
}

/**
 * 退出编辑模式
 */
- (void)exitEditting
{
    NSLog(@"退出编辑状态");
    
    self.itemNumber.hidden = NO;
    
    self.itemAdd.hidden = YES;
    self.itemRemove.hidden = YES;
    self.itemNumberText.hidden = YES;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.itemSelect.transform = CGAffineTransformIdentity;
        self.itemTitle.transform = CGAffineTransformIdentity;
    }];
}

//如果结束编辑，未输入的话，将之前的数量返回
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        textField.text = self.itemNumber.text;
    }
}

- (void)setItem:(HZYShoppingItem *)item
{
    _item = item;
    self.itemNumber.text = [NSString stringWithFormat:@"%ld",item.number];
    self.itemTitle.text = item.itemName;
    //根据item初始化selected
    self.itemSelect.selected = self.item.canDelete;
}

#pragma mark - 按钮事件

- (IBAction)selectBtnClick:(id)sender {
    
    self.itemSelect.selected = !self.itemSelect.selected;
    if (self.itemSelect.selected) {
        self.item.canDelete = YES;
    }else{
        self.item.canDelete = NO;
    }
    
}

/**
 * 增加商品数量
 */
- (IBAction)addItem:(id)sender {
    NSInteger num;
    if (self.itemNumberText.text.length!=0) {
        num = [self.itemNumberText.text integerValue];
    }else{
        num = self.itemNumber.text.integerValue;
    }
    num++;
    self.item.number++;
    self.itemNumberText.text = [NSString stringWithFormat:@"%ld",num];
    self.itemNumber.text = self.itemNumberText.text;
}

/**
 * 减少商品数量
 */
- (IBAction)removeItem:(id)sender {
    NSInteger num;
    if (self.itemNumberText.text.length!=0) {
        num = [self.itemNumberText.text integerValue];
    }else{
        num = self.itemNumber.text.integerValue;
    }
    if (num<=0) {
        num = 0;
        self.item.number = 0;
    }else{
        num--;
        self.item.number--;
    }
    if (num == 0) {
        self.itemSelect.selected = YES;
        self.item.canDelete = YES;
    }
    self.itemNumberText.text = [NSString stringWithFormat:@"%ld",num];
    self.itemNumber.text = self.itemNumberText.text;
}

#pragma mark - dealloc
- (void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
