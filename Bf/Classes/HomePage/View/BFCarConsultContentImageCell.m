//
//  BFCarConsultContentImageCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/14.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCarConsultContentImageCell.h"

@interface BFCarConsultContentImageCell ()
// 播放视频
@property (nonatomic , strong) UIImageView *playVideoImageView;
@end

@implementation BFCarConsultContentImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = YES;
    [self.contentView addSubview:_contentImageView];
    _contentImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(25))
    .topSpaceToView(self.contentView, PXTOPT(10))
    .rightSpaceToView(self.contentView, PXTOPT(25))
    .bottomSpaceToView(self.contentView, PXTOPT(10));
    _playVideoImageView = [[UIImageView alloc] init];
    _playVideoImageView.image = [UIImage imageNamed:@"视频-2"];
    [self.contentView addSubview:_playVideoImageView];
    _playVideoImageView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .centerXIs(KScreenW / 2.0)
    .centerYIs(PXTOPT(200 / 2.0));
}

- (void)setIsVideo:(BOOL)isVideo{
    _isVideo = isVideo;
    if (_isVideo) {
        _playVideoImageView.hidden = NO;
    }else{
        _playVideoImageView.hidden = YES;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
