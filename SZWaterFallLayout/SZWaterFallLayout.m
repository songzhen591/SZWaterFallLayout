//
//  SZWaterFallLayout.m
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import "SZWaterFallLayout.h"

/** 默认参数 */
static const CGFloat SZDefaultColumnCount = 3; // 列数
static const CGFloat SZDefaultRowMargin = 10; // 行间距
static const CGFloat SZDefaultColumnMargin = 10; // 列间距
static const UIEdgeInsets SZDefaultEdgeInsets = {10, 10, 10, 10}; // edgeInsets

@interface SZWaterFallLayout ()

@property (strong, nonatomic) NSMutableArray *attrsArray;//cell布局属性

@property (strong, nonatomic) NSMutableArray *columnHeights;//每列高度数组

@property (assign, nonatomic) CGFloat maxY;//最大Y

@end

@implementation SZWaterFallLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    //初始化每列高度数组
    [self setupColumnHeightsArray];
    
    //初始化item布局属性数组
    [self setupAttrsArray];
    
    self.maxY = [self maxYWithColumnHeightsArray:self.columnHeights];
}

#pragma mark - 懒加载

- (NSMutableArray *)columnHeights
{
    if (_columnHeights == nil) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray
{
    if (_attrsArray == nil) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}


- (void)setupColumnHeightsArray
{
    [self.columnHeights removeAllObjects];
    
    //初始化
    for (NSInteger index = 0; index < SZDefaultColumnCount; index++) {
        [self.columnHeights addObject:@(SZDefaultEdgeInsets.top)];
    }
}

- (void)setupAttrsArray
{
    [self.attrsArray removeAllObjects];
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger index = 0; index < count; index++) {
        @autoreleasepool {
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
            [self.attrsArray addObject:att];
        }
    }
}

- (CGFloat)maxYWithColumnHeightsArray:(NSArray *)array
{
    __block CGFloat maxY = 0;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber  *_Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([heightNumber doubleValue] > self.maxY) {
            maxY = [heightNumber doubleValue];
        }
    }];
    return maxY;
}

- (CGSize)collectionViewContentSize
{
//    NSLog(@"%s", )
    return CGSizeMake(0, self.maxY + SZDefaultEdgeInsets.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //计算item的x， y， w， h
    CGFloat collectionViewW = self.collectionView.bounds.size.width;
    
    CGFloat width = (collectionViewW - SZDefaultEdgeInsets.left - SZDefaultEdgeInsets.right - (SZDefaultColumnCount - 1) * SZDefaultRowMargin) / SZDefaultColumnCount;
    
    //计算当前item应该摆在第几列，计算哪列最短
    __block NSUInteger minColomn = 0;
    __block CGFloat minHeight = MAXFLOAT;
    [self.columnHeights enumerateObjectsUsingBlock:^(NSNumber *  _Nonnull heightNumber, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat height = heightNumber.floatValue;
        if (minHeight > height) {
            minHeight = height;
            minColomn = idx;
        }
    }];
    
    CGFloat x = SZDefaultEdgeInsets.left + minColomn * (SZDefaultColumnCount + width);
    CGFloat y = minHeight+ SZDefaultRowMargin;
    
    CGFloat height = [self.delegate waterFallLayout:self heightForItemAtIndex:indexPath.item width:width];
    att.frame = CGRectMake(x, y, width, height);
    self.columnHeights[minColomn] = @(y + height);
    return att;
}


@end
