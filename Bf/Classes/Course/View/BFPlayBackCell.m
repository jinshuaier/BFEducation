//
//  BFPlayBackCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPlayBackCell.h"
#import <Masonry.h>

@interface BFPlayBackCell ()
// 直播间图片
@property (nonatomic , strong) UIImageView *imgView;
// 直播Id
@property (nonatomic , strong) UILabel *liveIdLabel;
// 回放Id
@property (nonatomic , strong) UILabel *backIdLabel;

@end

@implementation BFPlayBackCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [self.contentView addSubview:_imgView];
        _liveIdLabel = [self createALabel];
        _backIdLabel = [self createALabel];
        [self layout];
    }
    return self;
}

- (void)layout{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(CCGetRealFromPt(20));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(100), CCGetRealFromPt(100)));
        make.top.equalTo(self.contentView).with.offset(CCGetRealFromPt(20));
    }];
    [_liveIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).with.offset(CCGetRealFromPt(120));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(KScreenW - (CCGetRealFromPt(100)) - (CCGetRealFromPt(20)) - (CCGetRealFromPt(20))), CCGetRealFromPt(30)));
        make.top.equalTo(_imgView);
    }];
    [_backIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).with.offset(CCGetRealFromPt(120));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(KScreenW - (CCGetRealFromPt(100)) - (CCGetRealFromPt(20)) - (CCGetRealFromPt(20))), CCGetRealFromPt(30)));
        make.top.equalTo(_liveIdLabel).with.offset(CCGetRealFromPt(40));
    }];
}

- (UILabel *)createALabel{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    return label;
}

- (void)setPlayBack:(BFPlayBack *)playBack{
    if (_playBack) {
        _playBack = nil;
    }
    _playBack = playBack;
    _liveIdLabel.text = _playBack.live_id;
    _backIdLabel.text = _playBack.back_id;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
