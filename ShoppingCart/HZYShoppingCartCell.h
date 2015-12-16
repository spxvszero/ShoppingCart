//
//  HZYShoppingCartCell.h
//  ShoppingCart
//
//  Created by jacky on 15/12/15.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZYShoppingItem.h"

@interface HZYShoppingCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemNumber;
@property (weak, nonatomic) IBOutlet UIButton *itemSelect;
@property (nonatomic,weak) HZYShoppingItem *item;
@end
