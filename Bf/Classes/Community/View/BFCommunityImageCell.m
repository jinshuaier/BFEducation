//
//  BFCommunityImageCell.m
//  Bf
//
//  Created by 春晓 on 2017/11/28.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCommunityImageCell.h"
#import <SDAutoLayout.h>
#import "BFCollectionViewImgCell.h"

@interface BFCommunityImageCell ()<UICollectionViewDelegate,UICollectionViewDataSource>
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
// 照片
@property (nonatomic , strong) UICollectionView *imgCollectionView;
// 看过
@property (nonatomic , strong) UIButton *lookBtn;
// 评论
@property (nonatomic , strong) UIButton *discussBtn;
// 点赞
@property (nonatomic , strong) UIButton *likeBtn;

// 图片数组
@property (nonatomic , strong) NSArray *imgArray;
@end

static NSString *imageCell = @"imageCell";
@implementation BFCommunityImageCell{
    UIView *lineView;
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = PXTOPT(16);
    CGFloat commentWH = (KScreenW - PXTOPT(40)) / 3 - PXTOPT(12);
    layout.itemSize = CGSizeMake(commentWH, commentWH);
    _imgCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    _imgCollectionView.backgroundColor = [UIColor whiteColor];
    _imgCollectionView.delegate = self;
    _imgCollectionView.dataSource = self;
    _imgCollectionView.scrollEnabled = NO;
    _imgCollectionView.userInteractionEnabled = NO;
    [_imgCollectionView registerClass:[BFCollectionViewImgCell class] forCellWithReuseIdentifier:imageCell];
    [self.contentView addSubview:_imgCollectionView];
    
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
    
    _imgCollectionView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_contentLabel, PXTOPT(30))
    .widthIs(KScreenW - PXTOPT(40))
    .heightIs((KScreenW - PXTOPT(40)) / 3);
    
    _lookBtn.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(80))
    .topSpaceToView(_imgCollectionView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    _discussBtn.sd_layout
    .centerXIs(KScreenW / 2)
    .topSpaceToView(_imgCollectionView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    _likeBtn.sd_layout
    .rightSpaceToView(self.contentView, PXTOPT(80))
    .topSpaceToView(_imgCollectionView, PXTOPT(30))
    .widthIs(70)
    .heightIs(PXTOPT(24));
    
    lineView.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .heightIs(PXTOPT(16));
    
    lineView1.sd_layout
    .leftSpaceToView(self.contentView, KScreenW / 3)
    .topSpaceToView(_imgCollectionView, PXTOPT(26))
    .bottomSpaceToView(lineView, 15)
    .widthIs(0.5);
    
    lineView2.sd_layout
    .rightSpaceToView(self.contentView, KScreenW / 3)
    .topSpaceToView(_imgCollectionView, PXTOPT(26))
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
    _model = model;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:_model.iPhoto] placeholderImage:[UIImage imageNamed:@"123"]];
    _nameLabel.text = _model.iNickName;
    _timeLabel.text = [BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_model.pTime] dateFormat:@"YYYY-MM-dd"];
    _titleLabel.text = _model.pTitle;
    _contentLabel.text = _model.pDesc;
    _imgArray = _model.postPhotoList;
    [_lookBtn setTitle:[NSString stringWithFormat:@"%ld",_model.pNum] forState:(UIControlStateNormal)];
    [_discussBtn setTitle:[NSString stringWithFormat:@"%ld",_model.commentCount] forState:(UIControlStateNormal)];
    [_likeBtn setTitle:[NSString stringWithFormat:@"%ld",_model.likeCount] forState:(UIControlStateNormal)];
    [_imgCollectionView reloadData];
}

#pragma mark -UICollectionView-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imgArray.count > 3) {
        return 3;
    }
    return _imgArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BFCollectionViewImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageCell forIndexPath:indexPath];
    NSDictionary *dic = _imgArray[indexPath.item];
    NSString *imgUrlStr = dic[@"pPUrl"];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:[UIImage imageNamed:@"组3"]];
    if (_imgArray.count >= 3 && indexPath.item == 2) {
        cell.totalCountLabel.hidden = NO;
        cell.totalCountLabel.text = [NSString stringWithFormat:@"共%lu张",(unsigned long)_imgArray.count];
    }else{
        cell.totalCountLabel.hidden = YES;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
