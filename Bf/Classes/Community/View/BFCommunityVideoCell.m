//
//  BFCommunityVideoCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityVideoCell.h"
#import <SDAutoLayout.h>
#import "BFCollectionViewImgCell.h"

@interface BFCommunityVideoCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
// 头像
@property (nonatomic , strong) UIImageView *headImageView;
// 名字
@property (nonatomic , strong) UILabel *nameLabel;
// 时间
@property (nonatomic , strong) UILabel *timeLabel;
// 标题
@property (nonatomic , strong) UILabel *titleLabel;
// 正文
@property (nonatomic , strong) UILabel *contentLabel;
// 视频
@property (nonatomic , strong) UIImageView *videoImageView;
// 看过
@property (nonatomic , strong) UIButton *lookBtn;
// 评论
@property (nonatomic , strong) UIButton *discussBtn;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;

// 图片数组
@property (nonatomic , strong) NSMutableArray *imgArray;
@end


@implementation BFCommunityVideoCell{
    UIView *lineView;
    UIView *videoBGView;
    UIButton *playBtn;
    UIView *lineView1;
    UIView *lineView2;
}

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
    _headImageView = [[UIImageView alloc] init];
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = PXTOPT(68 / 2);
    [self.contentView addSubview:_headImageView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(26.0f)];
    _nameLabel.textColor = CCRGBColor(0, 169, 255);
    [self.contentView addSubview:_nameLabel];
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(20.0f)];
    _timeLabel.textColor = CCRGBColor(153, 153, 153);
    [self.contentView addSubview:_timeLabel];
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(32.0f)];
    _titleLabel.textColor = CCRGBColor(102, 102, 102);
    [self.contentView addSubview:_titleLabel];
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(28.0f)];
    _contentLabel.textColor = CCRGBColor(178, 178, 178);
    _contentLabel.numberOfLines = 0;
    [self.contentView addSubview:_contentLabel];
    
    videoBGView = [[UIView alloc] init];
    [self.contentView addSubview:videoBGView];
    _videoImageView = [[UIImageView alloc] init];
    [_videoImageView setContentMode:UIViewContentModeScaleAspectFill];
    _videoImageView.layer.masksToBounds = YES;
    _videoImageView.layer.cornerRadius = 6;
    _videoImageView.clipsToBounds = YES;
    _videoImageView.userInteractionEnabled = NO;
    videoBGView.userInteractionEnabled = NO;
    [videoBGView addSubview:_videoImageView];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playVideoAction)];
    [_videoImageView addGestureRecognizer:tap];
    
    playBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [playBtn setImage:[UIImage imageNamed:@"视频-2"] forState:(UIControlStateNormal)];
    [playBtn addTarget:self action:@selector(playVideoAction) forControlEvents:(UIControlEventTouchUpInside)];
    [videoBGView addSubview:playBtn];
    
    _lookBtn = [self createBtn];
    [_lookBtn setImage:[UIImage imageNamed:@"眼睛-2"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_lookBtn];
    _discussBtn = [self createBtn];
    [_discussBtn setImage:[UIImage imageNamed:@"消息"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_discussBtn];
    _likeBtn = [self createBtn];
    [_likeBtn setImage:[UIImage imageNamed:@"赞"] forState:(UIControlStateNormal)];
    [self.contentView addSubview:_likeBtn];
    
    lineView = [[UIView alloc] init];
    lineView.backgroundColor = CCRGBColor(240, 240, 240);
    [self.contentView addSubview:lineView];
    
    lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor lightGrayColor];
    lineView1.alpha = 0.5;
    [self.contentView addSubview:lineView1];
    
    lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor lightGrayColor];
    lineView2.alpha = 0.5;
    [self.contentView addSubview:lineView2];
}

- (void)layout{
    _headImageView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(self.contentView, PXTOPT(30))
    .widthIs(PXTOPT(68))
    .heightIs(PXTOPT(68));
    
    _nameLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(22))
    .topSpaceToView(self.contentView, PXTOPT(36))
    .widthIs(KScreenW - PXTOPT(60 + 68))
    .heightIs(PXTOPT(29));
    
    _timeLabel.sd_layout
    .leftSpaceToView(_headImageView, PXTOPT(20))
    .topSpaceToView(_nameLabel, PXTOPT(14))
    .widthIs(KScreenW - PXTOPT(60 + 68))
    .heightIs(PXTOPT(21));
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_timeLabel, PXTOPT(38))
    .widthIs(KScreenW - PXTOPT(40))
    .heightIs(PXTOPT(34));
    
    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_titleLabel, PXTOPT(20))
    .widthIs(KScreenW - PXTOPT(56))
    .heightIs(PXTOPT(100));
    
    videoBGView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_contentLabel, PXTOPT(30))
    .widthIs(KScreenW - PXTOPT(40))
    .heightIs(PXTOPT(250));
    
    _videoImageView.sd_layout
    .leftEqualToView(videoBGView)
    .topEqualToView(videoBGView)
    .rightEqualToView(videoBGView)
    .bottomEqualToView(videoBGView);
    
    playBtn.sd_layout
    .centerXIs((KScreenW - PXTOPT(40)) / 2)
    .centerYIs(PXTOPT(250 / 2))
    .widthIs(50)
    .heightIs(50);
    
    _lookBtn.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(80))
    .topSpaceToView(videoBGView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    _discussBtn.sd_layout
    .centerXIs(KScreenW / 2)
    .topSpaceToView(videoBGView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    _likeBtn.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(80))
    .topSpaceToView(videoBGView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(PXTOPT(16));
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView, KScreenW / 3)
    .topSpaceToView(videoBGView, PXTOPT(26))
    .bottomSpaceToView(lineView, 15)
    .widthIs(0.5);
    
    lineView2.sd_layout
    .rightSpaceToView(self.contentView, KScreenW / 3)
    .topSpaceToView(videoBGView, PXTOPT(26))
    .bottomSpaceToView(lineView, 15)
    .widthIs(0.5);
}

- (UIButton *)createBtn {
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [btn setTitleColor:CCRGBColor(153, 153, 153) forState:(UIControlStateNormal)];
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, PXTOPT(-12), 0, 0);
    [btn setFont:[UIFont fontWithName:BFfont size:PXTOPT(20)]];
    return btn;
}


- (void)setModel:(BFCommunityModel *)model{
    if (_model) {
        _model = nil;
    }
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _model.iNickName;
    _timeLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_model.pTime] dateFormat:@"YYYY-MM-dd"];
    _titleLabel.text = _model.pTitle;
//    _contentLabel.attributedText = _model.pCcontAttributed;
    _contentLabel.text = _model.pDesc;
    [_videoImageView sd_setImageWithURL:[NSURL URLWithString:_model.pCover] placeholderImage:[UIImage imageNamed:@"组3"]];
    [_lookBtn setTitle:[NSString stringWithFormat:@"%ld",_model.pNum] forState:(UIControlStateNormal)];
    [_discussBtn setTitle:[NSString stringWithFormat:@"%ld",_model.commentCount] forState:(UIControlStateNormal)];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_model.likeCount] forState:(UIControlStateNormal)];
    
}

- (void)playVideoAction{
    NSLog(@"播放视频");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
