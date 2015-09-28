//
//  ZLWaterFlowLayout.h
//  ZLWaterFlow
//
//  Created by 张璐 on 15/9/26.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLWaterFlowLayout;
@protocol ZLWaterFlowLayoutDelegate <NSObject>

//返回图片等比高度
-(CGFloat)waterFlowLayout:(ZLWaterFlowLayout *)layout width:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath;

@end
@interface ZLWaterFlowLayout : UICollectionViewLayout
/**
 *  瀑布流要显示的列数
 */
@property (nonatomic,assign) NSInteger columnCount;
/**
 *  section内边距
 */
@property (nonatomic,assign) UIEdgeInsets sectionInset;
/**
 *  列间距
 */
@property (nonatomic,assign) CGFloat columnMargin;
/**
 *  行间距
 */
@property (nonatomic,assign) CGFloat rowMargin;
/**
 *  代理
 */
@property (nonatomic,weak) id<ZLWaterFlowLayoutDelegate> delegate;

@end
