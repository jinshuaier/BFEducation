//
//  BFClassListCell.m
//  Bf
//
//  Created by 陈大鹰 on 2017/11/30.
//  Copyright © 2017年 陈大鹰. All rights reserved.
//

#import "BFClassListCell.h"
#import "BFTimeTransition.h"

@interface BFClassListCell()
/*背景view*/
@property (nonatomic,strong) UIView *backView;
/*课程封面*/
@property (nonatomic,strong) UIImageView *classImg;
/*课程名称*/
@property (nonatomic,strong) UILabel *classTitle;
/*课程时间*/
@property (nonatomic,strong) UILabel *classTime;
/*课程学分*/
@property (nonatomic,strong) UILabel *classScore;
/*课程人数*/
@property (nonatomic,strong) UILabel *classNumber;
/*课程报满*/
@property (nonatomic,strong) UIImageView *classFull;
/*系列标签*/
@property (nonatomic,strong) UILabel *setTagLabel;
/*视频直播标签*/
@property (nonatomic,strong) UILabel *liveTagLabel;
@end
@implementation BFClassListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.classImg];
        [self.backView addSubview:self.classTitle];
        [self.backView addSubview:self.classTime];
        [self.backView addSubview:self.classScore];
        [self.backView addSubview:self.classNumber];
        [self.backView addSubview:self.classFull];
        [self.backView addSubview:self.setTagLabel];
        [self.backView addSubview:self.liveTagLabel];
        self.classScore.hidden = YES;
    }
    return self;
}

-(void)layoutSubviews {
    
    self.backView.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 5)
    .bottomSpaceToView(self.contentView, 5);
    
    self.classImg.sd_layout
    .leftSpaceToView(self.backView, 10)
    .topSpaceToView(self.backView, 10)
    .bottomSpaceToView(self.backView, 10)
    .widthIs(109);
    
    self.classTitle.sd_layout
    .topSpaceToView(self.backView, 13)
    .leftSpaceToView(self.classImg, 13)
    .rightSpaceToView(self.backView, 20)
    .heightIs(16);

    
    self.classTime.sd_layout
    .topSpaceToView(self.classTitle,5)
    .leftSpaceToView(self.classImg, 13)
    .rightSpaceToView(self.backView, 20)
    .heightIs(11);
    
    self.classScore.sd_layout
    .bottomSpaceToView(self.backView, 10)
    .leftSpaceToView(self.classImg, 10)
    .widthIs(100)
    .heightIs(20);
    
    self.classNumber.sd_layout
    .bottomSpaceToView(self.backView, 11)
    .rightSpaceToView(self.backView, 10)
    .widthIs(100)
    .heightIs(11);
    
    self.classFull.sd_layout
    .bottomSpaceToView(self.backView, 18)
    .rightSpaceToView(self.backView, 10)
    .topSpaceToView(self.backView, 27)
    .heightIs(50)
    .widthIs(49);
    
    //系列标签
    self.setTagLabel.sd_layout
    .leftSpaceToView(self.classImg, 13)
    .bottomSpaceToView(self.backView, 10)
    .topSpaceToView(self.classTime, 17)
    .heightIs(16)
    .widthIs(30);
    //直播/视频标签
    self.liveTagLabel.sd_layout
    .leftSpaceToView(self.setTagLabel, 4)
    .bottomSpaceToView(self.backView, 10)
    .topSpaceToView(self.classTime, 17)
    .heightIs(16)
    .widthIs(30);
}

-(UIView *)backView {
    if (_backView == nil) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 4.0f;
    }
    return _backView;
}

-(UIImageView *)classImg {
    if (_classImg == nil) {
        _classImg = [[UIImageView alloc] init];
        _classImg.image = [UIImage imageNamed:@"组3"];
        _classImg.clipsToBounds = YES;
        _classImg.contentMode = UIViewContentModeScaleAspectFill;
        _classImg.layer.cornerRadius = 4.0f;
        _classFull.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _classImg;
}

-(UILabel *)classTitle {
    if (_classTitle == nil) {
        _classTitle = [[UILabel alloc] init];
        _classTitle.text = @"宝马车系列维修";
        _classTitle.font = [UIFont fontWithName:BFfont size:14.0f];
        _classTitle.textColor = RGBColor(51, 51, 51);
    }
    return _classTitle;
}

-(UILabel *)classTime {
    if (_classTime == nil) {
        _classTime = [[UILabel alloc] init];
        _classTime.text = @"11月22号 - 12月22号";
        _classTime.font = [UIFont fontWithName:BFfont size:11.0f];
        _classTime.textColor = RGBColor(102, 102, 102);
    }
    return _classTime;
}

-(UILabel *)setTagLabel {
    if (_setTagLabel == nil) {
        _setTagLabel = [[UILabel alloc] init];
        _setTagLabel.text = @"系列";
        _setTagLabel.font = [UIFont fontWithName:BFfont size:10.0f];
        _setTagLabel.textAlignment = NSTextAlignmentCenter;
        _setTagLabel.textColor = RGBColor(255, 73, 6);
        _setTagLabel.layer.borderColor = RGBColor(255, 73, 6).CGColor;
        _setTagLabel.layer.borderWidth = 1;
        _setTagLabel.layer.cornerRadius = 1.0f;
    }
    return _setTagLabel;
}

-(UILabel *)liveTagLabel {
    if (_liveTagLabel == nil) {
        _liveTagLabel = [[UILabel alloc] init];
        _liveTagLabel.text = @"直播";
        _liveTagLabel.font = [UIFont fontWithName:BFfont size:10.0f];
        _liveTagLabel.textAlignment = NSTextAlignmentCenter;
        _liveTagLabel.textColor = RGBColor(0, 126, 212);
        _liveTagLabel.layer.borderColor = RGBColor(0, 126, 212).CGColor;
        _liveTagLabel.layer.borderWidth = 1;
        _liveTagLabel.layer.cornerRadius = 1.0f;
    }
    return _liveTagLabel;
}

-(UILabel *)classScore {
    if (_classScore == nil) {
        _classScore = [[UILabel alloc] init];
        _classScore.text = @"300学分";
        _classScore.font = [UIFont fontWithName:BFfont size:13.0f];
        _classScore.textColor = [UIColor redColor];
    }
    return _classScore;
}

-(UILabel *)classNumber {
    if (_classNumber == nil) {
        _classNumber = [[UILabel alloc] init];
        _classNumber.text = @"剩余8人";
        _classNumber.font = [UIFont fontWithName:BFfont size:11.0f];
        _classNumber.textAlignment = NSTextAlignmentRight;
        _classNumber.textColor = RGBColor(102, 102, 102);
    }
    return _classNumber;
}

-(UIImageView *)classFull {
    if (_classFull == nil) {
        _classFull = [[UIImageView alloc] init];
        _classFull.image = [UIImage imageNamed:@"报满拷贝"];
        _classFull.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _classFull;
}

- (void)setCourseModel:(BFCourseModel *)courseModel{
    if (_courseModel) {
        _courseModel = nil;
    }
    _courseModel = courseModel;
    [_classImg sd_setImageWithURL:[NSURL URLWithString:_courseModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _courseModel.coverImg = image;
    }];
    _classTitle.text = _courseModel.ctitle;
    //    _classScore.text = [NSString stringWithFormat:@"%ld学分",_courseModel.cprice];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cstarttime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_courseModel.cendtime] dateFormat:@"MM月dd号"]];
    NSString *checkStr = GetFromUserDefaults(@"checkVersion");
    if ([checkStr isEqualToString:@"1"]) {
        _classFull.hidden = YES;
        _classNumber.text = @"";
    }
    else {
        if (_courseModel.ckey == 0) {
            _classFull.hidden = _courseModel.cnum == 0 ? NO : YES;
            _classNumber.text = [NSString stringWithFormat:@"剩余%ld人",_courseModel.cnum];
        }else{
            _classFull.hidden = YES;
            _classNumber.text = [NSString stringWithFormat:@"%ld人学习",_courseModel.cnum];
        }
    }
    if (_courseModel.cstate == 1) {
        NSLog(@"这是个系列课");
        self.liveTagLabel.hidden = YES;
    }
    else {
        self.setTagLabel.hidden = YES;
        self.liveTagLabel.hidden = YES;
//        self.liveTagLabel.text = _courseModel.ckey ? @"视频" : @"直播";
    }
}

- (void)setMyCourseModel:(BFMyCourseModel *)myCourseModel{
    if (_myCourseModel) {
        _myCourseModel = nil;
    }
    _myCourseModel = myCourseModel;
    [_classImg sd_setImageWithURL:[NSURL URLWithString:_myCourseModel.cCover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _classTitle.text = _myCourseModel.cTitle;
    //    _classScore.text = [NSString stringWithFormat:@"%ld学分",_setCourseModel.csprice];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_myCourseModel.cStartTime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%ld",_myCourseModel.cEndTime] dateFormat:@"MM月dd号"]];
    _classNumber.hidden = YES;
    _classFull.hidden = YES;
    _classScore.hidden = YES;
    _liveTagLabel.hidden = YES;
    _setTagLabel.hidden = YES;

}

-(void)setClassModel:(BFCollectClassModel *)classModel {
    _classModel = classModel;
    //    [_classImg sd_setImageWithURL:[NSURL URLWithString:_classModel.cscover] placeholderImage:[UIImage imageNamed:@"组3"]];
    _classTitle.text = classModel.cTitle;
    _classScore.text = [NSString stringWithFormat:@"%ld学分",_classModel.rCRedit];
    _classTime.text = [NSString stringWithFormat:@"%@-%@",[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_classModel.cStartDateTime] dateFormat:@"MM月dd号"],[BFTimeTransition timeWithTimeIntervalString:[NSString stringWithFormat:@"%@",_classModel.cEndDateTime] dateFormat:@"MM月dd号"]];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

