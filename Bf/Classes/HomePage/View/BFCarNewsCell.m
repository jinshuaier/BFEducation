//
//  BFCarNewsCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/24.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarNewsCell.h"

@interface BFCarNewsCell()

@property (nonatomic, strong) UILabel *carMainTitle;
@property (nonatomic, strong) UILabel *carTextTitle;
@property (nonatomic, strong) UIImageView *carMovie;
@property (nonatomic, strong) UILabel *carVideoSize;
@property (nonatomic, strong) UIView *blackBGView;
@end

@implementation BFCarNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.carImage];
        [self.contentView addSubview:self.blackBGView];
        [self.contentView addSubview:self.carMainTitle];
        [self.contentView addSubview:self.carTextTitle];
//        [self addSubview:self.carMovie];
//        [self addSubview:self.carVideoSize];
    }
    return self;
}

-(void)setDataModel:(BFCarNewsModel *)dataModel {
    _dataModel = dataModel;
    [self.carImage sd_setImageWithURL:[NSURL URLWithString:_dataModel.nCImg] placeholderImage:PLACEHOLDER];
    self.carMainTitle.text = _dataModel.pTitle;
    self.carTextTitle.text = [NSString stringWithFormat:@"一 %@ 一",_dataModel.pDesc];
}

-(void)layoutSubviews {
    self.carImage.frame = CGRectMake(10, 10, KScreenW - 20, 190);
    self.blackBGView.frame = CGRectMake(10, 10, KScreenW - 20, 190);
    self.carMainTitle.frame = CGRectMake(20, 83, KScreenW - 40, 30);
    self.carTextTitle.frame = CGRectMake(20, self.carMainTitle.bottom + 10, KScreenW - 40, 20);
    self.carMovie.frame = CGRectMake(20, self.carImage.bottom - 40, 30, 30);
    self.carVideoSize.frame = CGRectMake(self.carMovie.right + 10, self.carImage.bottom - 40, 60, 30);
    
}

-(UIImageView *)carImage {
    if (_carImage == nil) {
        _carImage = [[UIImageView alloc] init];
        _carImage.image = [UIImage imageNamed:@"组3"];
        _carImage.layer.masksToBounds = YES;
        _carImage.layer.cornerRadius = 4;
    }
    return _carImage;
}

- (UIView *)blackBGView{
    if (!_blackBGView) {
        _blackBGView = [[UIView alloc] init];
        _blackBGView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        _blackBGView.layer.masksToBounds = YES;
        _blackBGView.layer.cornerRadius = 4;
    }
    return _blackBGView;
}

-(UILabel *)carMainTitle {
    if (_carMainTitle == nil) {
        _carMainTitle = [[UILabel alloc] init];
        _carMainTitle.text = @"没有数据啦";
        _carMainTitle.font = [UIFont fontWithName:BFfont size:14.0f];
        _carMainTitle.textColor = RGBColor(255, 255, 255);
        _carMainTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _carMainTitle;
}

-(UILabel *)carTextTitle {
    if (_carTextTitle == nil) {
        _carTextTitle = [[UILabel alloc] init];
        _carTextTitle.text = @"没有分类啦";
        _carTextTitle.font = [UIFont fontWithName:BFfont size:11.0f];
        _carTextTitle.textColor = RGBColor(255, 255, 255);
        _carTextTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _carTextTitle;
} 

-(UIImageView *)carMovie {
    if (_carMovie == nil) {
        _carMovie = [[UIImageView alloc] init];
        _carMovie.image = [UIImage imageNamed:@"video"];
    }
    return _carMovie;
}

-(UILabel *)carVideoSize {
    if (_carVideoSize == nil) {
        _carVideoSize = [[UILabel alloc] init];
        _carVideoSize.text = @"3.5M";
        _carVideoSize.textColor = RGBColor(255, 255, 255);
        _carVideoSize.font = [UIFont fontWithName:BFfont size:12.0f];
        _carVideoSize.textAlignment = NSTextAlignmentLeft;
    }
    return _carVideoSize;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
