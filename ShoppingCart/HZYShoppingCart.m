//
//  HZYShoppingCart.m
//  ShoppingCart
//
//  Created by jacky on 15/12/15.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "HZYShoppingCart.h"

@implementation HZYShoppingCart

- (void)addItem:(HZYShoppingItem *)item
{
    self.cart[item.itemName] = item;
}

- (void)removeItemWithName:(NSString *)name
{
    [self.cart removeObjectForKey:name];
}

- (NSArray *)listAllItems
{
    return self.cart.allValues;
}

- (NSMutableDictionary *)cart
{
    if (_cart == nil) {
        _cart = [NSMutableDictionary dictionary];
    }
    return _cart;
}

- (void)cleanCart
{
    for (HZYShoppingItem *item in self.cart.allValues) {
        if (item.canDelete || (item.number == 0)) {
            [self.cart removeObjectForKey:item.itemName];
        }
    }
}


#pragma mark - 单例

+(instancetype)sharedShoppingCart{
    return [[self alloc] init];
}

- (id)copyWithZone:(NSZone *)zone{
    return self;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

@end
