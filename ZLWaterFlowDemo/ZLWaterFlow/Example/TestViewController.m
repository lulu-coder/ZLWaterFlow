//
//  TestViewController.m
//  ZLWaterFlow
//
//  Created by 张璐 on 15/9/26.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "TestViewController.h"
#import "MJExtension.h"
#import "ZLShop.h"
#import "ZLWaterFlowLayout.h"
#import "ZLShopCell.h"
#define ID @"shopCell"
@interface TestViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,ZLWaterFlowLayoutDelegate>

@property(nonatomic,strong)NSMutableArray * totalShopsArray;
@property (nonatomic,weak) UICollectionView * collectionView;
@end

@implementation TestViewController


-(NSMutableArray *)totalShopsArray
{
    if (!_totalShopsArray) {
        self.totalShopsArray = [NSMutableArray array];
    }
    return _totalShopsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray * shopsArray = [ZLShop objectArrayWithFilename:@"shop.plist"];
    [self.totalShopsArray addObjectsFromArray:shopsArray];
    ZLWaterFlowLayout * layout = [[ZLWaterFlowLayout alloc]init];
    layout.delegate = self;
    //layout.columnCount = 2;
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [collectionView registerClass:[ZLShopCell class] forCellWithReuseIdentifier:ID];
    collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
    
    
}

-(CGFloat)waterFlowLayout:(ZLWaterFlowLayout *)layout width:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath
{
    ZLShop * shop = self.totalShopsArray[indexPath.item];
    return shop.h/shop.w * width;
}

#pragma mark -

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.totalShopsArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZLShopCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.shop = self.totalShopsArray[indexPath.item];
    return cell;
}

@end
