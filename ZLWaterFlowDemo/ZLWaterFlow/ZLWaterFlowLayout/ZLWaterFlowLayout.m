//
//  ZLWaterFlowLayout.m
//  ZLWaterFlow
//
//  Created by 张璐 on 15/9/26.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "ZLWaterFlowLayout.h"

@interface ZLWaterFlowLayout ()
@property(nonatomic,strong)NSMutableArray * attrsArray;
@property(nonatomic,strong)NSMutableDictionary * maxYDict;
@end
@implementation ZLWaterFlowLayout

-(NSMutableArray *)attrsArray
{
    if (!_attrsArray) {
        self.attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

//@"0":@100
-(NSMutableDictionary *)maxYDict
{
    if (!_maxYDict) {
        self.maxYDict = [NSMutableDictionary dictionary];
    }
    return _maxYDict;
}

-(instancetype)init
{
    if (self = [super init]) {
        self.columnCount = 3;
        self.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        self.columnMargin = 10;
        self.rowMargin = 10;
    }
    return self;
    
}

-(void)prepareLayout
{
    [super prepareLayout];
    
    //清空最大的y值
    for (int i = 0;  i < self.columnCount; i++) {
        NSString * column = [NSString stringWithFormat:@"%d",i];
        self.maxYDict[column] = @(self.sectionInset.top);
        
    }
    
    //布局之前,计算所有item的属性
    [self.attrsArray removeAllObjects];
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (int i = 0; i < count; i++) {
        UICollectionViewLayoutAttributes * attrs = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attrs];
    }
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return self.attrsArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //假设最短的是第0列
    __block NSString * minColumn = @"0";
    //找出最短的一列
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] < [self.maxYDict[minColumn] floatValue]) {
            minColumn = column;
        }
        
    }];
    //计算尺寸
    CGFloat width = (self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right - self.columnMargin * (self.columnCount - 1))/self.columnCount;
    CGFloat height = [self.delegate waterFlowLayout:self width:width atIndexPath:indexPath];
    //计算位置
    CGFloat itemX = self.sectionInset.left + (width + self.columnMargin) * [minColumn intValue];
    CGFloat itemY = [self.maxYDict[minColumn] floatValue] + self.rowMargin;
    //更新这一列的最大y值
    self.maxYDict[minColumn] = @(itemY + height);
    
    //创建属性
    UICollectionViewLayoutAttributes * attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attrs.frame = CGRectMake(itemX, itemY, width, height);
    return attrs;
    
}

-(CGSize)collectionViewContentSize
{
    __block NSString * maxColumn = @"0";
    [self.maxYDict enumerateKeysAndObjectsUsingBlock:^(NSString * column, NSNumber * maxY, BOOL *stop) {
        if ([maxY floatValue] > [self.maxYDict[maxColumn] floatValue]) {
            maxColumn = column;
        }
        
    }];
    return CGSizeMake(0, [self.maxYDict[maxColumn] floatValue] + self.sectionInset.bottom);

}

@end
