//
//  BFPlayLiveCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/22.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFPlayLiveCell.h"
#import <Masonry.h>

@interface BFPlayLiveCell ()
// 直播间图片
@property (nonatomic , strong) UIImageView *imgView;
// 直播间Id
@property (nonatomic , strong) UILabel *roomIdLabel;
// 直播间名字
@property (nonatomic , strong) UILabel *roomNameLabel;
// 直播间状态
@property (nonatomic , strong) UILabel *roomStateLabel;
@end

@implementation BFPlayLiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo"]];
        [self.contentView addSubview:_imgView];
        _roomNameLabel = [self createALabel];
        _roomIdLabel = [self createALabel];
        _roomStateLabel = [self createALabel];
        
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
    [_roomNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).with.offset(CCGetRealFromPt(120));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(KScreenW - (CCGetRealFromPt(100)) - (CCGetRealFromPt(20)) - (CCGetRealFromPt(20))), CCGetRealFromPt(30)));
        make.top.equalTo(_imgView);
    }];
    [_roomIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).with.offset(CCGetRealFromPt(120));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(KScreenW - (CCGetRealFromPt(100)) - (CCGetRealFromPt(20)) - (CCGetRealFromPt(20))), CCGetRealFromPt(30)));
        make.top.equalTo(_roomNameLabel).with.offset(CCGetRealFromPt(40));
    }];
    [_roomStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).with.offset(CCGetRealFromPt(120));
        make.size.mas_equalTo(CGSizeMake(CCGetRealFromPt(KScreenW - (CCGetRealFromPt(100)) - (CCGetRealFromPt(20)) - (CCGetRealFromPt(20))), CCGetRealFromPt(30)));
        make.top.equalTo(_roomIdLabel).with.offset(CCGetRealFromPt(40));
    }];
}

- (UILabel *)createALabel{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    [self.contentView addSubview:label];
    return label;
}

- (void)setPlayLive:(BFPlayLive *)playLive{
    if (_playLive) {
        _playLive = nil;
    }
    _playLive = playLive;
    _roomNameLabel.text = playLive.room_name;
    _roomStateLabel.text = playLive.room_zt;
    _roomIdLabel.text = playLive.room_id;
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
