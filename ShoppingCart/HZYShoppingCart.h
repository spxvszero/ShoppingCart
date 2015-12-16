//
//  HZYShoppingCart.h
//  ShoppingCart
//
//  Created by jacky on 15/12/15.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HZYShoppingItem.h"

@interface HZYShoppingCart : NSObject

@property (nonatomic,strong) NSMutableDictionary *cart;
//添加商品
- (void)addItem:(HZYShoppingItem *)item;
//根据商品名删除指定商品
- (void)removeItemWithName:(NSString *)name;
//列出购物车中所有的商品
- (NSArray *)listAllItems;
//清理购物车，将标记为删除和数量为0的商品删除
- (void)cleanCart;

//单例
+(instancetype)sharedShoppingCart;

@end
