//
//  SZShopCell.h
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZShop.h"

@interface SZShopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *shopImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopDescLabel;

@property (strong, nonatomic) SZShop *shop;

@end
