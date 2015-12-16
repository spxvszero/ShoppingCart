//
//  HZYShoppingItem.m
//  ShoppingCart
//
//  Created by jacky on 15/12/14.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "HZYShoppingItem.h"

@implementation HZYShoppingItem

+ (instancetype)itemWithName:(NSString *)name andNumber:(NSInteger)num
{
    HZYShoppingItem *item = [[HZYShoppingItem alloc] init];
    item.itemName = name;
    item.number = num;
    return item;
}

+ (instancetype)itemWithName:(NSString *)name
{
    HZYShoppingItem *item = [[HZYShoppingItem alloc] init];
    item.itemName = name;
    item.number = 1;
    return item;
}

- (NSInteger)addItem
{
    return ++self.number;
}
- (NSInteger)removeItem
{
    return --self.number;
}

@end
