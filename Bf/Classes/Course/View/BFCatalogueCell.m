//
//  BFCatalogueCell.m
//  Bf
//
//  Created by 春晓 on 2017/12/21.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFCatalogueCell.h"

@implementation BFCatalogueCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        self.contentView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

- (void)setupUI{
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - PXTOPT(30) - 19, 0, 19, 60)];
    _imageView2.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:self.imageView2];
    self.chapterName2 = [[UILabel alloc] initWithFrame:CGRectMake(PXTOPT(30), 0, 183, 60)];
    self.chapterName2.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.chapterName2];
    
    
    
    _titleImgView = [[UIImageView alloc] initWithFrame:CGRectMake(PXTOPT(66), 0, 20, self.contentView.height)];
    _titleImgView.contentMode = UIViewContentModeCenter;
    [self.contentView addSubview:_titleImgView];
    
    _littleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleImgView.frame) + PXTOPT(20), 0, KScreenW - 20, 20)];
    _littleTitleLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(26)];
    _littleTitleLabel.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_littleTitleLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_titleImgView.frame) + PXTOPT(20), CGRectGetMaxY(_littleTitleLabel.frame) + PXTOPT(20), KScreenW - 20, 15)];
    _timeLabel.font = [UIFont fontWithName:BFfont size:PXTOPT(24)];
    _timeLabel.textColor = RGBColor(153, 153, 153);
    [self.contentView addSubview:_timeLabel];
    
    _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(KScreenW - 20 - PXTOPT(30), 0, 20, self.contentView.height)];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_imgView];
    
}

- (void)layout{
    
    _titleImgView.sd_layout
    .leftSpaceToView(self.contentView, PXTOPT(66))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView)
    .widthIs(20);
    
    _littleTitleLabel.sd_layout
    .leftSpaceToView(_titleImgView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topEqualToView(self.contentView)
    .heightIs(20);
    
    _timeLabel.sd_layout
    .leftSpaceToView(_titleImgView, PXTOPT(20))
    .rightSpaceToView(self.contentView, PXTOPT(20))
    .topSpaceToView(_littleTitleLabel, PXTOPT(20))
    .heightIs(15);
    
    _imgView.sd_layout
    .widthIs(20)
    .rightSpaceToView(self.contentView, PXTOPT(30))
    .topEqualToView(self.contentView)
    .bottomEqualToView(self.contentView);
}

- (void)setChapterType:(ChapterType)chapterType{
    _chapterType = chapterType;
    if (chapterType == ChapterType_Chapter) {
        self.chapterName2.hidden = NO;
        self.imgView.hidden = NO;
        self.imageView2.hidden = YES;
        _timeLabel.hidden = YES;
        _titleImgView.hidden = YES;
        _littleTitleLabel.hidden = YES;
        self.contentView.backgroundColor = RGBColor(248,250,252);
    }else if (chapterType == ChapterType_LittleChapter){
        self.chapterName2.hidden = NO;
        self.imgView.hidden = YES;
        self.imageView2.hidden = NO;
        _timeLabel.hidden = YES;
        _titleImgView.hidden = YES;
        _littleTitleLabel.hidden = YES;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }else if (chapterType == ChapterType_Course){
        self.chapterName2.hidden = YES;
        self.imgView.hidden = YES;
        self.imageView2.hidden = YES;
        _timeLabel.hidden = NO;
        _titleImgView.hidden = NO;
        _littleTitleLabel.hidden = NO;
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setNode:(BFCatalogueModel *)node{
    _node = node;
    if (node.isExpand) {
        if (node.chapterType == ChapterType_Chapter) {
            self.imageView2.image = [UIImage imageNamed:@"下拉"];
        }else if (node.chapterType == ChapterType_LittleChapter){
            _imgView.image = [UIImage imageNamed:@"返回拷贝4"];
        }
    }else{
        if (node.chapterType == ChapterType_Chapter) {
            self.imageView2.image = [UIImage imageNamed:@"下拉拷贝"];
        }else if (node.chapterType == ChapterType_LittleChapter){
            _imgView.image = [UIImage imageNamed:@"返回拷贝5"];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
