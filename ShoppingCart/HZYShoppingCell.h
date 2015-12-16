//
//  HZYShoppingCell.h
//  ShoppingCart
//
//  Created by jacky on 15/12/14.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZYShoppingCell;

@protocol HZYShoppingCellDelegate <NSObject>

- (void)shoppingCellBuyClick:(HZYShoppingCell *)cell;

@end


@interface HZYShoppingCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (nonatomic,weak) id<HZYShoppingCellDelegate> delegate;

@end
