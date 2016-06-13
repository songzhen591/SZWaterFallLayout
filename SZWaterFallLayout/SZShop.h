//
//  SZShop.h
//  SZWaterFallLayout
//
//  Created by 又土又木 on 16/6/13.
//  Copyright © 2016年 ytuymu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SZShop : NSObject

@property (nonatomic, strong) NSNumber *h; // 高度
@property (nonatomic, strong) NSNumber *w; // 宽度
@property (nonatomic, copy) NSString *img; // 图片urlString
@property (nonatomic, copy) NSString *price; // 价格

@end
