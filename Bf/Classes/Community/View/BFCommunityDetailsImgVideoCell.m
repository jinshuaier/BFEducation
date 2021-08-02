//
//  BFCommunityDetailsImgVideoCell.m
//  NewTest
//
//  Created by 春晓 on 2017/12/2.
//  Copyright © 2017年 春晓. All rights reserved.
//

#import "BFCommunityDetailsImgVideoCell.h"

@interface BFCommunityDetailsImgVideoCell ()
// 播放视频
@property (nonatomic , strong) UIImageView *playVideoImageView;

@end

@implementation BFCommunityDetailsImgVideoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self layout];
    }
    return self;
}

- (void)setupUI{
    _imgVideoImageView = [[UIImageView alloc] init];
    _imgVideoImageView.contentMode = UIViewContentModeScaleAspectFill;
    _imgVideoImageView.clipsToBounds = YES;
    _imgVideoImageView.userInteractionEnabled = YES;
    _imgVideoImageView.layer.masksToBounds = YES;
    _imgVideoImageView.layer.cornerRadius = 6;
    [self.contentView addSubview:_imgVideoImageView];
    _playVideoImageView = [[UIImageView alloc] init];
    _playVideoImageView.image = [UIImage imageNamed:@"视频-2"];
    _playVideoImageView.userInteractionEnabled = NO;
    [self.contentView addSubview:_playVideoImageView];
    _bottomTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(PXTOPT(20), 30, KScreenW - PXTOPT(20) - PXTOPT(20), PXTOPT(80))];
    _bottomTextLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self.contentView addSubview:_bottomTextLabel];
    _bottomTextLabel.numberOfLines = 0;
    _bottomTextLabel.textColor = [UIColor whiteColor];

    // 两个角切圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_bottomTextLabel.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(PXTOPT(12), PXTOPT(12))];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _bottomTextLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    _bottomTextLabel.layer.mask = maskLayer;
}

- (void)layout{
    _imgVideoImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(10))
    .bottomSpaceToView(self.contentView, PXTOPT(10));
    
    _playVideoImageView.sd_layout
    .widthIs(40)
    .heightIs(40)
    .centerXIs(KScreenW / 2.0)
    .centerYIs(PXTOPT(400 / 2.0));
    
    _bottomTextLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .bottomSpaceToView(self.contentView, PXTOPT(10))
    .heightIs(PXTOPT(80));
}

- (void)setIsVideo:(BOOL)isVideo{
    _isVideo = isVideo;
    if (_isVideo) {
        _playVideoImageView.hidden = NO;
        _bottomTextLabel.hidden = YES;
    }else{
        _playVideoImageView.hidden = YES;
        _bottomTextLabel.hidden = NO;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
