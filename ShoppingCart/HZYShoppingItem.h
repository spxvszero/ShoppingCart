//
//  HZYShoppingItem.h
//  ShoppingCart
//
//  Created by jacky on 15/12/14.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZYShoppingItem : NSObject

@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,assign) NSInteger number;
//追求动画效果
@property (nonatomic,weak) NSIndexPath *iP;
//删除标志位
@property (nonatomic,assign) BOOL canDelete;

+ (instancetype)itemWithName:(NSString *)name andNumber:(NSInteger)num;
+ (instancetype)itemWithName:(NSString *)name;

- (NSInteger)addItem;
- (NSInteger)removeItem;

@end
