//
//  ZLShop.h
//  ZLWaterFlow
//
//  Created by 张璐 on 15/9/26.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLShop : NSObject
/**
 *  商品图片
 */
@property (nonatomic,copy) NSString * img;
/**
 *  商品价格
 */
@property (nonatomic,copy) NSString * price;
/**
 *  商品图片宽度
 */
@property (nonatomic,assign) CGFloat w;
/**
 *  商品图片高度
 */
@property (nonatomic,assign) CGFloat h;

@end
