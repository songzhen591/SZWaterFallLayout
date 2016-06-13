//
//  SZWaterFallLayout.h
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SZWaterFallLayout;
@protocol SZWaterFallLayoutDelegate <NSObject>

// 返回index位置下的item的高度
- (CGFloat)waterFallLayout:(SZWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width;

@end

@interface SZWaterFallLayout : UICollectionViewLayout

@property (assign, nonatomic) id <SZWaterFallLayoutDelegate> delegate;

@end
