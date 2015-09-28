//
//  ZLShopCell.m
//  ZLWaterFlow
//
//  Created by 张璐 on 15/9/26.
//  Copyright (c) 2015年 张璐. All rights reserved.
//

#import "ZLShopCell.h"
#import "UIImageView+WebCache.h"
@interface ZLShopCell ()

@property(nonatomic,weak)UIImageView * shopView;
@property (nonatomic,weak) UILabel * priceLabel;
@end

@implementation ZLShopCell

-(void)setShop:(ZLShop *)shop
{
    _shop = shop;
    //设置商品图片
    NSURL * imageUrl = [NSURL URLWithString:shop.img];
    [self.shopView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
    //设置商品价格
    self.priceLabel.text = shop.price;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UIImageView * shopView = [[UIImageView alloc]init];
        self.shopView = shopView;
        [self.contentView addSubview:shopView];
        UILabel * priceLabel = [[UILabel alloc]init];
        priceLabel.backgroundColor = [UIColor lightGrayColor];
        priceLabel.alpha = 0.7;
        self.priceLabel = priceLabel;
        [self.contentView addSubview:priceLabel];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.shopView.frame = self.bounds;
    CGFloat priceLabelH = 30;
    self.priceLabel.frame = CGRectMake(0, self.frame.size.height - priceLabelH, self.frame.size.width, priceLabelH);
}

@end
