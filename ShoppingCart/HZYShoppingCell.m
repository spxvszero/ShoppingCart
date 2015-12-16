//
//  HZYShoppingCell.m
//  ShoppingCart
//
//  Created by jacky on 15/12/14.
//  Copyright © 2015年 jacky. All rights reserved.
//

#import "HZYShoppingCell.h"


@interface HZYShoppingCell ()

@end

@implementation HZYShoppingCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)buyClick:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(shoppingCellBuyClick:)]) {
        [self.delegate shoppingCellBuyClick:self];
    }
}

@end
