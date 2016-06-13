//
//  SZShopCell.m
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import "SZShopCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation SZShopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setShop:(SZShop *)shop
{
    _shop = shop;
    [self.shopImageView sd_setImageWithURL:[NSURL URLWithString:shop.img]];
}

@end
