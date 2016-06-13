//
//  ViewController.m
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import "ViewController.h"
#import "SZWaterFallLayout.h"
#import "SZShopCell.h"
#import "SZShop.h"
#import <MJExtension/MJExtension.h>

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, SZWaterFallLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) NSMutableArray *shops;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.collectionView];
}

- (NSMutableArray *)shops
{
    if (_shops) {
        return _shops;
    }
    _shops = [SZShop mj_objectArrayWithFilename:@"0.plist"];
    return _shops;
}

- (UICollectionView *)collectionView
{
    if (_collectionView) {
        return _collectionView;
    }
    SZWaterFallLayout *layout = [[SZWaterFallLayout alloc] init];
    layout.delegate = self;
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.alwaysBounceVertical = YES;
    
    [_collectionView registerNib:[UINib nibWithNibName:@"SZShopCell" bundle:nil] forCellWithReuseIdentifier:@"SZShopCell"];
    
    return _collectionView;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SZShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SZShopCell" forIndexPath:indexPath];
    SZShop *shop = self.shops[indexPath.row];
    cell.shop = shop;
    return cell;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.shops.count;
}

- (CGFloat)waterFallLayout:(SZWaterFallLayout *)waterFallLayout heightForItemAtIndex:(NSUInteger)index width:(CGFloat)width
{
    SZShop *shop = self.shops[index];
    CGFloat shopHeight = [shop.h doubleValue];
    CGFloat shopWidth = [shop.w doubleValue];
    return shopHeight * width / shopWidth;
}

@end
